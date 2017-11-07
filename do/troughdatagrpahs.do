*Beginnings of trying to organise iggtrough data

reshape long igg, i(studyid) j(year)
drop if igg==.

***right few options to get a grapg looking at trend over time
* could create cat variables for each year and plot multiple boxes or whatever in sigma
* could then calculate menas and plot these as line? would ideally want SD for each point as well.  
* I'm sure this is possible somehow.  I quite like this 2nd option