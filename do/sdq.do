***STATA v14.1
***Do file for scoring SDQ Scores

clear 
set more off

*** Recoding variables and then scoring the parent SDQ scores 4-17 year olds
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\Parent4-17 SDQ.xlsx", firstrow

recode pobeys (0=2) (1=1) (2=0) (else=.), gen(qobeys)
recode preflect (0=2) (1=1) (2=0) (else=.) , gen(qreflect)
recode pattends (0=2) (1=1) (2=0) (else=.), gen(qattends)
recode pfriend (0=2) (1=1) (2=0) (else=.), gen(qfriend)
recode ppopular (0=2) (1=1) (2=0) (else=.), gen(qpopular)

recode pdistres (0=0) (1=0) (2=1) (3=2) (.=0), gen(qqdistres)
recode pimphome (0=0) (1=0) (2=1) (3=2) (.=0), gen(qqimphome)
recode pimpfrie (0=0) (1=0) (2=1) (3=2) (.=0), gen(qqimpfrie)
recode pimpclas (0=0) (1=0) (2=1) (3=2) (.=0), gen(qqimpclas)
recode pimpleis (0=0) (1=0) (2=1) (3=2) (.=0), gen(qqimpleis)

egen nemotion=robs(psomatic pworries punhappy pclingy pafraid)
egen pemotion=rmean(psomatic pworries punhappy pclingy pafraid) if nemotion>2
replace pemotion=round(pemotion*5)

egen nconduct=robs(ptantrum qobeys pfights plies psteals)
egen pconduct=rmean(ptantrum qobeys pfights plies psteals) if nconduct>2
replace pconduct=round(pconduct*5)

egen nhyper=robs(prestles pfidgety pdistrac qreflect qattends)
egen phyper=rmean(prestles pfidgety pdistrac qreflect qattends) if nhyper>2
replace phyper=round(phyper*5)

egen npeer=robs(ploner qfriend qpopular pbullied poldbest)
egen ppeer=rmean(ploner qfriend qpopular pbullied poldbest) if npeer>2
replace ppeer=round(ppeer*5)

egen nprosoc=robs(pconsid pshares pcaring pkind phelpout)
egen pprosoc=rmean(pconsid pshares pcaring pkind phelpout) if nprosoc>2
replace pprosoc=round(pprosoc*5)

egen nimpact=robs(pdistres pimphome pimpfrie pimpclas pimpleis)
gen pimpact=qqdistres+qqimphome+qqimpfrie+qqimpclas+qqimpleis if (nimpact!=0)
replace pimpact=0 if pebddiff==0

drop qobeys qreflect qattends qfriend qpopular qqdistres qqimphome qqimpfrie qqimpclas qqimpleis nemotion nconduct nhyper npeer nprosoc nimpact

gen pebdtot=pemotion+pconduct+phyper+ppeer
label variable pemotion "Parent SDQ Emotion Score"
label variable pconduct "Parent SDQ Conduct Score"
label variable phyper "Parent SDQ Hyperactivity Score"
label variable ppeer "Parent SDQ Peer Score"
label variable pprosoc "Parent SDQ ProScoial Score"
label variable pimpact "Parent SDQ Impact Score"
label variable pebdtot "Parent SDQ Total Score"

compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\parent4-17sdq", replace
keep studyid pemotion-pebdtot
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\parent4-17sdqmerge", replace

*** Recoding variables and then scoring the child SDQ scores
clear
import excel using "H:\PhD\Result Data\Excel Sheets\QoL Questionnaires\Self11-17 SDQ.xlsx", firstrow
recode sobeys (0=2) (1=1) (2=0) (else=.), gen(robeys)
recode sreflect (0=2) (1=1) (2=0) (else=.) , gen(rreflect)
recode sattends (0=2) (1=1) (2=0) (else=.), gen(rattends)
recode sfriend (0=2) (1=1) (2=0) (else=.), gen(rfriend)
recode spopular (0=2) (1=1) (2=0) (else=.), gen(rpopular)

recode sdistres (0=0) (1=0) (2=1) (3=2) (.=0), gen(rrdistres)
recode simphome (0=0) (1=0) (2=1) (3=2) (.=0), gen(rrimphome)
recode simpfrie (0=0) (1=0) (2=1) (3=2) (.=0), gen(rrimpfrie)
recode simpclas (0=0) (1=0) (2=1) (3=2) (.=0), gen(rrimpclas)
recode simpleis (0=0) (1=0) (2=1) (3=2) (.=0), gen(rrimpleis)

egen nemotion=robs(ssomatic sworries sunhappy sclingy safraid)
egen semotion=rmean(ssomatic sworries sunhappy sclingy safraid) if nemotion>2
replace semotion=round(semotion*5)

egen nconduct=robs(stantrum robeys sfights slies ssteals)
egen sconduct=rmean(stantrum robeys sfights slies ssteals) if nconduct>2
replace sconduct=round(sconduct*5)

egen nhyper=robs(srestles sfidgety sdistrac rreflect rattends)
egen shyper=rmean(srestles sfidgety sdistrac rreflect rattends) if nhyper>2
replace shyper=round(shyper*5)

egen npeer=robs(sloner rfriend rpopular sbullied soldbest)
egen speer=rmean(sloner rfriend rpopular sbullied soldbest) if npeer>2
replace speer=round(speer*5)

egen nprosoc=robs(sconsid sshares scaring skind shelpout)
egen sprosoc=rmean(sconsid sshares scaring skind shelpout) if nprosoc>2
replace sprosoc=round(sprosoc*5)

egen nimpact=robs(sdistres simphome simpfrie simpclas simpleis)
gen simpact=rrdistres+rrimphome+rrimpfrie+rrimpclas+rrimpleis if (nimpact!=0)
replace simpact=0 if sebddiff==0

drop robeys rreflect rattends rfriend rpopular rrdistres rrimphome rrimpfrie rrimpclas rrimpleis nemotion nconduct nhyper npeer nprosoc nimpact

gen sebdtot=semotion+sconduct+shyper+speer
label variable semotion "Self SDQ Emotion Score"
label variable sconduct "Self SDQ Conduct Score"
label variable shyper "Self SDQ Hyperactivity Score"
label variable speer "Self SDQ Peer Score"
label variable sprosoc "Self SDQ ProScoial Score"
label variable simpact "Self SDQ Impact Score"
label variable sebdtot "Self SDQ Total Score"

compress
save "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\self11-17sdq", replace
keep studyid semotion-sebdtot
save "H:\PhD\Result Data\Stata files\dta files\Indivual DataSet Sections for Merge\self11-17sdqmerge", replace

