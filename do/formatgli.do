*Formatting of Access LFT Data for GLI program
**Stata 14.1
clear
set more off
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\lftstogli.xlsx", firstrow
gen ethnicity = 1 if race == "Caucasian"
replace ethnicity = 2 if race == "African Ammerican"
replace ethnicity = 3 if race == "North East Asian"
replace ethnicity = 4 if race == "South East Asian"
replace ethnicity = 5 if race == "Mixed|Other"
drop race
order ethnicity, a(height)
gen sex = 1 if Sex == "Male"
replace sex=2 if Sex =="Female"
drop Sex
order sex, a(studyid)
rename studyid id
gen age = (lftdate-dob)/365.25
drop dob
drop lftdate
order age, a(sex)
rename FEV1 fev
rename FVC fvc
rename ratio fevfvc
drop if height ==.
gen fev75 = 9999
gen fev75ratio = 9999
gen fef2575 = 9999
gen fef75 = 9999
recode *(.=9999)
recode *(0=9999)
rename ethnicity ethnic
replace fevfvc = 1.00 if fevfvc >1.00
export excel using "H:\PhD\Result Data\Excel Sheets\Exports from Stata\lftsgliformat.xlsx", firstrow(variables) replace
export delim using "H:\PhD\Result Data\Excel Sheets\Exports from Stata\lftsgliformat.txt", delim (tab) replace
