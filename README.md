# math-proof-commitments

Public timestamps and SHA-256 commitments for mathematical work by Michael Simkin.

The source manuscripts are kept private. Each project folder publishes only:

- `commitments/SHA256SUMS`: the SHA-256 digest of every committed source file;
- `commitments/*.ots`: an [OpenTimestamps](https://opentimestamps.org) proof for each file, anchored in the Bitcoin blockchain.

When a source file is revealed later, anyone can check that its contents match the commitment and existed no later than the timestamp.

<!-- BEGIN AUTO PROJECT LIST -->

## Projects

- [Bombieri's Problem 2](bombieri-problem2/)
- [Lattice sphere packing](lattice-sphere-packing/)

<!-- END AUTO PROJECT LIST -->

## Layout

```
<project>/
├── README.md        claim and table of committed files
├── sources/         private originals — never committed (gitignored)
└── commitments/
    ├── SHA256SUMS
    └── <file>.ots
```

## Verification

From a project folder, with the original files placed in `sources/`:

```bash
sha256sum -c commitments/SHA256SUMS
ots upgrade commitments/FILE.tex.ots
ots verify commitments/FILE.tex.ots -f sources/FILE.tex
```

The `.ots` proof commits to the exact contents of the file, not its name or path.

## Adding commitments

Put new files in `<project>/sources/` and run `./stamp_new_files.sh`. It hashes them, submits new files to the OpenTimestamps calendars, updates the READMEs, commits and pushes. Existing commitments are verified and never replaced; an edited source must be committed under a new filename.
