clear
set more off
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\currentiggtherapy.xlsx", firstrow
keep studyid currentbrand currentinterval currentdose
destring studyid, replace
sort studyid

gen dosesperyear=52/currentinterval
gen currentprice=((currentdose/1.6)*65.12)*dosesperyear if currentbrand == "Subcuvia"
replace currentprice=((currentdose/2)*91.80)*dosesperyear if currentbrand == "Hizentra"
replace currentprice=((currentdose/10)*459)*dosesperyear if currentbrand == "Privigen"
replace currentprice=((currentdose/0.5)*30)*dosesperyear if currentbrand == "Flebogamma"
drop dosesperyear
label variable currentprice "Yearly Ig Cost Based on Current Dose"
compress
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggcost", replace
