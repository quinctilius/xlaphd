**Infection Data Results
tabstat agediagnosis, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat age, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat followupperiod, by(everbronchiectasis) stat(p50 min max mean sd)
tab everbronchiectasis

tabstat lifetroughmean, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat prebronchiggmean postbronchiggmean nobronchiggmean /// 
, stat(p50 min max mean sd)
tabstat iggc, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat infectionincidence, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat infectionincidenceprebronch infectionincidencepostbronch infectionincidencenobronch /// 
, stat(p50 min max mean sd)
tabstat respinfectionincidence, by(everbronchiectasis) stat(p50 min max mean sd)
tabstat respincidenceprebronch respincidencepostbronch respincidencenobronch /// 
, stat(p50 min max mean sd)
tabstat infectionincidence, by(agegroup) stat(p50 min max mean sd)
tabstat respinfectionincidence, by(agegroup) stat(p50 min max mean sd)

su agedxbronch, d
su followuptolungdx1 if everbronchiectasis==1, d
