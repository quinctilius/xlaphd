**Diagnosis Data

tab geneticdefect, m
tab btkexpress, m
**What is the BTK expression for those with no genetic defect
tab btkexpress if geneticdefect!=2
tab fhx, m
tab screenedfhx if fhx==2
**Need to fiddle these as <x values are formatting these fields as string
su igadiagnosis, d
su igmdiagnosis, d
su iggdiagnosis, d

su cd1920pdiagnosis,d
tabstat agediagnosis, by(moderndiagnosis) stat(p50 min max mean sd)
