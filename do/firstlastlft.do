*	STATA v 14.2
*	Ben Shillitoe
*	b.shillitoe2@ncl.ac.uk

*	PhD XLA Project
*	Do File - Selecting only first and latest LFTs (for later merge)
*	v1.1 5.517 - Massive tidy up and proper coding
*	v1.0 - Initial interation
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\finallftdata"
sort studyid lftdate
rename age agelft
label variable agelft "Age at LFT"
gen timepostdxlft = (lftdate-datediagnosis)/365.25
label variable timepostdxlft "Time Post XLA Diagnosis (Years)"
by studyid: generate n1 = _n
by studyid: generate n2 = _N
keep if n1==1 | n1==n2
keep studyid n1 n2 lftyear zfev fev fevresult percpredfev zfvc fvc fvcresult percpredfvc zfevfvc fevfvc fevfvcresult  agelft lftdate timepostdxlft everbronchiectasis prexlabronch bronchdxdate1 lfttobronch datediagnosis
gen test = "first" if n1 == 1
replace test = "latest" if n1 == n2 & n2 >1

drop if lftyear == .
drop n1
drop n2
reshape wide lftyear zfev fev fevresult percpredfev zfvc fvc fvcresult percpredfvc zfevfvc fevfvc fevfvcresult agelft lftdate timepostdxlft everbronchiectasis prexlabronch bronchdxdate1 lfttobronch datediagnosis, i(studyid) j(test,s)
rename datediagnosisfirst datediagnosis
replace lftdatelatest = lftdatefirst if timepostdxlftlatest == .
replace lftyearlatest = lftyearfirst if timepostdxlftlatest == .
replace agelftlatest = agelftfirst if timepostdxlftlatest == .
replace fevlatest = fevfirst  if timepostdxlftlatest == .
replace fevresultlatest = fevresultfirst  if timepostdxlftlatest == .
replace zfevlatest = zfevfirst  if timepostdxlftlatest == .
replace percpredfevlatest = percpredfevfirst  if timepostdxlftlatest == .
replace fvclatest = fvcfirst  if timepostdxlftlatest == .
replace fvcresultlatest = fvcresultfirst  if timepostdxlftlatest == .
replace zfvclatest = zfvcfirst  if timepostdxlftlatest == .
replace percpredfvclatest = percpredfvcfirst  if timepostdxlftlatest == .
replace fevfvclatest = fevfvcfirst  if timepostdxlftlatest == .
replace fevfvcresultlatest = fevfvcresultfirst  if timepostdxlftlatest == .
replace zfevfvclatest = zfevfvcfirst  if timepostdxlftlatest == .
replace lfttobronchlatest = lfttobronchfirst  if timepostdxlftlatest == .
replace timepostdxlftlatest = timepostdxlftfirst  if timepostdxlftlatest == .

drop datediagnosislatest
gen dxtolft = (lftdatefirst-datediagnosis)/365.25
replace dxtolft = 0 if dxtolft <0
rename everbronchiectasisfirst everbronchiectasis
rename bronchdxdate1latest bronchdxdate1
drop everbronchiectasislatest
drop lfttobronchlatest
drop bronchdxdate1first
rename lfttobronchfirst lfttobronch
rename prexlabronchfirst prexlabronch
drop prexlabronchlatest
label variable everbronchiectasis "Does the Patient Have/Ever Had bronchiectasis"
label variable bronchdxdate1 "Date of Bronchiectasis Dx (adjusted for Pre XLA Bronch"
label variable lfttobronch "Time from LFT to Bronchiectasis"
compress
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\firstlastlft", replace
