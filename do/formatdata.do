***Bronchiectasis Data and Analyses*****
***STATA 14.1****
***25/11/16****

* STATA Version 14.1
* Ben Shillitoe
*v1.4 - excluding data after any lung surgery
*Do file version 1.3 Update on 2.5.17
	* I have now changed IgG trough levels to mean all  - I have done this in excel.  Previous
	* STATA calucation left as variablename1
	
* This do file calcuates dummy variables and organsises data for later analysis


clear
set graphics off
set more off
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\workingcopydata"
cd "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis"

**This now defines pre XLA bronch as either bronch pre XLA or Dx within 12 months of XLA Dx)
gen followuptolungdx=(bronchdxdate-datediagnosis)/365.25
replace followuptolungdx = (datedatacollection-datediagnosis)/365.25 if everbronchiectasis==0
gen prexlabronch = 1 if followuptolungdx<0
replace prexlabronch = 0 if followuptolungdx>1
replace prexlabronch = 2 if followuptolungdx>=0 & followuptolungdx<=1
replace prexlabronch = 3 if everbronchiectasis  == 0
label define prexlabronch_lb 0"No" 1"Yes" 2"At Diagnosis" 3"N/A" 4"."
label values prexlabronch prexlabronch_lb
gen bronchdxdate1 = bronchdxdate
format bronchdxdate1 %d
replace bronchdxdate1 = datediagnosis if prexlabronch == 2
gen followuptolungdx1 = 0 if prexlabronch ==1
replace followuptolungdx1=0 if prexlabronch==2
replace followuptolungdx1 = followuptolungdx if prexlabronch ==0
replace followuptolungdx1=followuptolungdx if everbronchiectasis==0
gen yeardxbronch=year(bronchdxdate)
gen yearcollection = year(datedatacollection)
replace yeardxbronch=yearcollection if everbronchiectasis==0
gen yearinfectiondatastarts=year( dateinfectiondatastart )
label variable yeardxbronch "Year of Bronchiectasis Disease Diagnosis or Year of Data Collection if No Bronchectasis Disease"
label variable yearcollection "Year of Data Collection"
gen yeardxbronch1=yeardxbronch
replace yeardxbronch1=yeardiagnosis if prexlabronch==2
label variable yeardxbronch1 "Year of Lung Diagnosis(or curreny year if none) adjusted for those who Dx <12 Months of XLA"
gen agedxbronch1 = (bronchdxdate1-dob)/365.25
label variable agedxbronch1 "Age at Dx of Bronchiectasis (Or Current Date if no Bronch for KM) adjusted for Early Bronch"
save currentworkingdataset, replace
**Just getting rid of unneccsary variables
drop _merge-_merge11


**Getting rid of blank studyid's
drop if diagnosis==.
su agediagnosis, d
return list
gen earlydiagnosis=1 if agediagnosis<=`r(p50)'
replace earlydiagnosis=2 if agediagnosis>`r(p50)'
label define earlydx_lb 1"Yes" 2"No"
label values earlydiagnosis earlydx_lb
compress
gen agedxbronch=(bronchdxdate-dob)/365.25
replace agedxbronch=agediagnosis if prexlabronch ==1 & followuptolungdx>0
replace agedxbronch=. if everbronchiectasis==0
label variable agedxbronch "Age at Diagnosis of Bronchiectasis(Or current age if none)"
gen yearbronch = year(bronchdxdate) if everbronchiectasis==1
gen exacttotalinfdata = ((datedatacollection- dateinfectiondatastart)/365.25)- infectiondatagap
gen exactprebronchinfdata = ((bronchdxdate-dateinfectiondatastart)/365.25)-infectiondatagap if yearbronch>infectiongapend
replace exactprebronchinfdata=(((datedatacollection-bronchdxdate)/365.25)-(yearbronch-infectiongapstart)) if yearbronch >=infectiongapstart & yearbronch <=infectiongapend
replace exactprebronchinfdata=((bronchdxdate-dateinfectiondatastart)/365.25) if yearbronch<infectiongapstart
replace exactprebronchinfdata=. if dateinfectiondatastart>bronchdxdate
gen exactpostbronchinfdata= ((datedatacollection-bronchdxdate)/365.25) if yearbronch>infectiongapend
replace exactpostbronchinfdata= (((datedatacollection-bronchdxdate)/365.25)-(infectiongapend-yearbronch)) if yearbronch >=infectiongapstart& yearbronch <=infectiongapend
replace exactpostbronchinfdata=((datedatacollection-bronchdxdate)/365.25)-infectiondatagap if yearbronch<=infectiongapstart
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset", replace


**setting data for time survival analysis****
gen agedxkap=(bronchdxdate-dob)/365.25
replace agedxkap=age if everbronchiectasis==0
label variable agedxkap "Censor Age for KM Analysis"
stset agedxkap, failure(everbronchiectasis==1)
compress
***Saving the data just for KM Analysis
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetkm", replace
clear

**This will now reshape the data and only select data pre any dx of bronchiectasis
* (Including patients with no current Dx of bronchiectasis)
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"
reshape long igg infections resp dose, i(studyid) j(year)
twoway (scatter igg dose if everbronchiectasis==0, mcolor(red)) (scatter igg dose if everbronchiectasis==1, mcolor(blue)) ///
(lfit igg dose if everbronchiectasis==0, lcolor(red)) (lfit igg dose if everbronchiectasis==1, lcolor(blue)), ytitle(IgG Trough Level) xtitle(IgG Dose (g/Kg/Month)) title(IgG Dose vs IgG Trough Level) legend(order(1 "Never Bronchiectasis" 2 "Ever Bronchiectasis" 3 "" 4 "" ))
graph export "H:\PhD\Result Data\Graphs\troughvsdose.eps", replace
twoway (scatter igg year), xtitle(Year) xtitle(, margin(medium)) title("Yearly Mean IgG Trough Levels Over Life-Time")
graph export "H:\PhD\Result Data\Graphs\yearlyiggovertime.eps", replace

***finally mastered the reshape!!!!!!!!
**** This commmand replaces missing values that were '0' in excel for data gaps - I have not dropped the values
replace infections=. if year >=infectiongapstart & year<= infectiongapend
replace infections=. if year<yearinfectiondatastarts
replace resp=. if year >=infectiongapstart & year<= infectiongapend
replace resp=. if year<yearinfectiondatastarts
replace infections=. if year>yearcollection
replace resp=. if year>yearcollection
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetreshape", replace 
reshape wide igg infections resp dose, i(studyid) j(year)
order _all, alpha
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetreshapebacktowide", replace 
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetreshape"
**Now to Format for IgG level analysis
label variable igg "Mean IgG Trough Levels"

******-----------------------------------------------------------------------------------------
* In the early versions I generated mean IgG levels from the Yearly Mean IgG levels.  In the end I felt it was
* more accuarte to mean all trough levels and not the yearly mean (ending up with a 'mean of a mean'
* The easiest wasy to do this was in excel and so it has been done.  I have left in this original version below just in case
* These are not yet used in any graphs or analysis (as of 2.5.17)
*I have therefore no yet exlcuded post surgery iff levels
gen nobronchigg = igg if everbronchiectasis == 0
label variable nobronchigg "IgG Levels for Patients with no Bronchiectasis"
gen postigg = igg if year>=yeardxbronch1 & everbronchiectasis==1
label variable postigg "Post Bronchiectasis IgG levels"
gen preigg = igg if year<yeardxbronch1 & everbronchiectasis==1
reshape wide igg  preigg nobronchigg postigg infections resp dose, i(studyid) j(year)
keep studyid everbronchiectasis preigg* nobronchigg* postigg* igg*
order _all, alpha
egen lifetroughmean1 = rowmean(igg1980-igg2018)
egen postbronchiggmean1 = rowmean(postigg*) if everbronchiectasis==1
egen prebronchiggmean1 = rowmean(preigg*) if everbronchiectasis==1
egen nobronchiggmean1 = rowmean(nobronchigg*) if everbronchiectasis==0
keep studyid everbronchiectasis postbronchiggmean1 prebronchiggmean1 nobronchiggmean1 lifetroughmean1
label variable prebronchiggmean1 "Mean of IgG Levels Pre Diagnosis of Bronchiectasis from STATA"
label variable postbronchiggmean1 "Mean of IgG Levels Post Diagnosis of Bronchiectasis from SATA"
label variable nobronchiggmean1 "Mean of IgG Levels in Patients with No Bronchiectasis from STATA"
label variable lifetroughmean1 "Mean of Life Time IgG levels from SATA"
drop everbronchiectasis
compress
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggbronchsplit", replace


***This next bit goes back to the reshahpe file and elimates those infection data points after any Dx of Lung Disease
**As of yet I can't figure out a way to analyse the data wihtout doing this
**So this will be the formatting for pre bronch data
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetreshape"
drop if prexlabronch==2
drop if year>=yeardxbronch1 & everbronchiectasis==1
drop if year>yeardxbronch1 & everbronchiectasis==0
**As of 17.1.17 I have used this new var yeardxbronch
**As beginning of do file this alters any patient who bronch dx <12 mnths of XLA dx to 
** bronch dx at XLA dx i.e. they will have no pre bronch data
reshape wide igg infections resp dose, i(studyid) j(year)
order _all, alpha
order studyid
su yearinfectiondatastarts, d
return list
local minyearpre = `r(min)'
su yearcollection, d
return list
local maxyearpre = `r(max)'
egen infectionsprebronch=rowtotal(infections`minyearpre'-infections`maxyearpre')
egen respprebronch=rowtotal(resp`minyearpre'-resp`maxyearpre')
**Have to include thise next bit otherwise STATA sums misssing values as 0
replace infectionsprebronch=. if yeardxbronch<yearinfectiondatastarts
replace respprebronch=. if yeardxbronch<yearinfectiondatastarts
***At the minute no 2018 data as this is dropped previosuly.  Will have to amend to include later


** Would be useful to gen availfollowuptolungdx (i.eavail infection data) at some point but I can't be bothered at the moment
**if there is no lung disease followuptolungdxx is simply the date of datacollection
gen infectionincidenceprebronch=infectionsprebronch/exactprebronchinfdata
gen respincidenceprebronch=respprebronch/exactprebronchinfdata
replace infectionincidenceprebronch=0 if infectionsprebronch==0
replace respincidenceprebronch=0 if respprebronch==0
* This is a major rework on 6.12.16.  I have replaced not needed years with "." and then taken average of remaining values to calculate incidence. 
**This seems easier and more robust
**of note asking to calucalte infectionsprebronch/followupto lugdx gives at times very different answers
**the issue is that I am dealing with whole years on my calculations (I prefer this - no extact dates of infections)
** whereas for somepts follow up to lungdx is <1 year and can be very samll.  So if lungdx = diseaseyear and infection that yr =2 my answer will be 2
** but if divinding by exact interval, 2 infections per that 2 monts is really = to 10/year!! i don't like that, I'm keeping it this way
**and then of course post bronch)
label variable yeardxbronch "Year of Lung Diagnosis(if any)"
label variable yearcollection "Year of Data Collection"
label variable yearinfectiondatastarts "Year Infection Data Starts"
label variable infectionincidenceprebronch "Infection Incidence Pre Bronchiectasis"
label variable followuptolungdx "Years of Follow Up Until Bronchiectasis (if any) or Follw up to Data Collection"
label variable infectionsprebronch "Number of Infections Pre Bronchiectasis"
***This is now the data pre anydx of lung disease
compress
save prebronchdata, replace


**Now to prepare a file to merge pre and post bronch data
keep studyid infectionincidenceprebronch infectionsprebronch followuptolungdx respincidenceprebronch yeardxbronch yearcollection yearinfectiondatastarts
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\prebronchmerge", replace

***This will now generate a dataset for prebronch time for patients with a Hx of bronch
clear
use prebronchdata
drop if everbronchiectasis==0
compress
save onlybronchprebronchdata, replace

**Will need to do same for post Dx of bronch,may need to be as convulated as above then
**merge can them compare pre/post incidence in brocnch

clear
use currentworkingdataset
**Get rid of patietns withour Bronch
drop if everbronchiectasis == 0

reshape long igg infections resp, i(studyid) j(year)
replace infections=. if year >=infectiongapstart& ///
year< infectiongapend
replace infections=. if year<yearinfectiondatastarts
replace resp=. if year >=infectiongapstart & year< infectiongapend
replace resp=. if year<yearinfectiondatastarts

replace infections=. if year>yearcollection
replace resp=. if year>yearcollection
replace yeardxbronch=yearcollection if everbronchiectasis==0

rename infections infectionspostbronch
**This next bit will now drop any patient without bronch and all datapoints before bronch
*This will now drop all points after any lung surgery and resolved bronch
drop if year >= lungsurgeryyear & bronchiectasis == 3
drop if year<yeardxbronch1

reshape wide igg infectionspostbronch resp, i(studyid) j(year)
order _all, alpha
order studyid
su yeardxbronch, d
return list
local minyear = `r(min)'
su yearcollection, d
return list
local maxyear = `r(max)'
egen totalinfectionspostbronch=rowtotal(infectionspostbronch`minyear'-infectionspostbronch`maxyear')
egen totalresppostbronch=rowtotal(resp`minyear'-resp`maxyear')
gen yearspostbronch = datedatacollection-bronchdxdate
gen infectionincidencepostbronch=totalinfectionspostbronch/exactpostbronchinfdata
gen respincidencepostbronch=totalresppostbronch/exactpostbronchinfdata
label variable totalinfectionspostbronch "Total Number of Infections post Diagnosis of Bronchiectasis"
label variable yearspostbronch "Years from Diagnosis of Bronchiectasis to Data Collection Point"
label variable infectionincidencepostbronch "Infection Incidence Post Diagnosis of Bronchiectasis"


compress
save postbronchdata, replace
keep studyid infectionincidencepostbronch respincidencepostbronch totalinfectionspostbronch totalresppostbronch yearspostbronch
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\postbronchmerge", replace

clear
use prebronchdata
stset followuptolungdx, failure(everbronchiectasis==1)
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\kmfollowup", replace

***KM Follow Up Data excluding those who bronch Dx before or at XLA Dx
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"
stset followuptolungdx1, failure(everbronchiectasis==1)
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\kmfollowup1", replace



**Now to go back to bronchdata and merge pre and post bronch data
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\prebronchmerge", gen(_merge12)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\postbronchmerge", gen(_merge13)
merge 1:1 studyid using "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\iggbronchsplit", gen(_merge14)
replace infectionsprebronch =. if everbronchiectasis==0
replace  infectionincidenceprebronch =. if everbronchiectasis==0
replace  respincidenceprebronch =. if everbronchiectasis==0
replace prebronchiggmean1 =. if everbronchiectasis==0
gen infectionincidencenobronch= infectionincidence if everbronchiectasis==0
gen respincidencenobronch= respinfectionincidence if everbronchiectasis==0
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\bronchdataprepostraw", replace
*drop infections2018-infections1980
*drop resp2018-resp1980
*drop igg2018-igg1980
gen totalinfectionsnobronch = infectiontotal if everbronchiectasis==0
label variable yeardiagnosis "Year of Agamma Diagnosis"
label variable moderndiagnosis "Post 2000 diagnosis of Agamma?"
label variable infectiondataperiodwholeyears "Available infection Data in Whole Years"
label variable followuptolungdx "Follow Up Time Till Development of Bronchiectasis"
label variable prexlabronch "Was Bronchiectasis Diagnosed before Agamma?"
label variable followuptolungdx1 "Follow up Time Till Bronchiectasis (Adjusted for those < 12mtns of Agamma"
label variable yearinfectiondatastarts "Year Infection Data Starts"
label variable yeardxbronch1 "Year of Bronchiectasis Diagnossis (Adjusted for those Dx < 12mnths of Agamma"
label variable earlydiagnosis "Early or Late Diagnosis (Based on current Median)"
drop _merge12 _merge13 _merge14
gen yearbirth = year(dob)
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset", replace


cd "H:\PhD\Result Data\Stata files\do"
