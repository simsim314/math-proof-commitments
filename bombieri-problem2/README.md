# Bombieri's Problem 2

Public timestamp and SHA-256 commitment for a candidate complete solution of Bombieri's Problem 2 on the Weil quadratic functional, and its extension to certified finite-window spectral theory for the Weil form.

**Author / originator:** Michael Simkin  
**Initial public commitment:** September 29, 2026

This folder records public cryptographic commitments to mathematical work concerning Bombieri's variational problem for Weil's explicit-formula quadratic functional.

The source manuscripts themselves are kept private/local (in `sources/`, never committed). This folder publishes their SHA-256 digests in [`commitments/SHA256SUMS`](commitments/SHA256SUMS) and an OpenTimestamps proof (`.ots`) for each file.

## Mathematical claim

Bombieri's Problem 2 asks: for a finite union of intervals $E\Subset(0,\infty)$, minimize Weil's quadratic functional $T[f*f^*]$ on the unit sphere of $L^2(E)$.

The claimed theorem is that the minimum $\mathcal B(E)$ is determined exactly by explicit finite certified lower and upper bounds,

```math
\mathcal B(E)=\sup_{c,N}L_{E,c,N}=\inf_N U_{E,N},
```

so that for every effectively presented $E$ and every $\varepsilon>0$ one obtains finite rigorous bounds $L\le\mathcal B(E)\le U$ with $U-L<\varepsilon$. The analogous common-limit identity is claimed for the $k$th localized Weil eigenvalue, for every fixed $k\ge1$.

A companion manuscript applies the same exact-symbol capping machinery to the finite-window spectral theory of the localized Weil operator $A_a$ on $(-a,a)$: certified approximation of the canonical deficiency vectors and of the characteristic entire function $W(a,\lambda,\theta;z)$, and a proof (without assuming the Riemann Hypothesis) that the Fourier image of $\mathcal H(T_a)$ is a de Branges space for every $\lambda<\lambda_a$. These are finite-window statements; no large-window limit or Riemann Hypothesis is assumed or claimed.

<!-- BEGIN AUTO FILE LINKS -->

## Committed files

All hashes: [`commitments/SHA256SUMS`](commitments/SHA256SUMS)

| File | SHA-256 | Timestamp proof |
|---|---|---|
| bombieri_problem2_full_paper.tex | `cb294a5e77f1d873e6939ace9484e029a08e0997ab2f02286b7dfe7c3ad818f5` | [.ots](commitments/bombieri_problem2_full_paper.tex.ots) |
| bombieri_to_finite_window_spectral_theory.tex | `512cb683e6c9e06ff165fd34560ee451b5ebe068f63957c1acaafac5dcb47dfb` | [.ots](commitments/bombieri_to_finite_window_spectral_theory.tex.ots) |

<!-- END AUTO FILE LINKS -->

## Verification

With the original sources placed in `sources/`, run from this folder:

```bash
sha256sum -c commitments/SHA256SUMS
ots verify commitments/FILE.tex.ots -f sources/FILE.tex
```

The manuscripts may subsequently be modified, reviewed, or developed collaboratively. Later versions can therefore differ from the exact versions represented by these commitment files.
