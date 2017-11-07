clear
set more off
do h:\open.do

putexcel set "H:\PhD\Result Data\Excel Sheets\tables.xlsx", sheet(BronchvsNoBronch) replace
***-----Setting up the Table----*****
su bronchiectasis, d
local allN = string(`r(N)', "%9.0f")
putexcel B1 = "All Patients (n=`allN')", hcenter bold border(bottom)
su bronchiectasis if everbronchiectasis == 1, d
local bronchN = string(`r(N)', "%9.0f")
putexcel C1 = "Ever Bronchiectasis (n=`bronchN')", hcenter bold border(bottom)
su bronchiectasis if everbronchiectasis == 0, d
local nobronchN = string(`r(N)', "%9.0f")
putexcel D1 = "No Bronchiectasis (n=`nobronchN')", hcenter bold border(bottom)


putexcel A2 = "Current Age (Years)", hcenter bold border(bottom)
putexcel A3 = "Current Follow Up (Years)", hcenter bold border(bottom)
putexcel A4 = "Age at Diagnosis (Years)", hcenter bold border(bottom)
putexcel A5 = "Follow up at Bronchiectasis (Years)", hcenter bold border(bottom)
putexcel A6 = "Current IgG Trough Levels (g/L)", hcenter bold border(bottom)
putexcel A7 = "Mean IgG Trough Levels (g/L)", hcenter bold border(bottom)
putexcel A8 = "Pre Bronchiectasis", hcenter bold border(bottom)
putexcel A9 = "Post Bronchiectasis", hcenter bold border(bottom)
putexcel A10 = "Infection Incidence", hcenter bold border(bottom)
putexcel A11 = "Pre Bronchiectasis", hcenter bold border(bottom)
putexcel A12 = "Post Bronchiectasis", hcenter bold border(bottom)
putexcel A13 = "Respiratory Infection Incidence", hcenter bold border(bottom)
putexcel A14 = "Pre Bronchiectasis", hcenter bold border(bottom)
putexcel A15 = "Post Bronchiectasis", hcenter bold border(bottom)

***Input the data****
order age agediagnosis followupperiod iggc lifetroughmean 

foreach var of varlist age-lifetroughmean {
	gen `var'nobronch =   `var' if everbronchiectasis == 0
	gen `var'bronch   =   `var' if everbronchiectasis == 1
	}

foreach var of varlist infectionincidence respinfectionincidence {
	gen `var'bronch = `var' if everbronchiectasis == 1
	}
	
order age agenobronch agebronch agediagnosis* followupperiod* followuptolungdx1 iggc* lifetroughmean lifetroughmeanbronch ///
	lifetroughmeannobronch nobronchiggmean ///
	prebronchiggmean postbronchiggmean infectionincidence infectionincidenceprebronch ///
	infectionincidenceprebronch infectionincidencepostbronch infectionincidencenobronch infectionincidencebronch respinfectionincidence ///
	respincidenceprebronch respincidencepostbronch 	respincidencenobronch respinfectionincidencebronch

foreach var of varlist age-respinfectionincidencebronch  {
	su `var', d
	local `var'med = string(`r(p50)', "%9.2f")
    local `var'iqr = string(`r(p75)'-`r(p25)', "%9.2f")
	
}


putexcel B2 = "`agemed' (`ageiqr')"
putexcel C2 = "`agebronchmed' (`agebronchiqr')"
putexcel D2 = "`agenobronchmed' (`agenobronchiqr')"
putexcel B3 = "`followupperiodmed' (`followupperiodiqr')"
putexcel C3 = "`followupperiodbronchmed' (`followupperiodbronchiqr')"
putexcel D3 = "`followupperiodnobronchmed' (`followupperiodnobronchiqr')"
putexcel B4 = "`agediagnosismed' (`agediagnosisiqr')"
putexcel C4 = "`agediagnosisbronchmed' (`agediagnosisbronchiqr')"
putexcel D4 = "`agediagnosisnobronchmed' (`agediagnosisnobronchiqr')"
putexcel C5 = "`followuptolungdx1med' (`followuptolungdx1iqr')"
**This may need to be changed later to bronchdx once I update data to include all lung dx
putexcel B6 = "`iggcmed' (`iggciqr')"
putexcel C6 = "`iggcbronchmed' (`iggcbronchiqr')"
putexcel D6 = "`iggcnobronchmed' (`iggcnobronchiqr')"
putexcel B7 = "`lifetroughmeanmed' (`lifetroughmeaniqr')"
putexcel C7 = "`lifetroughmeanbronchmed' (`lifetroughmeanbronchiqr')"
putexcel D7 = "`lifetroughmeannobronchmed' (`lifetroughmeannobronchiqr')"
putexcel C8 = "`prebronchiggmeanmed' (`prebronchiggmeaniqr')"
putexcel C9 = "`postbronchiggmeanmed' (`postbronchiggmeaniqr')"
putexcel B10 = "`infectionincidencemed' (`infectionincidenceiqr')"
putexcel C10 = "`infectionincidencebronchmed' (`infectionincidencebronchiqr')"
putexcel D10 = "`infectionincidencenobronchmed' (`infectionincidencenobronchiqr')"
putexcel C11 = "`infectionincidenceprebronchmed' (`infectionincidenceprebronchiqr')"
putexcel C12 = "`infectionincidencepostbronchmed' (`infectionincidencepostbronchiqr')"
putexcel B13 = "`respinfectionincidencemed' (`respinfectionincidenceiqr')"
putexcel C13 = "`respinfectionincidencebronchmed' (`respinfectionincidencebronchiqr')"
putexcel D13 = "`respincidencenobronchmed' (`respincidencenobronchiqr')"
putexcel C14 = "`respincidenceprebronchmed' (`respincidenceprebronchiqr')"
putexcel C15 = "`respincidencepostbronchmed' (`respincidencepostbronchiqr')"



