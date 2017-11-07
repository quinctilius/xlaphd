**This is the beginning of exporting LFT Data to Sigma Plot nearly not quite
drop if yrpostdx == .
drop if zfev==.
sort yrpostdx
keep yrpostdx zfev studyid everbronchiectasis
sort studyid yrpostdx


sort studyid yrpostdx
quietly by studyid yrpostdx: gen dup = cond(_N==1,0,_n)
drop if dup>1
drop dup
reshape wide zfev, i(studyid) j(yrpostdx)
sort everbronchiectasis  
