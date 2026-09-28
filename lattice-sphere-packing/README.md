# Lattice sphere packing

Public timestamp and SHA-256 commitment for candidate proofs of improved lattice sphere-packing lower bounds, including the full $\kappa=1$ logarithmic gain.

**Author / originator:** Michael Simkin  
**Initial public commitment:** September 11, 2026

This folder records public cryptographic commitments to mathematical work concerning lower bounds for lattice sphere packing.

The source manuscripts themselves are kept private/local (in `sources/`, never committed). This folder publishes their SHA-256 digests in [`commitments/SHA256SUMS`](commitments/SHA256SUMS) and an OpenTimestamps proof (`.ots`) for each file.

## Mathematical claim

The work concerns the progression

```math
\kappa=\frac{1}{1+e},
```

then constructions approaching

```math
\kappa=1-\varepsilon,
```

and finally a candidate full $\kappa=1$ construction yielding

```math
\Delta_d^L \ge c\,d^2\log\log d\,2^{-d}.
```

More precisely, for a positive integer $d$, let $\Delta_d^L$ denote the maximum density of a lattice sphere packing in $d$-dimensional Euclidean space.

The claimed theorem is:

> There exist universal constants $c>0$ and $d_0$ such that, for every integer $d\ge d_0$,
>
> ```math
> \Delta_d^L \ge c\,d^2\log\log d\,2^{-d}.
> ```

This is the full logarithmic gain, corresponding to $\kappa=1$ in the notation

```math
(\log\log d)^\kappa.
```

<!-- BEGIN AUTO FILE LINKS -->

## Committed files

All hashes: [`commitments/SHA256SUMS`](commitments/SHA256SUMS)

| File | SHA-256 | Timestamp proof |
|---|---|---|
| Appendices_A_B.tex | `006445340f5526554be0a1185326a718769b62d9661991330f505612ca659412` | [.ots](commitments/Appendices_A_B.tex.ots) |
| Simkin_Lattice_Sphere_Packing_Preprint.tex | `233aa92e1aae7d49f9738c61b8f585e25c02423ca0a99dd7594adc2eb3f05642` | [.ots](commitments/Simkin_Lattice_Sphere_Packing_Preprint.tex.ots) |
| simplified_kappa_1_divisor_star.tex | `cd6558aad76bb7c3d5106ed6dfe8897e74cba74a1c2b405efad4ab3d98febd59` | [.ots](commitments/simplified_kappa_1_divisor_star.tex.ots) |

<!-- END AUTO FILE LINKS -->

## Verification

With the original sources placed in `sources/`, run from this folder:

```bash
sha256sum -c commitments/SHA256SUMS
ots verify commitments/FILE.tex.ots -f sources/FILE.tex
```

The manuscript and appendices may subsequently be modified, reviewed, or developed collaboratively. Later versions can therefore differ from the exact versions represented by these commitment files.
