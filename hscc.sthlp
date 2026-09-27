{smcl}
{* *! hscc 1.0.1 27sep2026}{...}

{title:Title}

{phang}
{bf:hscc} {hline 2} Heterogeneous-Slope SCC estimator with joint partial pooling
and HC3-adjusted Driscoll-Kraay inference


{title:Syntax}

{p 8 17 2}
{cmd:hscc} {depvar} {indepvars} {ifin}
[{cmd:,} {opt lag(#)}]


{title:Description}

{pstd}
{cmd:hscc} estimates a heterogeneous-slope panel model in which unit-specific
slopes are decomposed into a central slope, systematic heterogeneity related to
unit-level regressor means, and residual unit-specific slope deviations.

{pstd}
The residual slope deviations are jointly estimated under a quadratic penalty
derived from the estimated residual slope covariance matrix. The final
covariance matrix uses HC3-adjusted observation scores aggregated across units
by time and a Bartlett Driscoll-Kraay HAC estimator.

{pstd}
The data must be {cmd:xtset} before estimation. Version 1.0 requires a strongly
balanced estimation sample.


{title:Model}

{pstd}
The slope structure is

{p 8 8 2}
beta_i = beta + Gamma z_i + eta_i,

{pstd}
where beta is the central/average slope vector, z_i contains centered unit
means of the regressors, and eta_i is residual slope heterogeneity subject to

{p 8 8 2}
sum_i eta_i = 0.

{pstd}
The joint estimator minimizes the within-transformed residual sum of squares
plus a quadratic penalty on eta_i.


{title:Options}

{phang}
{opt lag(#)} sets the maximum Bartlett HAC lag. If omitted, {cmd:hscc} uses

{p 12 12 2}
floor(4*(T/100)^(2/9))

{pstd}
with a minimum of 1.


{title:Examples}

{phang2}{cmd:. xtset i time}

{phang2}{cmd:. hscc GGI lnREC lnT GPATDE FD}

{phang2}{cmd:. hscc GGI lnREC lnT GPATDE FD, lag(2)}


{title:Stored results}

{pstd}
{cmd:hscc} stores the following in {cmd:e()}:

{synoptset 24 tabbed}{...}
{synopt:{cmd:e(b)}}HSCC central slope estimates{p_end}
{synopt:{cmd:e(V)}}HC3 Driscoll-Kraay covariance matrix{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of panel units{p_end}
{synopt:{cmd:e(T)}}number of time periods{p_end}
{synopt:{cmd:e(lag)}}DK/HAC lag{p_end}
{synopt:{cmd:e(df_r)}}T-1 degrees of freedom used for inference{p_end}
{synopt:{cmd:e(heterogeneity_trace)}}trace of the estimated residual slope covariance{p_end}
{synopt:{cmd:e(r2_w)}}descriptive within R-squared, 1-SSE/SST on within-transformed data{p_end}
{synopt:{cmd:e(mg_b)}}conventional mean-group point-estimate benchmark{p_end}


{title:Remarks}

{pstd}
The version 1.0 covariance is a first-order HC3-DK approximation. Monte Carlo
validation for the motivating N=31, T=20 design indicated mild small-T
undercoverage. Results close to conventional significance thresholds should
therefore be interpreted with appropriate caution.

{pstd}
The estimator is not tuned to preserve statistical significance.


{title:Version}

{pstd}
HSCC 1.0.1, 27 September 2026.
