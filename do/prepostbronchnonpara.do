**STATA v14.0
*Ben Shillitoe
*b.shillitoe2@ncl.ac.uk

*XLA PhD Project

**Non Parametric Tests comparing Pre and Post Bronch Variables
*v1.0 9/5/17 - 1st iteration - reshape and compare infection, iggmean

clear
set more off
do h:\open
drop if everbronchiectasis == 0
keep studyid prebronchiggmean infectionincidenceprebronch respincidenceprebronch postbronchiggmean infectionincidencepostbronch respincidencepostbronch
rename prebronchiggmean iggmeanprebronch
rename postbronchiggmean iggmeanpostbronch
reshape long iggmean infectionincidence respincidence, i(studyid) j(period) string
ranksum iggmean, by(period)
local iggmeanp = 2*normprob(-abs(r(z)))
ranksum infectionincidence, by(period)
local inficidencep = 2*normprob(-abs(r(z)))
ranksum respincidence, by(period)
local respincidencep = 2*normprob(-abs(r(z)))
