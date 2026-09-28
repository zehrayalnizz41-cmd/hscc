# HSCC for Stata

## Heterogeneous-Slope SCC Estimator

`hscc` is a Stata research command for a heterogeneous-slope panel estimator that combines:

- joint partial pooling of heterogeneous slopes,
- systematic slope heterogeneity,
- residual slope heterogeneity,
- data-driven quadratic shrinkage,
- HC3-adjusted Driscoll–Kraay / SCC inference,
- optional common time fixed effects.

The contribution is in the **point-estimation layer**. Driscoll–Kraay is retained as the inference framework.

## Status

**Version:** 1.0.2  
**Status:** Release Candidate (research software)

The point-estimator architecture is frozen. Version 1.0.2 adds optional common time fixed effects through the `timefe` option while retaining the HSCC-JOINT partial-pooling architecture and HC3-adjusted Driscoll–Kraay / SCC inference.

The fixed-`N`, large-`T` asymptotic framework establishes the following under stated regularity conditions:

- consistency,
- first-order asymptotic normality,
- first-order irrelevance of a bounded estimated penalty,
- consistency of the HC3-DK covariance under standard HAC conditions.

The current theory does **not** claim a general double-asymptotic result for `N,T -> infinity`, nor a general result under strong common-factor endogeneity.

## Installation

Install directly from GitHub:

```stata
net install hscc, from("https://raw.githubusercontent.com/zehrayalnizz41-cmd/hscc/main") replace
```

Then verify the installed version:

```stata
discard
which hscc, all
help hscc
```

Alternatively, copy:

- `hscc.ado`
- `hscc.sthlp`

to your Stata PERSONAL ado directory.

Find that directory with:

```stata
sysdir
```

## Syntax

```stata
hscc depvar indepvars [if] [in] [, lag(#) timefe]
```

The data must first be declared as panel data:

```stata
xtset panelvar timevar
```

Version 1.0.2 requires a strongly balanced estimation sample.

### Options

- `lag(#)` specifies the Driscoll–Kraay / SCC lag length.
- `timefe` adds common time fixed effects. The time effects are partialled out from the joint HSCC design and are treated as common nuisance effects rather than heterogeneous-slope parameters.

## Examples

Basic estimation:

```stata
xtset i time
hscc GGI lnREC lnT GPATDE FD
```

With a user-specified DK lag:

```stata
hscc GGI lnREC lnT GPATDE FD, lag(2)
```

With common time fixed effects:

```stata
hscc GGI lnREC lnT GPATDE FD, timefe
```

With both common time fixed effects and a user-specified DK lag:

```stata
hscc GGI lnREC lnT GPATDE FD, timefe lag(2)
```

## Model

The unit-specific slope vector is decomposed as

\[
\beta_i = \beta + \Gamma z_i + \eta_i,
\]

with

\[
\sum_{i=1}^{N}\eta_i = 0.
\]

Here:

- `beta` is the central / average slope vector,
- `Gamma z_i` captures systematic slope heterogeneity,
- `eta_i` captures residual unit-specific slope heterogeneity.

The residual slope covariance is estimated after subtracting estimated sampling noise and applying a positive-semidefinite projection:

\[
\widehat{\Sigma}_{\eta}
=
\Pi_{PSD}
\left[
S_r-\frac{1}{N}\sum_i \widehat V_i
\right].
\]

The residual slope deviations are regularized by

\[
P_\eta
=
\widehat{\sigma}_u^2
(\widehat{\Sigma}_\eta+\varepsilon I)^{-1}.
\]

The joint estimator is

\[
\widehat{\theta}_{HSCC}
=
(D'D+P)^{-1}D'\widetilde y.
\]

The first `K` elements form the reported central slope estimator.

## Common time fixed effects

When `timefe` is specified, HSCC controls for additive common time effects:

\[
y_{it}=\alpha_i+\lambda_t+x_{it}'\beta_i+u_{it},
\]

where `lambda_t` denotes the common time effect.

The time effects are partialled out from the complete joint HSCC design using an FWL-equivalent transformation. They are **not** included in the heterogeneous-slope blocks and are **not** subject to the HSCC penalty. Thus, `timefe` controls for common period shocks while preserving the heterogeneous-slope structure of the estimator.

## Inference

The current release uses:

1. HC3-adjusted residuals,
2. cross-sectional aggregation of score contributions by time,
3. Bartlett HAC weighting,
4. Driscoll–Kraay / SCC covariance,
5. `t(T-1)` critical values.

If `lag()` is omitted:

\[
L=\max\left\{1,\left\lfloor4(T/100)^{2/9}\right\rfloor\right\}.
\]

The methodological contribution of HSCC is in the **joint partial-pooling point estimator**. Driscoll–Kraay / SCC is retained as the robust inference layer.

## Stored results

```stata
matrix list e(b)
matrix list e(V)
matrix list e(mg_b)

display e(N)
display e(N_g)
display e(T)
display e(lag)
display e(r2_w)
display e(heterogeneity_trace)
display "`e(timefe)'"
```

`e(timefe)` is nonempty when common time fixed effects are requested.

## Descriptive within R-squared

`e(r2_w)` stores

\[
R^2_{within,HSCC}
=
1-\frac{SSE_{HSCC}}{SST_{within}}.
\]

Because HSCC fitted values include central slopes, systematic slope heterogeneity, and residual slope deviations, this is reported as a **descriptive HSCC within R-squared** rather than as the conventional pooled-FE within R-squared.

When `timefe` is used, the reported measure refers to the time-effect-partialled joint HSCC system.

## Reproducibility check

For the motivating balanced panel (`N=31`, `T=20`), the command reproduced the frozen reference implementation:

```text
lnREC     20.53909
lnT       -1.158744
GPATDE     0.2549037
FD        25.67924

Within R-squared = 0.8535
```

## Validation

See:

- `VALIDATION.md`
- `THEORY.md`
- `CHANGELOG.md`

## Citation

Author: **Zehra Yalnız**.

The repository URL/DOI and associated manuscript citation will be added after public release.

## License

This project is released under the **MIT License**.

Copyright © 2026 **Dr. Zehra Yalnız and Prof. Dr. Figen Büyükakın**.

See the `LICENSE` file in the repository for the full license text.
