**Scoring of Peds QL 
***STATA 14.2 14.3.17--------------------------


***First Self Scoring 13-18 year olds

clear
set more off
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\SelfPedsQL5-18.xlsx", firstrow


**Recode Physical Component"
recode swalk (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cswalk)
recode srun (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csrun)
recode ssport (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cssport)
recode slift (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cslift)
recode sbath (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csbath)
recode stidy (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cstidy)
recode sache (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csache)
recode stired (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cstired)

**Recode Emotional Component****
recode sscared (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csscared)
recode ssad (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cssad)
recode sangry (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csangry)
recode ssleep (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csleep)
recode sworry (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csworry)

**Recode Social Component****
recode sothers (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csothers)
recode sfriends (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csfriends)
recode sbully (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csbully)
recode sable (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csable)
recode skeep (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cskeep)

**Recode Schol Component****
recode satten (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csatten)
recode sforget (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csforget)
recode sswork(0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csswork)
recode soffwell (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csoffwell)
recode soffapp (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(csoffapp)

drop swalk srun ssport  slift  sbath  stidy  sache stired  sscared ssad  sangry  ssleep /// 
sworry  sothers sfriends  sbully  sable skeep  satten  sforget  sswork soffwell   soffapp 

order sphysans semans ssocans  sschans, last

egen stotalans = rsum(sphysans-sschans)
egen spsychosocialans = rsum(semans-sschans)

egen stotalscore = rmean(cswalk-csoffapp) if stotalans >11
egen spsychsocialscore = rmean (csscared-csoffapp) if spsychosocialans >7

egen sphyscore = rmean (cswalk-cstired) if sphysans>3
egen semotscore = rmean (csscared-csworry) if semans >2
egen ssocialscore = rmean (csothers-cskeep) if ssocans >2
egen sschoolscore = rmean (csatten-csoffapp) if sschans > 2

label variable stotalscore "Self Total Peds QL 4.0 Score"
label variable spsychsocialscore "Self PsychoSocial Peds QL 4.0 Score"
label variable sphyscore "Self Total Physical Peds QL 4.0 Score"
label variable semotscore "Self Emotial Peds QL 4.0 Score"
label variable ssocialscore "Self Social Peds QL 4.0 Score"
label variable sschoolscore "Self School Peds QL 4.0 Score"
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\selfpedsql5-18", replace
keep  studyid stotalscore-sschoolscore
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\selfpedsql5-18merge", replace

**Now Parent Scoring 13-18 year olds-------------------------------------------------
clear
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\ParentPedsQL5-18.xlsx", firstrow


**Recode Physical Component"
recode pwalk (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpwalk)
recode prun (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cprun)
recode psport (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpsport)
recode plift (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cplift)
recode pbath (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpbath)
recode ptidy (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cptidy)
recode pache (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpache)
recode ptired (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cptired)

**Recode Emotional Component****
recode pscared (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpscared)
recode psad (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpsad)
recode pangry (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpangry)
recode psleep (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpleep)
recode pworry (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpworry)

**Recode Social Component****
recode pothers (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpothers)
recode pfriends (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpfriends)
recode pbully (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpbully)
recode pable (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpable)
recode pkeep (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpkeep)

**Recode Schol Component****
recode patten (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpatten)
recode pforget (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpforget)
recode pswork(0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpswork)
recode poffwell (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpoffwell)
recode poffapp (0=100) (1=75) (2=50) (3=25) (4=0) (else=.), gen(cpoffapp)

drop pwalk prun psport  plift  pbath  ptidy  pache ptired  pscared psad  pangry  psleep /// 
pworry  pothers pfriends  pbully  pable pkeep  patten  pforget  pswork poffwell   poffapp 

order pphysans pemans psocans  pschans, last

egen ptotalans = rsum(pphysans-pschans)
egen ppsychosocialans = rsum(pemans-pschans)

egen ptotalscore = rmean(cpwalk-cpoffapp) if ptotalans >11
egen ppsychsocialscore = rmean (cpscared-cpoffapp) if ppsychosocialans >7

egen pphyscore = rmean (cpwalk-cptired) if pphysans>3
egen pemotscore = rmean (cpscared-cpworry) if pemans >2
egen psocialscore = rmean (cpothers-cpkeep) if psocans >2
egen pschoolscore = rmean (cpatten-cpoffapp) if pschans > 2

label variable ptotalscore "Parent Total Peds QL 4.0 Score"
label variable ppsychsocialscore "Parent PsychoSocial Peds QL 4.0 Score"
label variable pphyscore "Parent Total Physical Peds QL 4.0 Score"
label variable pemotscore "Parent Emotial Peds QL 4.0 Score"
label variable psocialscore "Parent Social Peds QL 4.0 Score"
label variable pschoolscore "Parent School Peds QL 4.0 Score"
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\parentpedsql5-18", replace
keep  studyid ptotalscore-pschoolscore
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\parentpedsql5-18merge", replace
