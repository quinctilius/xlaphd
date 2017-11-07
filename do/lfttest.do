**Littel test fot lft data to make a nice graph!
*This test drops all kids, blanks FEV1 data, same year data and then reshapes wide to got excel
clear
set more off
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\finallftdata"
keep studyid lftpostdx zfev agegroup
drop if agegroup==1
br studyid lftpostdx zfev
sort studyid lftpostdx
quietly by studyid lftpostdx: gen dup = cond(_N==1,0,_n)
drop if dup>1
drop if zfev ==.
drop if lftpostdx ==.
drop dup
reshape wide zfev, i(studyid) j(lftpostdx)
br
* Need to somehow only select 1st and last value then plot join these and plot somwhere, prbably excel or sigma
