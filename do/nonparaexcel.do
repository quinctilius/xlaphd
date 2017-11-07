**STATA v14.0
*Ben Shillitoe
*b.shillitoe2@ncl.ac.uk

*XLA PhD Project

*Exporting Non Para Values to Excel
*v1.0 9/5/17 - 1st iteration - Pre/Post Infec and IggMeans
			*As of yet I can't seem to have the analysis and excel do file in two parts as macros are disappearing
			* this still happens even when using global macros

clear
set more off
do h:\open
*--------Setting Excel File
*Bronch vs no bronch
putexcel set "H:\PhD\Result Data\Excel Sheets\nonparaexcelresults.xlsx", sheet(Non Parametric Tests) replace
ranksum lifetroughmean, by(everbronchiectasis)
local iggmeanp = 2*normprob(-abs(r(z)))
ranksum infectionincidence, by(everbronchiectasis)
local inficidencep = 2*normprob(-abs(r(z)))
ranksum  respinfectionincidence, by(everbronchiectasis)
local respincidencep = 2*normprob(-abs(r(z)))
putexcel A1:D1 = "No Bronch vs Bronch ranksum Data", merge vcenter hcenter bold underline font(16) border(all double)
putexcel B2= "Mean IgG Trough Levels", vcenter hcenter bold underline font(16) border(all double)
putexcel C2 = "Infection Incidence", vcenter hcenter bold underline font(16) border(all double)
putexcel D2 = "Respiratory Infection Incidence",vcenter hcenter bold underline font(16) border(all double)
putexcel A3 = "P Value", vcenter hcenter bold underline font(16) border(all double)
putexcel B3 = `iggmeanp', nformat("#.##")
putexcel C3 = `inficidencep', nformat ("#.##") 
putexcel D3  = `respincidencep', nformat ("#.##")

*---------Pre/Post Bronch Data
keep studyid everbronchiectasis respincidencenobronch infectionincidencenobronch nobronchiggmean prebronchiggmean infectionincidenceprebronch respincidenceprebronch postbronchiggmean infectionincidencepostbronch respincidencepostbronch
rename prebronchiggmean iggmeanprebronch
rename nobronchiggmean iggmeannobronch
rename postbronchiggmean iggmeanpostbronch
reshape long iggmean infectionincidence respincidence, i(studyid) j(period) string
drop if everbronchiectasis == 0 & period == "prebronch"
drop if everbronchiectasis == 0 & period ==  "postbronch"
drop if everbronchiectasis == 1 & period == "nobronch"
ranksum iggmean if everbronchiectasis == 1, by(period)
local iggmeanp = 2*normprob(-abs(r(z)))
ranksum infectionincidence if everbronchiectasis == 1, by(period)
local inficidencep = 2*normprob(-abs(r(z)))
ranksum respincidence if everbronchiectasis == 1, by(period)
local respincidencep = 2*normprob(-abs(r(z)))
putexcel A4:D4 = "Pre Bronch/Post Bronch ranksum Data", merge vcenter hcenter bold underline font(16) border(all double)
putexcel B5= "Mean IgG Trough Levels", vcenter hcenter bold underline font(16) border(all double)
putexcel C5 = "Infection Incidence", vcenter hcenter bold underline font(16) border(all double)
putexcel D5 = "Respiratory Infection Incidence",vcenter hcenter bold underline font(16) border(all double)
putexcel A6 = "P Value", vcenter hcenter bold underline font(16) border(all double)
putexcel B6 = `iggmeanp', nformat("#.##")
putexcel C6 = `inficidencep', nformat ("#.##") 
putexcel D6  = `respincidencep', nformat ("#.##")


**No bronch vs pre bronch

drop if period == "postbronch"
ranksum iggmean, by(period)
local iggmeanp = 2*normprob(-abs(r(z)))
ranksum infectionincidence, by(period)
local inficidencep = 2*normprob(-abs(r(z)))
ranksum respincidence, by(period)
local respincidencep = 2*normprob(-abs(r(z)))
putexcel A7:D7 = "Pre/No Bronch ranksum Data", merge vcenter hcenter bold underline font(16) border(all double)
putexcel B8= "Mean IgG Trough Levels", vcenter hcenter bold underline font(16) border(all double)
putexcel C8 = "Infection Incidence", vcenter hcenter bold underline font(16) border(all double)
putexcel D8 = "Respiratory Infection Incidence",vcenter hcenter bold underline font(16) border(all double)
putexcel A9 = "P Value", vcenter hcenter bold underline font(16) border(all double)
putexcel B9 = `iggmeanp', nformat("#.##")
putexcel C9 = `inficidencep', nformat ("#.##") 
putexcel D9  = `respincidencep', nformat ("#.##")



