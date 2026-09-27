*******************************************************
* HSCC example
*******************************************************

clear all
set more off

* Load your balanced panel
use "your_panel_data.dta", clear

* Declare panel structure
xtset id time

* HSCC with automatic DK lag
hscc y x1 x2 x3 x4

* HSCC with user-defined DK lag
hscc y x1 x2 x3 x4, lag(2)

* Stored results
matrix list e(b)
matrix list e(V)
matrix list e(mg_b)

display e(r2_w)
display e(heterogeneity_trace)
