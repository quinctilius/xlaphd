*Test for plotting means over time
**First one is IgG trough levels over years 
*i.e. what have been our target trough levels
**needs to look pretty but this looks to have the basic concept
clear
set more off
*set graphics off
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetreshape.dta"
merge m:m studyid year using "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\finallftdata"
gen yrpostdx = year-yeardiagnosis
replace yrpostdx=. if year<yeardiagnosis
compress
save "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\overtimedata", replace

twoway (scatter zfev yrpostdx if everbronchiectasis == 0, mcolor(red)) ///
(scatter zfev yrpostdx if everbronchiectasis == 1, mcolor(orange)) (lfit zfev yrpostdx if everbronchiectasis == 1, lcolor(orange) lwidth(medthick)) ///
(lfit zfev yrpostdx if everbronchiectasis == 0, lcolor(red) lwidth(medthick)), ytitle(FEV Z Score) ytitle(, margin(medium)) ///
xtitle(Years Post Diagnosis of XLA) xtitle(, margin(medium)) ///
title(FEV Z Scores Over Time, margin(medium)) legend(order(1  "Never Bronchiectasis"  2   "Ever Bronchiectasis"))
graph export "H:\PhD\Result Data\Graphs\lft graphs\lftsovertimev2.eps", replace


****Setup of LFT data over time*******************************************************
collapse (median) avgzfev=zfev (sd)sdzfev=zfev if everbronchiectasis ==1, by (yrpostdx) 
gen fevlb=avgzfev-sdzfev
gen fevub=avgzfev+sdzfev
twoway (scatter avgzfev yrpostdx , msymbol(square)) ///
(line avgzfev yrpostdx, c(L..)) (rcap fevlb fevub yrpostdx), legend(off)
gen everbronchiectasis=1
save "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\bronchlft", replace
clear 
use "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\overtimedata"
** This should probably be median!!!
collapse (median) avgzfev=zfev (sd)sdzfev=zfev if everbronchiectasis ==0, by (yrpostdx) 
gen fevlb=avgzfev-sdzfev
gen fevub=avgzfev+sdzfev
twoway (scatter avgzfev yrpostdx , msymbol(square)) ///
(line avgzfev yrpostdx, c(L..)) (rcap fevlb fevub yrpostdx), legend(off)
gen everbronchiectasis=0
save "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\nobronchlft", replace
merge 1:1 yrpostdx everbronchiectasis using "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\bronchlft"
twoway (line avgzfev yrpostdx if everbronchiectasis==0) ///
 (line avgzfev yrpostdx if everbronchiectasis==1), yline(-1.64,lpattern(dash) lcolor(black)) ytitle(FEV Z Score) ///
 xtitle(Years Post Diagnosis) title(Changes in Lung Function Over Time) ///
legend(order(1 "Never Bronchiectasis" 2 "Ever Bronchiectasis"))
graph export "H:\PhD\Result Data\Graphs\lft graphs\lftsovertime.eps", replace


*******************************************************************************


