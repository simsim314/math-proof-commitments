# Affine paucity for polynomial moment curves

Public timestamp and SHA-256 commitment for a self-contained proof manuscript extending known affine counting results to a class of polynomial moment curves.

**Author / originator:** Michael Simkin

**Initial public commitment:** October 13, 2026

**Status:** Full proof draft; independent proof review and global publication priority remain unverified.

The manuscript is kept private/local in `sources/`. This folder publishes its SHA-256 digest and an OpenTimestamps proof (`.ots`).

## Background and extension

Brandes and Wooley already established the four-variable classification and the sharp nonzero six-variable bound for the curves $(t,t^2,t^3)$ and $(t,t^2,t^4)$; see [*Structure and paucity in affine diagonal systems, I*](https://arxiv.org/abs/2602.02911), Theorems 1.1 and 1.3 and Corollaries 1.2 and 1.4.

The committed manuscript proves corresponding results for every fixed integer-coefficient polynomial $\phi$ of degree at least three whose third derivative has one sign on the whole real line. This includes every odd power $t^k$ with $k\ge 3$, and mixed-parity examples such as $t^5+t^4+t^3$. The coefficients are arbitrary within this class. The quartic case is already known separately and lies outside the manuscript's derivative condition.

## Mathematical claim

Write $\Gamma_\phi(t)=(t,t^2,\phi(t))$. For a positive integer $X$ and a shift $\mathbf h\in\mathbb Z^3$, let $R_r(X;\mathbf h)$ count ordered tuples with $1\le x_i,y_i\le X$ satisfying

```math
\sum_{i=1}^{r}\bigl(\Gamma_\phi(x_i)-\Gamma_\phi(y_i)\bigr)=\mathbf h.
```

For every $\varepsilon>0$, the manuscript proves the uniform classification

```math
R_2(X;\mathbf h)=
\begin{cases}
2X^2-X,&\mathbf h=0,\\
4X-4,&\mathbf h=\Gamma_\phi(a)-\Gamma_\phi(b),\quad 1\le a,b\le X,\ a\ne b,\\
O_{\phi,\varepsilon}(X^\varepsilon),&\text{otherwise}.
\end{cases}
```

In the second case all solutions have multisets $\{x_1,x_2\}=\{a,z\}$ and $\{y_1,y_2\}=\{b,z\}$ for some $1\le z\le X$. For every nonzero shift,

```math
R_3(X;\mathbf h)\ll_{\phi,\varepsilon}X^{2+\varepsilon},
```

and the exponent two is sharp. At zero shift,

```math
R_3(X;0)=6X^3-9X^2+4X.
```

These are counting results with three prescribed moments. The manuscript makes no claim of a new Waring–Goldbach summand record or eventual coverage of all integers by polynomial values at primes.

<!-- BEGIN AUTO FILE LINKS -->

## Committed files

All hashes: [`commitments/SHA256SUMS`](commitments/SHA256SUMS)

| File | SHA-256 | Timestamp proof |
|---|---|---|
| affine_odd_power_paucity.tex | `40b4e9797b6040e3c44e8bfa74f9e5fbafbf84a1579e2d0c83823dee603416be` | [.ots](commitments/affine_odd_power_paucity.tex.ots) |

<!-- END AUTO FILE LINKS -->

## Verification

With the original source placed in `sources/`, run from this folder:

```bash
sha256sum -c commitments/SHA256SUMS
ots upgrade commitments/affine_odd_power_paucity.tex.ots
ots verify commitments/affine_odd_power_paucity.tex.ots -f sources/affine_odd_power_paucity.tex
```

The commitment records the exact manuscript version. Subsequent revisions must use a new filename and a new commitment.
