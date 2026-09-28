#!/usr/bin/env bash
set -euo pipefail

# Layout, per project:
#   <project>/sources/       private originals (gitignored, never committed)
#   <project>/commitments/   SHA256SUMS + <relative path>.ots
#
# Usage:
#   ./commit_new_files.sh                 hash + stamp new sources, update READMEs, commit, push
#   ./commit_new_files.sh --readmes-only  only regenerate README tables (no stamping, no git)

cd "$(dirname "$0")"

update_readmes() {
python3 <<'PY'
from pathlib import Path

def replace_block(path, begin, end, block):
    text = path.read_text(encoding="utf-8")
    full = f"{begin}\n{block}\n{end}"
    if begin in text and end in text:
        before = text.split(begin, 1)[0]
        after = text.split(end, 1)[1]
        text = before + full + after
    else:
        text = text.rstrip() + "\n\n" + full + "\n"
    path.write_text(text, encoding="utf-8")

projects = sorted(p.parent.parent for p in Path(".").glob("*/commitments/SHA256SUMS"))

# Per-project table of committed files.
for proj in projects:
    rows = []
    for line in (proj / "commitments/SHA256SUMS").read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        digest, src = line.split("  ", 1)
        rel = src.removeprefix("sources/")
        ots = Path("commitments") / (rel + ".ots")
        proof = f"[.ots]({ots.as_posix()})" if (proj / ots).exists() else "pending"
        rows.append(f"| {rel} | `{digest}` | {proof} |")
    block = (
        "\n## Committed files\n\n"
        "All hashes: [`commitments/SHA256SUMS`](commitments/SHA256SUMS)\n\n"
        "| File | SHA-256 | Timestamp proof |\n"
        "|---|---|---|\n"
        + "\n".join(rows) + "\n"
    )
    readme = proj / "README.md"
    if not readme.exists():
        readme.write_text(f"# {proj.name}\n", encoding="utf-8")
    replace_block(readme, "<!-- BEGIN AUTO FILE LINKS -->", "<!-- END AUTO FILE LINKS -->", block)

# Root list of projects.
items = []
for proj in projects:
    first = (proj / "README.md").read_text(encoding="utf-8").splitlines()[0]
    title = first.lstrip("# ").strip() or proj.name
    items.append(f"- [{title}]({proj.name}/)")
block = "\n## Projects\n\n" + "\n".join(items) + "\n"
replace_block(Path("README.md"), "<!-- BEGIN AUTO PROJECT LIST -->", "<!-- END AUTO PROJECT LIST -->", block)
PY
}

if [[ "${1:-}" == "--readmes-only" ]]; then
    update_readmes
    exit 0
fi

# Never publish private sources.
if [[ -n "$(git ls-files -- '*/sources/*')" ]]; then
    echo "ERROR: files under sources/ are tracked by git:"
    git ls-files -- '*/sources/*'
    exit 1
fi

for srcdir in */sources; do
    [[ -d "$srcdir" ]] || continue
    proj=$(dirname "$srcdir")
    sums="$proj/commitments/SHA256SUMS"
    mkdir -p "$proj/commitments"
    touch "$sums"

    while IFS= read -r -d '' f; do
        rel=${f#"$srcdir/"}
        entry="sources/$rel"
        ots="$proj/commitments/$rel.ots"
        actual=$(sha256sum "$f" | awk '{print $1}')

        # Existing SHA commitments are verified and never silently replaced.
        expected=$(awk -v p="$entry" 'substr($0, 67) == p {print $1}' "$sums")
        if [[ -n "$expected" ]]; then
            if [[ "$expected" != "$actual" ]]; then
                echo "ERROR: existing SHA-256 commitment does not match: $f"
                echo "expected: $expected"
                echo "actual:   $actual"
                echo "Use a new filename/version rather than overwriting a committed source."
                exit 1
            fi
            echo "verified: $f"
        else
            printf '%s  %s\n' "$actual" "$entry" >> "$sums"
            echo "added:    $f -> $sums"
        fi

        # `ots stamp` creates the .ots file AND immediately submits the
        # commitment to the OpenTimestamps calendar servers.
        if [[ -f "$ots" ]]; then
            echo "exists:   $ots"
        else
            if [[ -e "$f.ots" ]]; then
                echo "ERROR: stray $f.ots in sources/; move or remove it first"
                exit 1
            fi
            echo "stamping and submitting to OpenTimestamps calendars: $f"
            ots stamp "$f"
            [[ -f "$f.ots" ]] || {
                echo "ERROR: OpenTimestamps did not create $f.ots"
                exit 1
            }
            mkdir -p "$(dirname "$ots")"
            mv "$f.ots" "$ots"
            echo "submitted: $ots"
        fi
    done < <(find "$srcdir" -type f ! -name '*.ots' -print0 | sort -z)
done

update_readmes

# Stage only whitelisted files; never `git add .`.
git add .gitignore README.md commit_new_files.sh stamp_new_files.sh
git add -- */README.md */commitments/SHA256SUMS
find . -path './*/commitments/*' -name '*.ots' -type f -print0 | xargs -0 -r git add --

echo
git status --short
echo

if git diff --cached --quiet; then
    echo "Nothing new to commit."
    exit 0
fi

git commit -m "Update proof commitments"
git push origin HEAD

echo
echo "New .ots files were submitted to OpenTimestamps calendars by 'ots stamp'."
echo "Bitcoin anchoring may still be pending."
