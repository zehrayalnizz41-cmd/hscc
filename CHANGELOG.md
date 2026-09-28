# Changelog

## 1.0.2 — 2026-09-28

- Added optional common time fixed effects via the `timefe` option.
- Time effects are partialled out from the joint HSCC design using an FWL-equivalent transformation.
- Time effects are treated as common nuisance parameters and are kept outside the heterogeneous-slope blocks.
- Retained the frozen HSCC-JOINT point-estimator architecture.
- Retained HC3-adjusted Driscoll–Kraay / SCC inference.
- Added reporting of time fixed-effects status in the estimation output.

## 1.0.1 — 2026-09-27

- Added descriptive HSCC within R-squared (`e(r2_w)`).
- Retained frozen HSCC-JOINT point-estimator architecture.
- Retained HC3-adjusted Driscoll–Kraay / SCC inference.
- Added fixed-N, large-T theoretical documentation.
- Added validation and reproducibility documentation.

## 1.0.0 — 2026-09-27

- Initial Stata command.
- Joint partial-pooling heterogeneous-slope estimator.
- Systematic + residual slope heterogeneity.
- PSD-corrected residual slope covariance.
- HC3-DK covariance.
