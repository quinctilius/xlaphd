***scoring of RSES
**STATA 14.2 14.3.17
clear
set more off
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\rses.xlsx", firstrow
recode worth (1=3) (2=2) (3=1) (4=0), gen (cworth)
recode qualities(1=3) (2=2) (3=1) (4=0), gen (cqualities)
recode failure (1=0) (2=1) (3=2) (4=3), gen (cfailure)
recode ability (1=3) (2=2) (3=1) (4=0), gen (cability)
recode proud (1=0) (2=1) (3=2) (4=3), gen (cproud)
recode attitude (1=3) (2=2) (3=1) (4=0), gen (cattitude)
recode satisfaction (1=3) (2=2) (3=1) (4=0), gen (csatisfaction)
recode useless (1=0) (2=1) (3=2) (4=3), gen (cuseless)
recode respect (1=0) (2=1) (3=2) (4=3), gen (crespect)
recode good (1=0) (2=1) (3=2) (4=3), gen (cgood)

egen rsesscore = rsum(cworth-cgood)
gen rsesoutcome = 1 if rsesscore <15
replace rsesoutcome = 2 if rsesscore >=15 & rsesscore <=25
replace rsesoutcome = 3 if rsesscore >25 & rsesscore<=30
label define rsesoutcome_lb 1"Low Self Esteem" 2"Normal Self Esteem" 3"High Self Esteem"
label values rsesoutcome rsesoutcome_lb


label variable rsesscore "Raw RSES Score"
label variable rsesoutcome "RSES Outcome"
compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\rsesraw", replace
keep studyid rsesscore rsesoutcome
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\rsesmerge", replace
