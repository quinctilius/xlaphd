** Creation of dummy variables to allow comparison of Infection, 
**Resp infection and IgG levels by bronch or not

* I have not yet included stats I probbably do this ad hoc
**When testing pre/post these I have classed as dependant variables and therefore
** I will use the signrank for these

*All Infections first
gen novspreinf = infectionincidencenobronch
replace novspreinf = infectionincidenceprebronch if novspreinf==.

gen novspostinf = infectionincidencenobronch
replace novspostinf = infectionincidencepostbronch if novspostinf==.

*Now Resp Infections
gen novspreresp = respincidencenobronch
replace novspreresp = respincidenceprebronch if novspreresp==.

gen novspostresp = respincidencenobronch
replace novspostresp = respincidencepostbronch if novspostresp==.

*Now IgG levels
gen novspreigg = nobronchiggmean
replace novspreigg = prebronchigg if novspreigg==.

gen novspostigg = nobronchiggmean
replace novspostigg = postbronchiggmean if novspostigg==.
