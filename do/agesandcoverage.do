**Do File to Count Entries, Ages, Follwup and Data Coverage**
**v1.1 3.1.17

*STATA v14.1

clear
set more off
do h:\open.do
count
tabstat age, by(agegroup) stat(p50 min max mean sd)

tabstat followupperiod, by(agegroup) stat(p50 min max mean sd)
su followupperiod, d
su iggtroughcoverage, d
su troughdatavsfollowup, d
su infectiondataperiod, d
su infectiondatacoverage, d
count if infectiondatacoverage >.99 & infectiondatacoverage <.
count if troughdatavsfollowup >.99 & troughdatavsfollowup <.
**Then I'll need something similar for the iggdose  data
