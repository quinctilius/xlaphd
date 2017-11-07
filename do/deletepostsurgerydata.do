*I need to create this to drop infections post surgery for the lifetimetrough
*for time being not doing for troughs as this is done byexcel

*11.5.17 - deletes all data post any lung surgery

clear
set graphics off
set more off
use "H:\PhD\Result Data\Stata files\dta files\Working Copies\workingcopydata"
keep if bronchiectasis == 3

reshape long resp infections, i(studyid) j(year)
keep studyid resp* infections* year lungsurgeryyear
drop if year > lungsurgeryyear
*I think it's too much work to exlcude after the exact data, so left it as year (and not used <=, which I did on first version)
su year, d
return list
local maxyear = r(max)

reshape wide
order  _all, alpha
egen infectionresptotal = rowtotal(resp1980-resp`maxyear')

egen infectiontotal= rowtotal(infections1980-infections`maxyear')
keep studyid infectiontotal infectionresptotal

save "H:\PhD\Result Data\Stata files\dta files\Misc Temp dta files\dltpostsurgeryinfections",replace
