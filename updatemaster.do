*Import Excel files, format and merge for master dataset
*Stata version 14.1

***test GitHub Pull


*XLA PhD Project
*Ben Shillitoe
*b.shillitoe2@ncl.ac.uk

*v1.6 15.05.2017
	*Converting Latest IgA and IgM <* to 0 
*v1.5 12.5.17
	*Now deletes all post lung surgery data (if any)
	*I thought (correctly) this may affect infection data - are clinicians more cautious?/does one lung
	*increase infections?


*v1.4 5.5.17 - Including LFT Data
*				Now updates LFT Data first
*				Imports 1st/Last LFT values
*Do file version 1.3 Update on 2.5.17
	* I have now changed IgG trough levels to mean all  - I have done this in excel.  Previous
	* STATA calucation left as variablename1

*  This do file imports and tidies data

*DETAILS-------------------------------------------------------------------------------------------

		**This Do File, imports and merges all data from Access and Excel.  It labels and endcodes neccessary string variables
		**The calucations included here are the ones working out data coverage
		**and overal infevtion incidence
		**This dataset is then saved as a master file and a working copy form which the 
		**indivual datasets are derived

**------------------------------------------------------------------***
***TO DO!!!!!!!!!!!!!!!!!!!!!!******

**encode hospitals
**encode severity
**encode compliance
**Change endcoding so increasing number is increasing sevrity.  And that 0=negative outcome 1=Positive Outcome

* Each import excel file exept ptlist has to destring studyid.  for some
*bizarre reason I have to select keep formatting in access to keep the correct
*study ids.  however this converts the studyid to string???


*******Updating IgG Cost Data first******************************************************
clear
set more off
set graphics off
do "H:\PhD\Result Data\Stata files\do\iggcost"

*delete post surgery data (if any)
clear
set more off
set graphics off
do "H:\PhD\Result Data\Stata files\do\deletepostsurgerydata"

*Updating QoL Data---------------------------------------------------------------------------------------------------
*Peds QL first ------------------------------------------------------------
clear
do "H:\PhD\Result Data\Stata files\do\pedsql"
***SDQ
clear
do "H:\PhD\Result Data\Stata files\do\sdq"
**RSES
clear
do "H:\PhD\Result Data\Stata files\do\rses"
**the HADS I do on its own below as a simple excell file

*Updating of LFT Data ready for merge of Data later below
clear
do "H:\PhD\Result Data\Stata files\do\importgli"
do "H:\PhD\Result Data\Stata files\do\firstlastlft"

**----- Setup and backup of Mater File-------------------------------

clear
*Set up of IgG Dose Data
do "H:\PhD\Result Data\Stata files\do\iggdoseformat.do"
clear
use "H:\PhD\Result Data\Stata files\dta files\Master Data Files - DO NOT EDIT\masterdatafile"
save "H:\PhD\Result Data\Stata files\dta files\Master Data Files - DO NOT EDIT\masterdatafilebackup", replace
clear
set more off
*------Import Excel Files and basic Formatting to enable merging------------
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\patientlist", firstrow
sort studyid
drop ID
rename EnrollmentDate enrollmentdate
rename Age age
rename Sex sex
rename Consultant consultant
rename Diagnosis diagnosis
drop Notes
order dob datedatacollection
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\patientlist", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\patientdiagnosis", firstrow
drop ID
* because of spaces in Dx Data, this is imported as string and needs to be
*converted to int
destring studyid, replace
sort studyid
destring cd3, replace
destring cd4, replace
destring cd8, replace
destring R, replace
destring T, replace
rename DateDiagnosis datediagnosis
rename GeneticDefect geneticdefect
rename GeneDetails genedetails
rename BTKTest btktest
rename IgA igadiagnosis
rename IgG iggdiagnosis
rename IgM igmdiagnosis
rename CD3 cd3diagnosis
rename cd3 cd3pdiagnosis
rename CD4 cd4diagnosis
rename cd4 cd4pdiagnosis
rename CD8 cd8diagnosis
rename cd8 cd8pdiagnosis
rename cd1920 cd1920diagnosis
rename R cd1920pdiagnosis
rename cd5616 cd5616diagnosis
rename T cd5616pdiagnosis
rename CD27ve cd27ve
rename cd27veigmigdve cd27veigmigdpos
rename CD27veIgMIgDve cd27veigmigdneg
rename PHA pha
rename PHAControl phacontrol
rename Tetanus tetanus
rename Hib hib
rename Pneumococcal pneumococcal
rename ituhdu ituhudpredx
drop ITUDetails
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\patientdiagnosis", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\currentclinicalstatus", firstrow
drop id
destring studyid, replace
sort studyid
rename iga igac
rename igm igmc
rename igg iggc
rename cd3 cd3c
rename O cd3pc
rename cd4 cd4c
rename Q cd4pc
rename cd8 cd8c
rename S cd8pc
rename cd1920 cd1920c
rename U cd1920cp
rename cd5616 cd5616c
rename W cd5616pc
rename ituorhdu ituhdupostdx
drop itudetails
drop medications
*** for now
*** Could somehow quanity meds
drop comorbidities
** for now
** could somehow quantify co-morbidites?
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\currentclinicalstatus", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\immunoglobulintherapy.xlsx", firstrow
drop id
drop imdetails
rename complicancedetails compliancedetails
destring studyid, replace
sort studyid
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggtherapy", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\lungdisease", firstrow
drop ID
destring studyid, replace
sort studyid

rename BSI bsi
rename Details lungdiseasedetails
rename CTProgression ctprogression
rename CTdteails ctdetails

save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\lungdisease", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\gicomplications", firstrow
drop ID
destring studyid, replace
sort studyid
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\gicomplications", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\psychhealth", firstrow
drop id
destring studyid, replace
sort studyid
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\psychhealth", replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
		sheet("iggtroughlevelsall") firstrow
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggtroughlevels", replace
clear
import excel using "H:\PhD\Database\iggtroughlevels.xlsx", ///
		sheet("gaps") firstrow
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\troughgaps", replace
clear

import excel using "H:\PhD\Database\infectionspostdx.xlsx", ///
	sheet(infectionstotals) firstrow
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionspostdx", replace
clear
import excel using "H:\PhD\Database\infectionspostdx.xlsx", ///
	sheet(infectionsresp) firstrow
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionresppostdx", replace
clear
import excel using "H:\PhD\Database\infectionspostdx.xlsx", ///
	sheet(DataStartDate) firstrow
drop F
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\startdateinfectiondata", replace

clear
import excel using "H:\PhD\Result Data\Excel Sheets\Imports  to Stata\infectionsprediagnosis.xlsx", firstrow
drop ID
destring studyid, replace
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionsprediagnosis", replace
clear
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\HADS Results.xlsx", firstrow
gen hadsanx = 1 if anxietyscore <=7
replace hadsanx = 2 if anxietyscore >=8 & anxietyscore <=10
replace hadsanx = 3 if anxietyscore >=11 & anxietyscore <=21
label define hadsanx_lb 1"Normal" 2"Borderline" 3"Abnormal"
label values hadsanx hadsanx_lb
gen hadsdep = 1 if depressionscore <=7
replace hadsdep = 2 if depressionscore >=8 & depressionscore <=10
replace hadsdep = 3 if depressionscore >=11 & depressionscore <=21
label define hadsdep_lb 1"Normal" 2"Borderline" 3"Abnormal"
label values hadsdep hadsdep_lb
label variable hadsdep "HADS Depression Outcome"
label variable depressionscore "HADS Raw Depression Score"
label variable hadsanx "HADS Anxiety Outcome"
label variable anxietyscore "HADS Raw Anxiety Score"
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\HADSmerge", replace
clear

***-----------Begin of Merge**-----------------------------------------------
use "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\patientlist"
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\patientdiagnosis"
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\currentclinicalstatus", gen(_merge2)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggtherapy", gen(_merge3)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\lungdisease", gen(_merge4)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\gicomplications", gen(_merge5)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\psychhealth", gen(_merge6)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggtroughlevels", gen(_merge7)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionspostdx", gen(_merge8)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionresppostdx", gen(_merge9)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\startdateinfectiondata", gen(_merge10)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\troughgaps", gen(_merge11)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Working Copies\iggdoses", gen(tempmerge)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggcost", gen(costmerge)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\infectionsprediagnosis", gen (_mergex)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\selfpedsql5-18merge", gen (_merge12)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\parentpedsql5-18merge", gen (_merge13)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\self11-17sdqmerge", gen(merge14)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\parent4-17sdqmerge", gen(merge15)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\HADSmerge", gen(merge16)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\rsesmerge", gen (merge17)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\firstlastlft", gen (lftmerge)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\dltpostsurgeryinfections", gen (postsurgmerge)
drop postsurgmerge
drop _merge13 merge14 merge15 merge16 merge17 lftmerge
drop _merge12
drop _mergex
drop costmerge
drop tempmerge
* To avert some never ending feedback loop I will now drop various labels from the firstlastlft data so it can be created with the latest as below
drop everbronchiectasis
label drop everbronchiectasis_lb
drop prexlabronch
label drop prexlabronch_lb
drop bronchdxdate1
**----------------end of Merge------------------------------------------
**-------------Encoding of String Variables------------------------------

order studyid
sort studyid
encode sex, gen(sex_lb)
order studyid dob sex_lb
drop sex
rename sex_lb sex
encode diagnosis, gen(diagnosis_lb)
order diagnosis_lb, a(diagnosis)
drop diagnosis
rename diagnosis_lb diagnosis
encode race, gen(race_lb)
order race_lb, a(race)
drop race
rename race_lb race
*need to encode hosp
* need to encode consultats
encode geneticdefect, gen(geneticdefect_lb)
order geneticdefect_lb, a(geneticdefect)
drop geneticdefect
rename geneticdefect_lb geneticdefect
encode btkexpress, gen(btkexpress_lb)
order btkexpress_lb, a(btkexpress)
drop btkexpress
rename btkexpress_lb btkexpress
encode btktest, gen(btktest_lb)
order btktest_lb, a(btktest)
drop btktest
rename btktest_lb btktest
encode fhx, gen(fhx_lb)
order fhx_lb, a(fhx)
drop fhx
rename fhx_lb fhx
encode screenedfhx, gen(screenedfhx_lb)
order screenedfhx_lb, a(screenedfhx)
drop screenedfhx
rename screenedfhx_lb screenedfhx
encode ituhdupostdx, gen(ituhdupostdx_lb)
order ituhdupostdx_lb, a(ituhdupostdx)
drop ituhdupostdx
rename ituhdupostdx_lb ituhdupostdx
encode ituhudpredx, gen(ituhdupredx_lb)
order ituhdupredx_lb, a(ituhudpredx)
drop ituhudpredx
rename ituhdupredx_lb ituhdupredx
encode currentiggroute, gen(currentiggroute_lb)
order currentiggroute_lb, a(currentiggroute)
drop currentiggroute
rename currentiggroute_lb currentiggroute
encode currentbrand, gen(currentbrand_lb)
order currentbrand_lb, a(currentbrand)
drop currentbrand
rename currentbrand_lb currentbrand
encode hometherapy, gen(hometherapy_lb)
order hometherapy_lb, a(hometherapy)
drop hometherapy
rename hometherapy_lb hometherapy
rename sidefffects sideeffects
encode sideeffects, gen(sideeffects_lb)
order sideeffects_lb, a(sideeffects)
drop sideeffects
rename sideeffects_lb sideeffects
** Will need to encode therapy issues - mild, mod severe
* Might need to format Access first
encode everim, gen(everim_lb)
order everim_lb, a(everim)
drop everim
rename everim_lb everim
encode bronchiectasis, gen(bronchiectasis_lb)
order bronchiectasis_lb, a(bronchiectasis)
drop bronchiectasis
rename bronchiectasis_lb bronchiectasis
encode prophylacticabx, gen(propylacticabx_lb)
order propylacticabx_lb,a(prophylacticabx)
drop prophylacticabx
rename propylacticabx_lb prophylacticabx
encode prophabxname, gen(prophabxname_lb)
order prophabxname_lb,a(prophabxname)
drop prophabxname
rename prophabxname_lb prophabxname
encode physio, gen(physio_lb)
order physio_lb, a(physio)
drop physio
rename physio_lb physio
encode ctprogression, gen(ctprogression_lb)
order ctprogression_lb, a(ctprogression)
drop ctprogression
rename ctprogression_lb ctprogression
encode smokingstatus, gen(smokingstatus_lb)
order smokingstatus_lb, a(smokingstatus)
drop smokingstatus
rename smokingstatus_lb smokingstatus
encode gicomplications, gen (gicomplications_lb)
order gicomplications_lb, a(gicomplications)
drop gicomplications
rename gicomplications_lb gicomplications
encode mentalhealthdc, gen(mentalhealthdx_lb)
order mentalhealthdx_lb, a(mentalhealthdc)
drop mentalhealthdc
rename mentalhealthdx_lb mentalhealthdx
** --------------------------Some simple Ordering**
order enrollmentdate, a(studyid)

****-----------------------------Some auto calcualtions/assingments
***Auto Age calculation and age group and age at dx
gen yeardiagnosis=year(datediagnosis)
gen moderndiagnosis = 1 if yeardiagnosis<2000
replace moderndiagnosis = 2 if yeardiagnosis>=2000
label define moderndiagnosis_lb 1"Pre 2000" 2"2000 Onwards"
label values moderndiagnosis moderndiagnosis_lb
drop age
gen age = (datedatacollection-dob)/365.25
order datedatacollection,a(enrollmentdate)
order dateiggdatastarts, a(datedatacollection)
order dateinfectiondatastart, a(datedatacollection)
order age, a(dob)
gen agegroup = 1 if age <18
replace agegroup = 2 if age >=18
replace agegroup = . if age==.
label define agegroup_lb 1"Paediatric" 2"Adult" 3"."
label values agegroup agegroup_lb
order agegroup, a(age)
gen agediagnosis = (datediagnosis-dob)/365.25
order datediagnosis, a(agegroup)
order agediagnosis, a(datediagnosis)
gen followupperiod = (datedatacollection-datediagnosis)/365.25
order followupperiod, a(agediagnosis)
label variable followupperiod "Period of follow up to Data Collection Date"
gen everbronchiectasis = 1 if bronchiectasis ==1 | 3
replace everbronchiectasis = 0 if bronchiectasis ==2
replace everbronchiectasis = . if bronchiectasis ==.
label define everbronchiectasis_lb 0"No" 1"Yes" 2"."
label values everbronchiectasis everbronchiectasis_lb
order everbronchiectasis, a(bronchiectasis)
*--------------------
* As of 2.5.2017 I have recalcuated IgG Means from all values in excel.  In STATA I was averaging yearly means which may be useful later
* Therefore at this point I am generating nobrocnhiggmean to equal lifetimemean if no bronchiectasis
* I couldn't find a tider place to put it!
*  To make things somewhat easier in excel I auto generate pre/bronch means even for those without bronch
* These need to be changed to '.'
replace prebronchiggmean = . if everbronchiectasis == 0
replace postbronchiggmean = . if everbronchiectasis == 0
replace nobronchiggmean = lifetroughmean if everbronchiectasis == 0
replace prebronchiggmean = . if prebronchiggmean == 0.00
replace postbronchiggmean = . if postbronchiggmean == 0.00


**---calculation of IgG Trough Data Coverage
gen iggtroughcoverage = ((datedatacollection-dateiggdatastarts)/365.25)-troughdatagap
*This includes post surgery, so will need to fix this at some point
order iggtroughcoverage, a(followupperiod)
replace iggtroughcoverage=followupperiod if iggtroughcoverage>followupperiod
label variable iggtroughcoverage "Years of available IgG trough data collection form study point"
gen troughdatavsfollowup = iggtroughcoverage/followupperiod
order troughdatavsfollowup, a(iggtroughcoverage)
label variable troughdatavsfollowup "Trough Data vs Follow Up Period"

***-----------Labelling of Data and Variables--------------------------
label data "National Congenital Agammaglobulinaemia Dataset"
label variable studyid "Unique Study ID"
label variable dob "DOB"
label variable datedatacollection "Date of Data Collection (Last Clinic Appointment)"
label variable localstudyid "Unique Local Study ID"
label variable enrollmentdate "Date of Enrollment into Study"
label variable age "Age at Data Collection"
label variable hosp "Hospital"
label variable diagnosis "XLA or AR"
label variable agegroup "Paediatric/Adult"
label variable race "Race"
label variable agediagnosis "Age at Diagnosis"
label variable datediagnosis "Date of Diagnosis"
label variable geneticdefect "Genetic Defect? Yes,No,Unknown"
label variable genedetails  "Details of Gene Defect"
label variable btkexpress "BTK Expression? Yes, No, Unknown"
label variable btktest "Method of BTK Expression Testing"
label variable igadiagnosis "IgA at Diagnosis"
label variable iggdiagnosis "IgG at Diagnosis"
label variable igmdiagnosis "IgM at Diagnosis"
label variable cd3diagnosis "CD3 Cells at Diagnosis"
label variable cd3pdiagnosis "CD3(%) at Diagnosis"
label variable cd4diagnosis "CD4 Cells at Diagnosis"
label variable cd4pdiagnosis "CD4(%) at Diagnosis"
label variable cd8diagnosis "CD8 Cells at Diagnsosis"
label variable cd8pdiagnosis "CD8(%) at Diagnosis"
label variable cd1920diagnosis "CD19/20 Cells at Diagnosis"
label variable cd1920pdiagnosis "CD19/20(%) at Diagnosis"
label variable cd5616diagnosis "CD56/16 Cells at Diagnosis"
label variable cd5616pdiagnosis "CD56/16(%) at Diagnosis"
label variable pha "PHA response"
label variable tetanus "Tetanus Antibodies pre Treatment"
label variable hib "Hib Antibodies pre Treatment"
label variable pneumococcal "Pneumoccocal Antibodies pre Treatment"
label variable fhx "Family History of Agamma? Yes,No,Unknown"
label variable screenedfhx "If Postive Family History, was the participant screened?"
label variable ituhdupredx "Intensive Care Admission Pre Diagnosis?"
label variable igtestdate "Date of last Serum Immunoglobulins"
label variable igac "Latest IgA Levels (String)" 
label variable igmc "Latest IgM Levels"
label variable iggc "Latest IgG Trough Level"
label variable fbcdate "Date of Last FBC"
label variable hb "Last Hb"
label variable platelets "Last Platelet Count"
label variable wcc "Last WCC"
label variable neuts "Last Neutrophil Count"
label variable lymphs "Last Lymphocyte Count"
label variable subsetdates "Date of last Lymphocyte Subsets"
label variable cd3c "Last CD3 Count"
label variable cd3pc "Last CD3 %"
label variable cd4c "Last CD4 Count"
label variable cd4pc "Last CD4 %"
label variable cd8c "Last CD8 Count"
label variable cd8pc "Last CD8 %"
label variable cd1920c "Last cd19/20 count"
label variable cd1920cp "Last cd19/20 %"
label variable cd5616c "Last NK count"
label variable cd5616pc "Last NK %"
label variable ituhdupostdx "Intensive Care Admission post Diagnosis?"
label variable currentiggroute "Route of Current Ig Therapy"
label variable currentdose "Current Dose of Ig Therapy"
label variable currentinterval "Current Interval of Ig Therapy"
label variable currentdosekgmonth "Current Ig Dose/Kg/Month"
label variable currentbrand "Current Brand of Ig Therapy"
label variable hometherapy "Home Therapy?"
label variable sideeffect "Side Effects?"
label variable details "Details of Side Effects"
label variable therapyissues "Complicance Issues?"
label variable compliancedetails "Details of Compliance Issues"
label variable everim "Has the patient ever been on IM therapy?"
label variable lungdisease "Does the patient have bronchiectasis?"
label variable everbronchiectasis "Does the Patient have/ever had bronchiectasis"
label variable lungdiseasedetails "Details of Lung Disease"
label variable bronchdxdate "Date of Lung Disease Dx (if any)"
label variable bsi "Current BSI"
label variable prophylacticabx "Prophlyaxis Antibiotics?"
label variable prophabxname "Name of prophylactic antibiotics"
label variable prophadxdosing "Dosing of Prophlyactic Antiobiotics"
label variable physio "Does the patient receive regular physio?"
label variable ctprogression "Evidence of Disease Progression on CT"
label variable ctdetails "Details of CT"
label variable otherintervention "Any other interventions?"
label variable smokingstatus "Current Smoking Status"
label variable gicomplications "Any GI Complications?"
label variable enteropathy "Any GI enteropathy"
label variable ibdlikedisease "Evidence of IBD like Disease?"
label variable gisurgery "Any GI surgery?"
label variable gisurgerydetails "GI Surgery Details?"
label variable mentalhealthdx "Mental Health Issues?"
label variable mentalhealthdetails "Details of any mental health issues"
label variable dateiggdatastarts "Date IgG trough data starts"
label variable lifetroughmean "Excel Mean of Lifetime IgG Trough Levels"
label variable lifetroughsd "SD of Lifetime IgG Trough Levels from Excel"
label variable lifetroughmean2 "Life Trough Mean including post surgery"
label variable postbronchiggmean2 "Post BronchMean including post surgery"

**-----------------------------------------------------------********
**///Converting String Lab Values to Numeric and any below detectable range to 0 ///*
**-----------------------------------------------------------*******

*Latest IgA and IgM Counts (BTW first foreach loop!)

foreach var of varlist igac igmc {
	gen `var'u = 0 if regexm(`var', "<")
	tostring `var'u, replace
	replace `var'u = `var' if `var'u != "0"
	destring `var'u, replace
	label variable `var'u "Latest `var' Count" 
}



***Total infection calculations--------may need updating if pre 1980 data

*varname1 = data including post lung surgery (if any)
*otherwise post surgery data eliminated

egen infectiontotaltemp = rowtotal(infections2018-infections1980) if bronchiectasis !=3
replace infectiontotal = infectiontotaltemp if bronchiectasis !=3
drop infectiontotaltemp 
order infectiontotal, a(infections1980)
egen infectionresptotaltemp = rowtotal(resp2018-resp1980) if bronchiectasis !=3
replace infectionresptotal = infectionresptotaltemp if bronchiectasis !=3
order infectionresptotal, a(resp1980)
gen othertotal = infectiontotal-infectionresptotal
order othertotal, a(infectionresptotal)


egen infectiontotal1 = rowtotal(infections2018-infections1980)
order infectiontotal1, a(infections1980)
egen infectionresptotal1 = rowtotal(resp2018-resp1980)
order infectionresptotal1, a(resp1980)
gen othertotal1 = infectiontotal1-infectionresptotal1
order othertotal1, a(infectionresptotal)

label variable infectiontotal1 "Total Number of Infections incl post surgery"
label variable infectionresptotal1 "Total Number of Resp Infections incl post surgery"
label variable othertotal1 "Total Number of other Infections incl post surgery"

label variable infectiontotal "Total Number of Infections"
label variable infectionresptotal "Total Number of Resp Infections"
label variable othertotal "Total Number of other Infections"

gen infectiondataperiod=((datedatacollection-dateinfectiondatastart)/365.25)-infectiondatagap
gen infectiondataperiodwholeyears = ((year(datedatacollection))-(year(dateinfectiondatastart)))-infectiondatagap

gen infectiondataperiodtemp =(((datedatacollection-dateinfectiondatastart)/365.25)-infectiondatagap-((year(datedatacollection))-lungsurgeryyear)) if bronchiectasis ==3
gen dataperiodwholeyearstemp = (((year(datedatacollection))-(year(dateinfectiondatastart)))-infectiondatagap-((year(datedatacollection))-lungsurgeryyear)) if bronchiectasis ==3

replace infectiondataperiod = infectiondataperiodtemp  if bronchiectasis ==3
replace infectiondataperiodwholeyears = dataperiodwholeyearstemp if bronchiectasis ==3

label variable infectiondataperiod "Period of Available Infection Data Collected in Whole Years"
gen infectionincidence = infectiontotal/infectiondataperiod
label variable infectionincidence "Total Infection Incidence over available data period"
gen respinfectionincidence = infectionresptotal/infectiondataperiod
label variable respinfectionincidence "Total Respiratory infection incidence over available data period"

gen infectiondataperiod1=((datedatacollection-dateinfectiondatastart)/365.25)-infectiondatagap
gen infectiondataperiodwholeyears1 = ((year(datedatacollection))-(year(dateinfectiondatastart)))-infectiondatagap
label variable infectiondataperiod1 "Period of Available Infection Data Collected in Whole Years incl post surgery"
gen infectionincidence1 = infectiontotal1/infectiondataperiod1
label variable infectionincidence1 "Total Infection Incidence over available data period incl post surgery"
gen respinfectionincidence1 = infectionresptotal1/infectiondataperiod1
label variable respinfectionincidence1 "Total Respiratory infection incidence over available data period incl post surgery"



label variable seriousinfection "Invasive Disease or Sepsis Pre Diagnosis? (With or Without ITU/HDU Stay)"
label variable seriousdetails1 "Details of Serious Disease 1"
label variable seriousdetails2 "Details of Serious Disease 2"
label variable seriousdetails3 "Details of Serious Disease 3"
label variable seriousnumber "Number of Serious Infections Pre Diagnosis"
label variable lrtiin "In Patient LRTI Pre Diagnosis"
label variable lrtiout "Out Patient URTI Pre Diagnosis"
label variable urtiin "In Patient URTI Pre Diagnosis"
label variable pneumoniain "In Patient Pneumonia Pre Diagnosis"
label variable pneumoniaout "Out Patient Pneumonia Pre Diagnosis"
label variable totalrespin "In Patient Total Resp Infections Pre Diagnosis"
label variable totalrespout "Out Patient Total Resp Infections Pre Diagnosis"
label variable sinusIn "In Patient Sinus Pre Diagnosis"
label variable SinusOut "Out Patient Sinus Pre Diagnosis"
label variable OtitisIn "In Patient Otitis Pre Diagnosis"
label variable OtitisOut "Out Patient Otitis Pre Diagnosis"
label variable SkinIn "In Patient Skin Infections Pre Diagnosis"
label variable SkinOut "Out Patient Skin Infections Pre Diagnosis"
label variable EyesIn "In Patient Eye Infections Pre Diagnosis"
label variable EyesOut "Out Patient Eye Infections Pre Diagnosis"
label variable GIIn "In Patient GI Infections Pre Diagnosis"
label variable GIOut "Out Patient GI Infections Pre Diagnosis"
label variable CNSIn "In Patient CNS Infections Pre Diagnosis"
label variable CNSOut "Out Patient CNS Infections Pre Diagnosis"
label variable BoneJointIn "In Patient Bone and Joint Infections Pre Diagnosis"
label variable BoneJointOut "Out Patient Bone and Joint Infections Pre Diagnosis"
label variable SepsisIn "In Patient Sepsis Pre Diagnosis"
label variable SepsisOut "Out Patient Sepsis Pre Diagnosis"
label variable TBIn "In Patient TB Pre Diagnosis"
label variable TBOut "Out Patient TB Pre Diagnosis"
label variable Other "Other infections pre Diagnosis"
label variable DataComplete "Is Pre Diagnosis Data Complete?"
label variable lungsurgeryyear "Year of any lung surgery"
drop Details
drop TimeComplete
label variable Preinfecnotes "Details regarding Pre Diagnosis Infections"
gen infectiondatacoverage = infectiondataperiod/followupperiod
label variable infectiondatacoverage "Available Infection Data Collection vs Follow Up"
gen proportionresp = infectionresptotal/infectiontotal
label variable proportionresp "Respiratory Infections vs Total Infections"
order proportionresp, a(infectionresptotal)


**Moving the Merge Variables for Checking
order _merge _merge2 _merge3 _merge4 _merge5 _merge6 _merge7 _merge8 _merge9 ///
	_merge10 _merge11, last
*---------------Compress and Save Data File-----------------------
drop if diagnosis==.
compress
save "H:\PhD\Result Data\Stata files\dta files\Master Data Files - DO NOT EDIT\masterdatafile", replace
**----------------save as working copy***************
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\lastworkingcopydatabackup", replace
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\workingcopydata", replace
***move to do file folder for ease***
cd "H:\PhD\Result Data\Stata files\do"
