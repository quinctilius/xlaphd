***Graphs

**Basic Descrip

clear
set more off
set graphics off
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"

twoway (scatter agediagnosis yearbirth) ///
(qfit agediagnosis yearbirth), ytitle(Age at Diagnosis) ///
 ytitle(, margin(medium)) xtitle(Year of Birth) xtitle(, margin(medium)) ///
title(Age at Diagnosis versus Year of Birth) legend(off)
graph export "H:\PhD\Result Data\Graphs\agedxvsyearbirth.eps", replace
graph box agediagnosis, over(everbronchiectasis) ///
title("Age at Diagnosis of XLA") ///
note("Does the Patient have/ever had bronchiectasis?", size(medsmall) ///
position(6) margin(medium)) scheme(lean1)
graph export "H:\PhD\Result Data\Graphs\bronchageatdx.eps", replace
graph box iggc, over(everbronchiectasis) title("Current IgG Trough Levels") ///
note("Does the Patient have/ever had bronchiectasis?", size(medsmall) position(6) margin(medium)) scheme(lean1)
graph export "H:\PhD\Result Data\Graphs\bronchiggc.eps", replace
graph box lifetroughmean, over(everbronchiectasis) ///
title("Mean of Life Time IgG Trough Levels") ///
note("Does the Patient have/ever had bronchiectasis?", size(medsmall) position(6) margin(medium)) scheme(lean1)
graph export "H:\PhD\Result Data\Graphs\bronchlifeigg.eps", replace
graph box lifetroughsd, over(everbronchiectasis) title("SD of Life Time IgG Trough Levels") ///
note("Does the Patient have/ever had bronchiectasis?", size(medsmall) position(6) margin(medium)) scheme(lean1)
graph export "H:\PhD\Result Data\Graphs\bronchlifeiggsd.eps", replace
***Prev 2 graphs are means of all life time trough levels (not seperating pre bronch
graph box followupperiod, over(everbronchiectasis) marker(1, msymbol(circle)) ytitle(Follow Up (In Years)) ytitle(, color(black) margin(medium)) ///
title(Current Follow Up, color(black) margin(medium)) caption(Does the Patient Haver/Ever Had Bronchiectasis, color(black) position(6) margin(medium))
graph export "H:\PhD\Result Data\Graphs\FUbybronch.eps", replace
graph box age, over(everbronchiectasis) marker(1, msymbol(circle)) ytitle(Follow Up (In Years)) ///
ytitle(, color(black) margin(medium)) title(Current Age, color(black) margin(medium)) ///
caption(Does the Patient Haver/Ever Had Bronchiectasis, color(black) position(6) margin(medium))
graph export "H:\PhD\Result Data\Graphs\currentage.eps", replace






*****Infections and IgG Pre/Post
clear
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdataset"
graph box infectionincidencenobronch infectionincidenceprebronch infectionincidencepostbronch, ytitle(Infection Incidence) ///
ytitle(, margin(medium)) title("Infection Incidence") legend(order(1 "No Bronchiectasis" 2 "Pre Bronchiectasis" 3 "Post Bronchiectasis") bexpand)
graph export "H:\PhD\Result Data\Graphs\infectionincidencebygroup.eps", replace
graph box respincidencenobronch respincidenceprebronch respincidencepostbronch, ytitle(Respiratory Infection Incidence) ytitle(, margin(medium)) title("Respiratory Infection Incidence") ///
legend(order(1 "No Bronchiectasis" 2 "Pre Bronchiectasis" 3 "Post Bronchiectasis") bexpand)
graph export "H:\PhD\Result Data\Graphs\respinfectionbygroup.eps", replace
graph box nobronchiggmean prebronchiggmean postbronchiggmean, ytitle(IgG Trough Levels) ytitle(, margin(medium)) ///
title("Mean IgG Trough Levels") legend(order(1 "No Bronchiectasis" 2 "Pre Bronchiectasis" 3 "Post Bronchiectasis"))
graph export "H:\PhD\Result Data\Graphs\igglevelsbygroup.eps", replace
graph box infectionincidence, over(everbronchiectasis) ytitle(Infection Incidence) ytitle(, margin(medsmall)) title("Lifetime Infection Incidence", span) ///
caption("", size(small) position(6) margin(medium) box lcolor(black) bexpand) note("Does the Patient Have/Ever Had Bronchiectasis", ///
size(medium) position(6) margin(medium)) legend(order(0 "No" 1 "Yes") bexpand)
graph export "H:\PhD\Result Data\Graphs\lifetimeinfection.eps", replace
twoway (scatter infectionincidence lifetroughmean1), ytitle(Mean Lifetime Infection Incidence) ytitle(, color(black) margin(medium)) xtitle(Lifetime IgG Mean) xtitle(, color(black) margin(medium)) ///
 xlabel(#10) title(Lifetime IgG Mean vs Lifetime Infection Incidence, color(black) margin(medium)) ///
graphregion(fcolor(white) lcolor(none) lpattern(blank) ifcolor(white) ilcolor(none) ilpattern(blank))
graph export "H:\PhD\Result Data\Graphs\lifeiggvsinfections.eps", replace
twoway (scatter infectionincidence lifetroughmean1), ytitle(Mean Lifetime Infection Incidence) ytitle(, color(black) margin(medium)) xtitle(Lifetime IgG Mean) xtitle(, color(black) margin(medium)) xlabel(#10) by(, title(Lifetime IgG Mean vs Lifetime Infection Incidence, color(black) margin(medium))) ///
by(, graphregion(fcolor(white) lcolor(none) lpattern(blank) ifcolor(white) ilcolor(none) ilpattern(blank))) by(everbronchiectasis)
graph export "H:\PhD\Result Data\Graphs\lifeiggvsinfectionsbybronch.eps", replace
graph box totalinfectionsnobronch infectionsprebronch totalinfectionspostbronch, ytitle(Number of Infections) ytitle(, color(black) margin(medium)) ///
title(Total Number of Infections) legend(order(1 "No Broncheictasis" 2 "Pre Bronchiectasis" 3 "Post Bronchiectasis"))
graph export "H:\PhD\Result Data\Graphs\totalinfections.eps", replace
clear

**KM Follow Up Data
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\kmfollowup"
sts graph
graph export "H:\PhD\Result Data\Graphs\KMbronchFU.eps", replace
sts graph, ci
graph export "H:\PhD\Result Data\Graphs\totalKMbronchciFU.eps", replace
sts graph, by(earlydiagnosis)
graph export "H:\PhD\Result Data\Graphs\KMearlyvslateFU.eps", replace
sts graph, failure title("Risk of Bronchiectasis by Follow Up") ytitle(Cumulitive Risk) xtitle(Years Post Follow Up)
graph export "H:\PhD\Result Data\Graphs\totalfailurebronchFU.eps", replace
sts graph, failure ci
graph export "H:\PhD\Result Data\Graphs\totalfailurebronchciFU.eps", replace
sts graph, failure by(earlydiagnosis) ytitle(Cumulitive Risk) xtitle(Years Post Follow Up) ///
title("Lifetime Risk of Bronchiectasis by Follow Up") legend(order(1 ///
"Early Diagnosis" 2 "Late Diagnosis"))
graph export "H:\PhD\Result Data\Graphs\failureearlyvslateFU.eps", replace
clear

***KM Follow UP exlcuding those who had bronch at >12 mnths XLA Dx
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\kmfollowup1"
sts graph
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\KMbronchFU1.eps", replace
sts graph, ci
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\totalKMbronchciFU1.eps", replace
sts graph, by(earlydiagnosis)
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\KMearlyvslateFU1.eps", replace
sts graph, failure title("Risk of Bronchiectasis by Follow Up") ytitle(Cumulitive Risk) xtitle(Years Post Follow Up)
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\totalfailurebronchFU1.eps", replace
sts graph, failure ci
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\totalfailurebronchciFU1.eps", replace
sts graph, failure by(earlydiagnosis) ytitle(Cumulitive Risk) xtitle(Years Post Follow Up) ///
title("Lifetime Risk of Bronchiectasis by Follow Up") legend(order(1 ///
"Early Diagnosis" 2 "Late Diagnosis"))
graph export "H:\PhD\Result Data\Graphs\KM Data\followupexclusion\failureearlyvslateFU1.eps", replace
clear


***KM Data by Age
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\Data sets for analysis\currentworkingdatasetkm"
**need to do p values a somepoint ?Cox regression?
sts graph, censored(single)
graph export "H:\PhD\Result Data\Graphs\totalKMbronch.eps", replace
sts graph, ci censored(single)
graph export "H:\PhD\Result Data\Graphs\totalKMbronchci.eps", replace
sts graph, by(earlydiagnosis)
graph export "H:\PhD\Result Data\Graphs\KMearlyvslate.eps", replace
sts graph, failure ytitle(Cumilitive Risk) ytitle(, color(black) margin(medium)) xtitle(Age) xtitle(, color(black) margin(medium)) ///
title(Cumilitive Risk of Bronchiectasis by Age, size(large) color(black) margin(medium)) graphregion(fcolor(white)) plotregion(fcolor(ltbluishgray8))
graph export "H:\PhD\Result Data\Graphs\totalfailurebronch.eps", replace
sts graph, failure ci censored(single) title("Risk of Bronchiectasis by Age") ytitle(Cumulitive Risk) xtitle(Age)
graph export "H:\PhD\Result Data\Graphs\totalfailurebronchci.eps", replace
sts graph, failure by(earlydiagnosis) ytitle(Cumulitive Risk) xtitle(Age) ///
title("Lifetime Risk of Bronchiectasis by Age") legend(order(1 ///
"Early Diagnosis" 2 "Late Diagnosis"))
graph export "H:\PhD\Result Data\Graphs\failureearlyvslate.eps", replace

***Lung Function Graphs
***I'm still messing about with this next graph
do "H:\PhD\Result Data\Stata files\do\ratesovertimegraphs"

