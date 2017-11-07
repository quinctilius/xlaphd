**STAT version 14.1
**15.11.16
**Merge File for ALL IgG trough data
****NOT to be merged with master datafile!!!!!
**** need to move directory at begining to move to dta folder so all 
*** these dta files are save there

cd "H:\PhD\Result Data\Stata files\dta files\IgG Trough Data"
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 1
order studyid, first
compress
save iggtrough1, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (2)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 2
compress
save iggtrough2, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (2)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 3
order studyid, first
compress
save iggtrough3, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (3)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 4
order studyid, first
compress
save iggtrough4, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (4)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 5
order studyid, first
save iggtrough5, replace
compress
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (5)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 6
order studyid, first
save iggtrough6, replace
compress
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (6)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 7
order studyid, first
save iggtrough7, replace
compress
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (7)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 8
order studyid, first
compress
save iggtrough8, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (8)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 9
order studyid, first
compress
save iggtrough9, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (9)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 10
order studyid, first
compress
save iggtrough10, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (10)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 11
order studyid, first
compress
save iggtrough11, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (11)") firstrow
drop studyid 
drop datetroughdatasrts
compress
gen studyid = 12
order studyid, first
save iggtrough12, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (12)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 13
order studyid, first
compress
save iggtrough13, replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
	sheet("IgG Trough Levels (13)") firstrow
drop studyid 
drop datetroughdatasrts
gen studyid = 14
order studyid, first
compress
save iggtrough14, replace

******merge
use iggtrough1
append using iggtrough2
append using iggtrough3
append using iggtrough4
append using iggtrough5
append using iggtrough6
append using iggtrough7
append using iggtrough8
append using iggtrough9
append using iggtrough10
append using iggtrough11
append using iggtrough12
append using iggtrough13
append using iggtrough14
drop lifetimemean
drop lifetimetroughsd



*****save**
compress
save iggtroughallbyyearmaster, replace
save iggtroughallbyyearworking, replace
export excel using "H:\PhD\Result Data\Excel Sheets\Exports from Stata\iggtroughall", replace firstrow(variables)

