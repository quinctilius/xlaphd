*importing the tab delim lft gli calculated data
clear
set more off
import delimited "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\lftcalculated.txt"
drop fev075- percpredfef75
*drop predfev llnfev ulnfev predfvc llnfvc ulnfvc predfevfvc llnfevfvc ulnfevfvc
rename id studyid
gen id = _n
order id, first
compress
**(for now)
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\glidata", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\lftstogli.xlsx", firstrow
drop if height ==.
keep studyid lftdate
gen id = _n
order id, first
merge 1:1 id using "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\glidata"
sort studyid age
drop id
gen lftyear = year(lftdate)
order lftyear, a(lftdate)
drop _merge
recode *(9999=.)
gen fevresult = 2 if fev >=llnfev & fev <=ulnfev
replace fevresult = 1 if fev <llnfev
replace fevresult = 3 if fev >ulnfev
label define fevresult_lb 1 "Low" 2"Normal" 3"High"
label values fevresult fevresult_lb
order fevresult, a(fev)
gen fvcresult = 2 if fvc >=llnfvc & fvc <=ulnfvc
replace fvcresult = 1 if fvc <llnfvc
replace fvcresult = 3 if fvc >ulnfvc
label define fvcresult_lb 1 "Low" 2"Normal" 3"High"
label values fvcresult fvcresult_lb
order fvcresult, a(fvc)
gen fevfvcresult = 2 if fevfvc >=llnfevfvc & fevfvc <=ulnfevfvc
replace fevfvcresult = 1 if fevfvc <llnfevfvc
replace fevfvcresult = 3 if fevfvc >ulnfevfvc
label define fevfvcresult_lb 1 "Low" 2"Normal" 3"High"
label values fevfvcresult fevfvcresult_lb
order fevfvcresult, a(fevfvc)
sort studyid lftdate
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\glidataformatted", replace
merge m:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"
** dropping post surgery lung data
drop if lftyear > lungsurgeryyear
keep studyid-zfevfvc datediagnosis age agegroup bronchiectasis bronchdxdate1 everbronchiectasis bsi ctprogression prophylacticabx prexlabronch ///
physio yeardxbronch yeardxbronch1 agedxbronch 
gen yeardiagnosis=year(datediagnosis)
label variable yeardiagnosis "Year of Agamma Diagnosis"
order datediagnosis yeardiagnosis, a(studyid)
gen lftpostdx = lftyear-yeardiagnosis
label variable lftpostdx "Time of LFT post Agamma Diagnosis(Whole Years)"
order lftpostdx,a(lftyear)
label variable lftyear "Year of LFT"
label variable sex "Sex"
label variable age "Age"
label variable height "Height(cm)"
label variable ethnic "Ethnicity (as GLI Software)"
label variable fev "FEV1"
label variable fevresult "Is FEV1 Normal, Low or High?"
label variable predfev "Pedicited FEV1"
label variable llnfev "LLN of FEV1"
label variable ulnfev "ULN of FEV1"
label variable zfev "Z Score of FEV1"
label variable percpredfev "% Predicted FEV1"
label variable fvc "FVC"
label variable fvcresult "Is FVC Normal, Low or High?"
label variable predfvc "Pedicited FVC"
label variable llnfvc "LLN of FVC"
label variable ulnfvc "ULN of FVC"
label variable zfvc "Z Score of FVC"
label variable percpredfvc "% Predicted FVC"
label variable fevfvc "FEV:FVC Ratio"
label variable fevfvcresult "Is FEV:FVC Ratio Normal, Low or High?"
label variable predfevfvc "Pedicited FEV:FVC Ratio"
label variable llnfevfvc "LLN of FEV:FVC Ratio"
label variable ulnfevfvc "ULN of FEV:FVC Ratio"
label variable zfevfvc "Z Score of FEV:FVC Ratio"
sort studyid lftdate
***Dropping Duplicates
*quietly by studyid lftdate: gen dup = cond(_N==1,0,_n)
*drop if dup>1
*drop if zfev ==.
*drop if lftpostdx ==.
*drop dup
gen year = lftyear
gen lfttobronch = (bronchdxdate-lftdate)/365.25
replace lfttobronch = 0 if lfttobronch <=0
label variable lfttobronch "Time from LFT to Bronchiectasis"

compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\finallftdata", replace

