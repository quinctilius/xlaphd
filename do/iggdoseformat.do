clear
set more off
import excel using "H:\PhD\Database\iggdoses.xlsx", ///
		sheet("stataexport") firstrow
drop if studyid ==.
destring studyid, replace
sort studyid
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\iggdoses", replace
do h:\open.do
keep studyid
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Working Copies\iggdoses"
drop if _merge !=3
**This next bit will need editing as time goes by
drop route2018 dose2018 route2017 dose2017 
reshape long dose route, i(studyid) j(year)
replace dose =. if dose==0
drop _merge
replace route="." if route != "IV" & route !="SC" & route !="IV/SC"
reshape wide
order studyid dose* route*
compress 
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\iggdoses", replace

