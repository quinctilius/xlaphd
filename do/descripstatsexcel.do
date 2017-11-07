*PhD Do File Exporting Descriptive Stats to Excel
*Stata v14.1
*Ben Shillitoe
*b.shillitoe2@ncl.ac.uk

*v1.2 5.5.17 - I have now added this as seperate do file to export descrip stats
* and have a sep one for each section eg LFT, QoL.  They will all be run by the mast excelexport do file
*v1.1 4.5.17 - Added IQR
*				Put SD and IQR to Mean and Med as brackets
*					by storing these values as strings
*v1.0 25.1.17 - First iteration


*Using Chuck Huber's StatBlog Tutorial 
*starting here http://blog.stata.com/2017/01/10/creating-excel-tables-with-putexcel-part-1-introduction-and-formatting/
*This is simply the do file, later on I think Chuck will describe how to write
*a better program

*---------------------------------------------------------------------------------

clear
set more off
do h:\open.do

putexcel set "H:\PhD\Result Data\Excel Sheets\descripexcelresults.xlsx", sheet(DescriptiveStats1) replace
**Let's first export the ages by group
putexcel A1:F1 = "Age", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B2 = "Median (IQR)", hcenter bold border(bottom)
putexcel C2 = "Min", hcenter bold border(bottom)
putexcel D2 = "Max", hcenter bold border(bottom)
putexcel E2 = "Mean (SD)", hcenter bold border(bottom)
putexcel A3 = "All", left bold border(right)
putexcel A4 = "Paediatric", left italic border(right)
putexcel A5 = "Adult", left italic border(right)
putexcel A6 = "Never Bronchiectasis", left italic border(right)
putexcel A7 = "Bronchiectasis", left italic border(right)
putexcel F2 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G2 = "Skewness", hcenter bold border(bottom)
putexcel H2 = "Kertosis", hcenter bold border(bottom)
putexcel I2 = "SK P Values", hcenter bold border(bottom)
*All Ages
su age, d
return list
local agemed = string(`r(p50)', "%9.2f")
local ageiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agemediqr = "`agemed' (`ageiqr')"
putexcel B3 = "`agemediqr'"
putexcel C3 = `r(min)', nformat("#.##")
putexcel D3 = `r(max)', nformat("#.##")
local agemean = string(`r(mean)', "%9.2f")
local agesd = string(`r(sd)', "%9.2f")
local agemeansd = "`agemean' (`agesd')"
putexcel E3 = "`agemeansd'"
*Paediatric Ages
su age if agegroup==1, d
return list
local agemed = string(`r(p50)', "%9.2f")
local ageiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agemediqr = "`agemed' (`ageiqr')"
putexcel B4 = "`agemediqr'"
putexcel C4 = `r(min)', nformat("#.##")
putexcel D4 = `r(max)', nformat("#.##")
local agemean = string(`r(mean)', "%9.2f")
local agesd = string(`r(sd)', "%9.2f")
local agemeansd = "`agemean' (`agesd')"
putexcel E4 = "`agemeansd'"
*Adult Ages
su age if agegroup ==2, d
return list
local adultagemed = string(`r(p50)', "%9.2f")
local adultageiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local adultagemediqr = "`adultagemed' (`adultageiqr')"
putexcel B5 = "`adultagemediqr'"
putexcel C5 = `r(min)', nformat("#.##")
putexcel D5 = `r(max)', nformat("#.##")
local adultagemean = string(`r(mean)', "%9.2f")
local adultagesd = string(`r(sd)', "%9.2f")
local adultagemeansd = "`adultagemean' (`adultagesd')"
putexcel E5 = "`adultagemeansd'"
*Never Bronchiectasis Ages
su age if everbronchiectasis==0, d
return list
local agemed = string(`r(p50)', "%9.2f")
local ageiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agemediqr = "`agemed' (`ageiqr')"
putexcel B6 = "`agemediqr'"
putexcel C6 = `r(min)', nformat("#.##")
putexcel D6 = `r(max)', nformat("#.##")
local agemean = string(`r(mean)', "%9.2f")
local agesd = string(`r(sd)', "%9.2f")
local agemeansd = "`agemean' (`agesd')"
putexcel E6 = "`agemeansd'"
su age if everbronchiectasis==1, d
return list
local agemed = string(`r(p50)', "%9.2f")
local ageiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agemediqr = "`agemed' (`ageiqr')"
putexcel B7 = "`agemediqr'"
putexcel C7 = `r(min)', nformat("#.##")
putexcel D7 = `r(max)', nformat("#.##")
local agemean = string(`r(mean)', "%9.2f")
local agesd = string(`r(sd)', "%9.2f")
local agemeansd = "`agemean' (`agesd')"
putexcel E7 = "`agemeansd'"
*Normality Tests for Ages ---------------------------------------------
swilk age
return list
putexcel F3 = `r(p)', nformat ("#.###")
swilk age if agegroup == 1
return list
putexcel F4 = `r(p)', nformat ("#.###")
swilk age if agegroup == 2
return list
putexcel F5 = `r(p)', nformat ("#.###")
swilk age if everbronchiectasis == 0
return list
putexcel F6 = `r(p)', nformat ("#.###")
swilk age if everbronchiectasis == 1
return list
putexcel F7 = `r(p)', nformat ("#.###")
sktest age 
return list
putexcel G3 = `r(P_skew)', nformat ("#.###")
putexcel H3 = `r(P_kurt)', nformat ("#.###")
putexcel I3 = `r(P_chi2)', nformat ("#.###")
sktest age if agegroup == 1 
return list
putexcel G4 = `r(P_skew)', nformat ("#.###")
putexcel H4 = `r(P_kurt)', nformat ("#.###")
putexcel I4 = `r(P_chi2)', nformat ("#.###")
sktest age if agegroup == 2
return list
putexcel G5 = `r(P_skew)', nformat ("#.###")
putexcel H5 = `r(P_kurt)', nformat ("#.###")
putexcel I5 = `r(P_chi2)', nformat ("#.###")
sktest age if everbronchiectasis == 0
return list
putexcel G6 = `r(P_skew)', nformat ("#.###")
putexcel H6 = `r(P_kurt)', nformat ("#.###")
putexcel I6 = `r(P_chi2)', nformat ("#.###")
sktest age if everbronchiectasis == 1
return list
putexcel G7 = `r(P_skew)', nformat ("#.###")
putexcel H7 = `r(P_kurt)', nformat ("#.###")
putexcel I7 = `r(P_chi2)', nformat ("#.###")

*--------------------------------------------------------
**Now Follow up by Group
putexcel A9:F9 = "Follow Up", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B10 = "Median (IQR)", hcenter bold border(bottom)
putexcel C10 = "Min", hcenter bold border(bottom)
putexcel D10 = "Max", hcenter bold border(bottom)
putexcel E10 = "Mean (SD)", hcenter bold border(bottom)
putexcel A11 = "All", left bold border(right)
putexcel A12 = "Paediatric", left italic border(right)
putexcel A13 = "Adult", left italic border(right)
putexcel A14 = "Never Bronchiectasis", left italic border(right)
putexcel A15 = "Bronchiectasis", left italic border(right)
*All followup
su followupperiod, d
return list
local fumed = string(`r(p50)', "%9.2f")
local fuiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fumediqr = "`fumed' (`fuiqr')"
putexcel B11 = "`fumediqr'"
putexcel C11 = `r(min)', nformat("#.##")
putexcel D11 = `r(max)', nformat("#.##")
local fumean = string(`r(mean)', "%9.2f")
local fusd = string(`r(sd)', "%9.2f")
local fumeansd = "`fumean' (`fusd')"
putexcel E11 = "`fumeansd'"
*Paediatric FU
su followupperiod if agegroup==1, d
return list
local fumed = string(`r(p50)', "%9.2f")
local fuiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fumediqr = "`fumed' (`fuiqr')"
putexcel B12 = "`fumediqr'"
putexcel C12 = `r(min)', nformat("#.##")
putexcel D12 = `r(max)', nformat("#.##")
local fumean = string(`r(mean)', "%9.2f")
local fusd = string(`r(sd)', "%9.2f")
local fumeansd = "`fumean' (`fusd')"
putexcel E12 = "`fumeansd'"
su followupperiod if agegroup ==2, d
return list
local fumed = string(`r(p50)', "%9.2f")
local fuiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fumediqr = "`fumed' (`fuiqr')"
putexcel B13 = "`fumediqr'"
putexcel C13 = `r(min)', nformat("#.##")
putexcel D13 = `r(max)', nformat("#.##")
local fumean = string(`r(mean)', "%9.2f")
local fusd = string(`r(sd)', "%9.2f")
local fumeansd = "`fumean' (`fusd')"
putexcel E13 = "`fumeansd'"
*Never Bronchiectasis FU
su followupperiod if everbronchiectasis==0, d
return list
local fumed = string(`r(p50)', "%9.2f")
local fuiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fumediqr = "`fumed' (`fuiqr')"
putexcel B14 = "`fumediqr'"
putexcel C14 = `r(min)', nformat("#.##")
putexcel D14 = `r(max)', nformat("#.##")
local fumean = string(`r(mean)', "%9.2f")
local fusd = string(`r(sd)', "%9.2f")
local fumeansd = "`fumean' (`fusd')"
putexcel E14 = "`fumeansd'"
*FU Ever Bronch
su followupperiod if everbronchiectasis==1, d
local fumed = string(`r(p50)', "%9.2f")
local fuiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fumediqr = "`fumed' (`fuiqr')"
putexcel B15 = "`fumediqr'"
putexcel C15 = `r(min)', nformat("#.##")
putexcel D15 = `r(max)', nformat("#.##")
local fumean = string(`r(mean)', "%9.2f")
local fusd = string(`r(sd)', "%9.2f")
local fumeansd = "`fumean' (`fusd')"
putexcel E15 = "`fumeansd'"
*Normality Tests for followupperiods ---------------------------------------------
putexcel F10 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G10 = "Skewness", hcenter bold border(bottom)
putexcel H10 = "Kertosis", hcenter bold border(bottom)
putexcel I10 = "SK P Values", hcenter bold border(bottom)
swilk followupperiod
return list
putexcel F11 = `r(p)', nformat ("#.###")
swilk followupperiod if agegroup == 1
return list
putexcel F12 = `r(p)', nformat ("#.###")
swilk followupperiod if agegroup == 2
return list
putexcel F13 = `r(p)', nformat ("#.###")
swilk followupperiod if everbronchiectasis == 0
return list
putexcel F14 = `r(p)', nformat ("#.###")
swilk followupperiod if everbronchiectasis == 1
return list
putexcel F15 = `r(p)', nformat ("#.###")
sktest followupperiod 
return list
putexcel G11 = `r(P_skew)', nformat ("#.###")
putexcel H11 = `r(P_kurt)', nformat ("#.###")
putexcel I11 = `r(P_chi2)', nformat ("#.###")
sktest followupperiod if agegroup == 1 
return list
putexcel G12 = `r(P_skew)', nformat ("#.###")
putexcel H12 = `r(P_kurt)', nformat ("#.###")
putexcel I2 = `r(P_chi2)', nformat ("#.###")
sktest followupperiod if agegroup == 2
return list
putexcel G13 = `r(P_skew)', nformat ("#.###")
putexcel H13 = `r(P_kurt)', nformat ("#.###")
putexcel I13 = `r(P_chi2)', nformat ("#.###")
sktest followupperiod if everbronchiectasis == 0
return list
putexcel G14 = `r(P_skew)', nformat ("#.###")
putexcel H14 = `r(P_kurt)', nformat ("#.###")
putexcel I14 = `r(P_chi2)', nformat ("#.###")
sktest followupperiod if everbronchiectasis == 1
return list
putexcel G15 = `r(P_skew)', nformat ("#.###")
putexcel H15 = `r(P_kurt)', nformat ("#.###")
putexcel I15 = `r(P_chi2)', nformat ("#.###")
**------------------------------------------------------------

**Available IgG Trough Data
putexcel A17:F17 = "Available IgG Trough Data", merge vcenter ///
hcenter bold underline font(16) border(bottom double)
putexcel B18 = "Median (IQR)", hcenter bold border(bottom)
putexcel C18 = "Min", hcenter bold border(bottom)
putexcel D18 = "Max", hcenter bold border(bottom)
putexcel E18 = "Mean (SD)", hcenter bold border(bottom)
putexcel A19 = "IgG Trough Data (Years)", left bold border(right)
putexcel A20 = "vs Follow Up(%)", left italic border(right)
**Available IgG Normality------------
putexcel F18 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G18 = "Skewness", hcenter bold border(bottom)
putexcel H18 = "Kertosis", hcenter bold border(bottom)
putexcel I18 = "SK P Values", hcenter bold border(bottom)
swilk iggtroughcoverage
return list
putexcel F19 = `r(p)', nformat ("#.###")
sktest iggtroughcoverage
return list
putexcel G19 = `r(P_skew)', nformat ("#.###")
putexcel H19 = `r(P_kurt)', nformat ("#.###")
putexcel I19 = `r(P_chi2)', nformat ("#.###")
*Years of IgG Trough Data
su iggtroughcoverage, d
return list
local iggdatamed = string(`r(p50)', "%9.2f")
local iggdataiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggdatamediqr = "`iggdatamed' (`iggdataiqr')"
putexcel B19 = "`iggdatamediqr'"
putexcel C19 = `r(min)', nformat("#.##")
putexcel D19 = `r(max)', nformat("#.##")
local iggdatamean = string(`r(mean)', "%9.2f")
local iggdatasd = string(`r(sd)', "%9.2f")
local iggdatameansd = "`iggdatamean' (`iggdatasd')"
putexcel E19 = "`iggdatameansd'"
*Trough Data vs Total Follow Up (%)
su troughdatavsfollowup, d
return list
local iggdatamed = string(`r(p50)', "%9.2f")
local iggdataiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggdatamediqr = "`iggdatamed' (`iggdataiqr')"
putexcel B20 = "`iggdatamediqr'"
putexcel C20 = `r(min)', nformat("#.##")
putexcel D20 = `r(max)', nformat("#.##")
local iggdatamean = string(`r(mean)', "%9.2f")
local iggdatasd = string(`r(sd)', "%9.2f")
local iggdatameansd = "`iggdatamean' (`iggdatasd')"
putexcel E20 = "`iggdatameansd'"
*Is there a genetic Diagnosis?
putexcel A22:C22 = "Genetic Diagnosis", merge vcenter ///
hcenter bold underline font(16) border(bottom double)
tab geneticdefect, missing matcell(freq) matrow(names)
matrix list freq
matrix list names
putexcel  B23="Frequency", hcenter bold border(bottom)
putexcel C23="Percent", hcenter bold border(bottom)
putexcel A24="No", left italic border(right)
putexcel A25="Yes", left italic border(right)
putexcel A26="Unknown", left italic border(right) 
putexcel B24=matrix(freq) C24=matrix(freq/r(N))
putexcel A23=""
*BTK Expression
putexcel A28:C28 = "BTK Expression", merge vcenter ///
hcenter bold underline font(16) border(bottom double)
tab btkexpress, missing matcell(freq) matrow(names)
matrix list freq
matrix list names
putexcel  B29="Frequency", hcenter bold border(bottom)
putexcel C29="Percent", hcenter bold border(bottom)
putexcel A30="Absent", left italic border(right)
putexcel A31="Normal", left italic border(right)
putexcel A32="Reduced", left italic border(right)
putexcel A33="Unknown", left italic border(right) 
putexcel B30=matrix(freq) C30=matrix(freq/r(N))
*BTK Expression if No genetic defect
putexcel A34:F34 = "BTK Expression if no Genetic Defect", merge vcenter ///
hcenter bold underline font(16) border(bottom double)
tab btkexpress if geneticdefect !=2, missing matcell(freq) matrow(names)
matrix list freq
matrix list names
putexcel  B35="Frequency", hcenter bold border(bottom)
putexcel C35="Percent", hcenter bold border(bottom)
putexcel A36="Absent", left italic border(right)
putexcel A37="Normal", left italic border(right)
putexcel A38="Reduced", left italic border(right)
putexcel A39="Unknown", left italic border(right) 
putexcel B36=matrix(freq) C36=matrix(freq/r(N))
*Age of Diagnosis
putexcel A41:F41 = "Age at Diagnosis", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B42 = "Median (IQR)", hcenter bold border(bottom)
putexcel C42 = "Min", hcenter bold border(bottom)
putexcel D42 = "Max", hcenter bold border(bottom)
putexcel E42 = "Mean (SD)", hcenter bold border(bottom)
putexcel A43 = "All", left bold border(right)
putexcel A44 = "Pre 2000", left italic border(right)
putexcel A45 = "Post 2000", left italic border(right)
putexcel A46 = "Never Bronchiectasis", left italic border(right)
putexcel A47 = "Bronchiectasis", left italic border(right)
*All Ages
su agediagnosis, d
return list
local agedxmed = string(`r(p50)', "%9.2f")
local agedxiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agedxmediqr = "`agedxmed' (`agedxiqr')"
putexcel B43 = "`agedxmediqr'"
putexcel C43 = `r(min)', nformat("#.##")
putexcel D43 = `r(max)', nformat("#.##")
local agedxmean = string(`r(mean)', "%9.2f")
local agedxsd = string(`r(sd)', "%9.2f")
local agedxmeansd = "`agedxmean' (`agedxsd')"
putexcel E43 = "`agedxmeansd'"
*Pre 2000 Ages
su agediagnosis if moderndiagnosis==1, d
return list
local agedxmed = string(`r(p50)', "%9.2f")
local agedxiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agedxmediqr = "`agedxmed' (`agedxiqr')"
putexcel B44 = "`agedxmediqr'"
putexcel C44 = `r(min)', nformat("#.##")
putexcel D44 = `r(max)', nformat("#.##")
local agedxmean = string(`r(mean)', "%9.2f")
local agedxsd = string(`r(sd)', "%9.2f")
local agedxmeansd = "`agedxmean' (`agedxsd')"
putexcel E44 = "`agedxmeansd'"
*Post 2000 Ages
su agediagnosis if moderndiagnosis==2, d
return list
local agedxmed = string(`r(p50)', "%9.2f")
local agedxiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agedxmediqr = "`agedxmed' (`agedxiqr')"
putexcel B45 = "`agedxmediqr'"
putexcel C45 = `r(min)', nformat("#.##")
putexcel D45 = `r(max)', nformat("#.##")
local agedxmean = string(`r(mean)', "%9.2f")
local agedxsd = string(`r(sd)', "%9.2f")
local agedxmeansd = "`agedxmean' (`agedxsd')"
putexcel E45 = "`agedxmeansd'"
*If Never Bronch
su agediagnosis if everbronchiectasis==0, d
return list
local agedxmed = string(`r(p50)', "%9.2f")
local agedxiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agedxmediqr = "`agedxmed' (`agedxiqr')"
putexcel B46 = "`agedxmediqr'"
putexcel C46 = `r(min)', nformat("#.##")
putexcel D46 = `r(max)', nformat("#.##")
local agedxmean = string(`r(mean)', "%9.2f")
local agedxsd = string(`r(sd)', "%9.2f")
local agedxmeansd = "`agedxmean' (`agedxsd')"
putexcel E46 = "`agedxmeansd'"
*If Ever Bronchiectasis
su agediagnosis if everbronchiectasis==1, d
return list
local agedxmed = string(`r(p50)', "%9.2f")
local agedxiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local agedxmediqr = "`agedxmed' (`agedxiqr')"
putexcel B47 = "`agedxmediqr'"
putexcel C47 = `r(min)', nformat("#.##")
putexcel D47 = `r(max)', nformat("#.##")
local agedxmean = string(`r(mean)', "%9.2f")
local agedxsd = string(`r(sd)', "%9.2f")
local agedxmeansd = "`agedxmean' (`agedxsd')"
putexcel E47 = "`agedxmeansd'"

***Normality for Age Diagnosis
putexcel F42 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G42 = "Skewness", hcenter bold border(bottom)
putexcel H42 = "Kertosis", hcenter bold border(bottom)
putexcel I42 = "SK P Values", hcenter bold border(bottom)
swilk agediagnosis
return list
putexcel F43 = `r(p)', nformat ("#.###")
swilk agediagnosis if everbronchiectasis == 0
return list
putexcel F46 = `r(p)', nformat ("#.###")
swilk agediagnosis if everbronchiectasis == 1
return list
putexcel F47 = `r(p)', nformat ("#.###")
sktest agediagnosis 
return list
putexcel G43 = `r(P_skew)', nformat ("#.###")
putexcel H43 = `r(P_kurt)', nformat ("#.###")
putexcel I43 = `r(P_chi2)', nformat ("#.###")
sktest agediagnosis if everbronchiectasis == 0
return list
putexcel G46 = `r(P_skew)', nformat ("#.###")
putexcel H46 = `r(P_kurt)', nformat ("#.###")
putexcel I46 = `r(P_chi2)', nformat ("#.###")
sktest agediagnosis if everbronchiectasis == 1
return list
putexcel G47 = `r(P_skew)', nformat ("#.###")
putexcel H47 = `r(P_kurt)', nformat ("#.###")
putexcel I47 = `r(P_chi2)', nformat ("#.###")

*IgG Trough Levels
putexcel A49:F49 = "IgG Trough Levels", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B50 = "Median (IQR)", hcenter bold border(bottom)
putexcel C50 = "Min", hcenter bold border(bottom)
putexcel D50 = "Max", hcenter bold border(bottom)
putexcel E50 = "Mean (SD)", hcenter bold border(bottom)
putexcel A51 = "All", left bold border(right)
putexcel A52 = "Never Bronch", left italic border(right)
putexcel A53 = "Ever Bronch", left italic border(right)
putexcel A54 = "Pre Bronchiectasis", left italic border(right) font(calibri,11,red)
putexcel A55 = "Post Bronchiectasis", left italic border(right) font(calibri,11,red)
*All
su lifetroughmean, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B51 = "`iggmediqr'"
putexcel C51 = `r(min)', nformat("#.##")
putexcel D51 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E51 = "`iggmeansd'"
*Never Bronch
su lifetroughmean if everbronchiectasis==0, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B52 = "`iggmediqr'"
putexcel C52 = `r(min)', nformat("#.##")
putexcel D52 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E52 = "`iggmeansd'"
*Ever Bronch
su lifetroughmean if everbronchiectasis==1, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B53 = "`iggmediqr'"
putexcel C53 = `r(min)', nformat("#.##")
putexcel D53 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E53 = "`iggmeansd'"
*Pre Bronch
su prebronchiggmean, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B54 = "`iggmediqr'"
putexcel C54 = `r(min)', nformat("#.##")
putexcel D54 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E54 = "`iggmeansd'"
*Post Bronch
su postbronchiggmean, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B55 = "`iggmediqr'"
putexcel C55 = `r(min)', nformat("#.##")
putexcel D55 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E55 = "`iggmeansd'"
***Normality for IgG Trough Levels----------------------------------------
putexcel F50 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G50 = "Skewness", hcenter bold border(bottom)
putexcel H50 = "Kertosis", hcenter bold border(bottom)
putexcel I50 = "SK P Values", hcenter bold border(bottom)
swilk lifetroughmean
return list
putexcel F51 = `r(p)', nformat ("#.###")
swilk lifetroughmean if everbronchiectasis == 0
return list
putexcel F52 = `r(p)', nformat ("#.###")
swilk lifetroughmean if everbronchiectasis == 1
return list
putexcel F53 = `r(p)', nformat ("#.###")
sktest lifetroughmean 
return list
putexcel G51 = `r(P_skew)', nformat ("#.###")
putexcel H51 = `r(P_kurt)', nformat ("#.###")
putexcel I51 = `r(P_chi2)', nformat ("#.###")
swilk prebronchiggmean
return list
putexcel F54 = `r(p)', nformat ("#.###")
sktest prebronchiggmean
return list
putexcel G54 = `r(P_skew)', nformat ("#.###")
putexcel H54 = `r(P_kurt)', nformat ("#.###")
putexcel I54 = `r(P_chi2)', nformat ("#.###")
swilk postbronchiggmean
return list
putexcel F55 = `r(p)', nformat ("#.###")
sktest postbronchiggmean
return list
putexcel G55 = `r(P_skew)', nformat ("#.###")
putexcel H55 = `r(P_kurt)', nformat ("#.###")
putexcel I55 = `r(P_chi2)', nformat ("#.###")

*Current IgG levels
putexcel A57:F57 = "Current IgG Trough Levels", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B58 = "Median (IQR)", hcenter bold border(bottom)
putexcel C58 = "Min", hcenter bold border(bottom)
putexcel D58 = "Max", hcenter bold border(bottom)
putexcel E58 = "Mean (SD)", hcenter bold border(bottom)
putexcel A59 = "All", left bold border(right)
putexcel A60 = "Never Bronch", left italic border(right)
putexcel A61 = "Ever Bronch", left italic border(right)
*All
su iggc, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B59 = "`iggmediqr'"
putexcel C59 = `r(min)', nformat("#.##")
putexcel D59 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E59 = "`iggmeansd'"
*Never Bronch
su iggc if everbronchiectasis==0, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B60 = "`iggmediqr'"
putexcel C60 = `r(min)', nformat("#.##")
putexcel D60 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E60 = "`iggmeansd'"
*Ever Bronch
su iggc if everbronchiectasis==1, d
return list
local iggmed = string(`r(p50)', "%9.2f")
local iggiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local iggmediqr = "`iggmed' (`iggiqr')"
putexcel B61 = "`iggmediqr'"
putexcel C61 = `r(min)', nformat("#.##")
putexcel D61 = `r(max)', nformat("#.##")
local iggmean = string(`r(mean)', "%9.2f")
local iggsd = string(`r(sd)', "%9.2f")
local iggmeansd = "`iggmean' (`iggsd')"
putexcel E61 = "`iggmeansd'"
***Normality for IgG Current Levels------------------------------------
putexcel F58 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G58 = "Skewness", hcenter bold border(bottom)
putexcel H58 = "Kertosis", hcenter bold border(bottom)
putexcel I58 = "SK P Values", hcenter bold border(bottom)
swilk iggc
return list
putexcel F59 = `r(p)', nformat ("#.###")
swilk iggc if everbronchiectasis == 0
return list
putexcel F60 = `r(p)', nformat ("#.###")
swilk iggc if everbronchiectasis == 1
return list
putexcel F61 = `r(p)', nformat ("#.###")
sktest iggc
return list
putexcel G59 = `r(P_skew)', nformat ("#.###")
putexcel H59 = `r(P_kurt)', nformat ("#.###")
putexcel I59 = `r(P_chi2)', nformat ("#.###")
sktest iggc if everbronchiectasis == 0
return list
putexcel G60 = `r(P_skew)', nformat ("#.###")
putexcel H60 = `r(P_kurt)', nformat ("#.###")
putexcel I60 = `r(P_chi2)', nformat ("#.###")
sktest iggc if everbronchiectasis == 1
return list
putexcel G61 = `r(P_skew)', nformat ("#.###")
putexcel H61 = `r(P_kurt)', nformat ("#.###")
putexcel I61 = `r(P_chi2)', nformat ("#.###")

*Infection Incidece
putexcel A63:F63 = "Infection Incidence", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B64 = "Median (IQR)", hcenter bold border(bottom)
putexcel C64 = "Min", hcenter bold border(bottom)
putexcel D64 = "Max", hcenter bold border(bottom)
putexcel E64 = "Mean (SD)", hcenter bold border(bottom)
putexcel A65 = "All", left bold border(right)
putexcel A66 = "Never Bronch", left italic border(right)
putexcel A67 = "Ever Bronch", left italic border(right)
putexcel A68 = "Pre Bronch", left italic border(right)
putexcel A69 = "Post Bronch", left italic border(right)
putexcel A70 = "Paediatric", left italic border(right)
putexcel A71 = "Adults", left italic border(right)
*All
su infectionincidence, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B65 = "`infmediqr'"
putexcel C65 = `r(min)', nformat("#.##")
putexcel D65 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E65 = "`infmeansd'"
*Never Bronch
su infectionincidence if everbronchiectasis==0, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B66 = "`infmediqr'"
putexcel C66 = `r(min)', nformat("#.##")
putexcel D66 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E66 = "`infmeansd'"
*Ever Bronch
su infectionincidence if everbronchiectasis==1, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B67 = "`infmediqr'"
putexcel C67 = `r(min)', nformat("#.##")
putexcel D67 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E67 = "`infmeansd'"
*Pre Bronch
su infectionincidenceprebronch, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B68 = "`infmediqr'"
putexcel C68 = `r(min)', nformat("#.##")
putexcel D68 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E68 = "`infmeansd'"
*Post Bronch
su infectionincidencepostbronch, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B69 = "`infmediqr'"
putexcel C69 = `r(min)', nformat("#.##")
putexcel D69 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E69 = "`infmeansd'"
*Kids
su infectionincidence if agegroup==1, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B70 = "`infmediqr'"
putexcel C70 = `r(min)', nformat("#.##")
putexcel D70 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E70 = "`infmeansd'"
*Adults
su infectionincidence if agegroup==2, d
return list
local infmed = string(`r(p50)', "%9.2f")
local infiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local infmediqr = "`infmed' (`infiqr')"
putexcel B71 = "`infmediqr'"
putexcel C71 = `r(min)', nformat("#.##")
putexcel D71 = `r(max)', nformat("#.##")
local infmean = string(`r(mean)', "%9.2f")
local infsd = string(`r(sd)', "%9.2f")
local infmeansd = "`infmean' (`infsd')"
putexcel E71 = "`infmeansd'"

***Infection Inci Normal--------------------------------------

putexcel F64 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G64 = "Skewness", hcenter bold border(bottom)
putexcel H64 = "Kertosis", hcenter bold border(bottom)
putexcel I64 = "SK P Values", hcenter bold border(bottom)
swilk infectionincidence
return list
putexcel F65 = `r(p)', nformat ("#.###")
swilk infectionincidence if everbronchiectasis == 0
return list
putexcel F66 = `r(p)', nformat ("#.###")
swilk infectionincidence if everbronchiectasis == 1
return list
putexcel F67 = `r(p)', nformat ("#.###")
swilk infectionincidence if agegroup == 2
return list
putexcel F71 = `r(p)', nformat ("#.###")
swilk infectionincidence if agegroup == 1
return list
putexcel F70 = `r(p)', nformat ("#.###")
swilk infectionincidenceprebronch
return list
putexcel F68 = `r(p)', nformat ("#.###")
swilk infectionincidencepostbronch
return list
putexcel F69 = `r(p)', nformat ("#.###")


sktest infectionincidence
return list
putexcel G65 = `r(P_skew)', nformat ("#.###")
putexcel H65 = `r(P_kurt)', nformat ("#.###")
putexcel I65 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidence if everbronchiectasis == 0
return list
putexcel G66 = `r(P_skew)', nformat ("#.###")
putexcel H66 = `r(P_kurt)', nformat ("#.###")
putexcel I66 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidence if everbronchiectasis == 1
return list
putexcel G67 = `r(P_skew)', nformat ("#.###")
putexcel H67 = `r(P_kurt)', nformat ("#.###")
putexcel I67 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidence if agegroup == 2
return list
putexcel G70 = `r(P_skew)', nformat ("#.###")
putexcel H70 = `r(P_kurt)', nformat ("#.###")
putexcel I70 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidence if agegroup == 1
return list
putexcel G71 = `r(P_skew)', nformat ("#.###")
putexcel H71 = `r(P_kurt)', nformat ("#.###")
putexcel I71 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidenceprebronch
return list
putexcel G68 = `r(P_skew)', nformat ("#.###")
putexcel H68 = `r(P_kurt)', nformat ("#.###")
putexcel I68 = `r(P_chi2)', nformat ("#.###")
sktest infectionincidencepostbronch
return list
putexcel G69 = `r(P_skew)', nformat ("#.###")
putexcel H69 = `r(P_kurt)', nformat ("#.###")
putexcel I69 = `r(P_chi2)', nformat ("#.###")
* Resp Infection Incidece
putexcel A73:F73 = "Respiratory Infection Incidence", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B74 = "Median (IQR)", hcenter bold border(bottom)
putexcel C74 = "Min", hcenter bold border(bottom)
putexcel D74 = "Max", hcenter bold border(bottom)
putexcel E74 = "Mean (SD)", hcenter bold border(bottom)
putexcel A75 = "All", left bold border(right)
putexcel A76 = "Never Bronch", left italic border(right)
putexcel A77 = "Ever Bronch", left italic border(right)
putexcel A78 = "Pre Bronch", left italic border(right)
putexcel A79 = "Post Bronch", left italic border(right)
putexcel A80 = "Paediatric", left italic border(right)
putexcel A81 = "Adults", left italic border(right)
*All
su respinfectionincidence, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B75 = "`respinfmediqr'"
putexcel C75 = `r(min)', nformat("#.##")
putexcel D75 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E75 = "`respinfmeansd'"
*Never Bronch
su respinfectionincidence if everbronchiectasis==0, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B76 = "`respinfmediqr'"
putexcel C76 = `r(min)', nformat("#.##")
putexcel D76 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E76 = "`respinfmeansd'"
*Ever Bronch
su respinfectionincidence if everbronchiectasis==1, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B77 = "`respinfmediqr'"
putexcel C77 = `r(min)', nformat("#.##")
putexcel D77 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E77 = "`respinfmeansd'"
*Pre Bronch
su respincidenceprebronch, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B78 = "`respinfmediqr'"
putexcel C78 = `r(min)', nformat("#.##")
putexcel D78 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E78 = "`respinfmeansd'"
*Post Bronch
su respincidencepostbronch, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B79 = "`respinfmediqr'"
putexcel C79 = `r(min)', nformat("#.##")
putexcel D79 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E79 = "`respinfmeansd'"
*Kids
su respinfectionincidence if agegroup==1, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B80 = "`respinfmediqr'"
putexcel C80 = `r(min)', nformat("#.##")
putexcel D80 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E80 = "`respinfmeansd'"
*Adults
su respinfectionincidence if agegroup==2, d
return list
local respinfmed = string(`r(p50)', "%9.2f")
local respinfiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local respinfmediqr = "`respinfmed' (`respinfiqr')"
putexcel B81 = "`respinfmediqr'"
putexcel C81 = `r(min)', nformat("#.##")
putexcel D81 = `r(max)', nformat("#.##")
local respinfmean = string(`r(mean)', "%9.2f")
local respinfsd = string(`r(sd)', "%9.2f")
local respinfmeansd = "`respinfmean' (`respinfsd')"
putexcel E81 = "`respinfmeansd'"
***Resp Infection Inci Normal--------------------------------------

putexcel F74 = "Shapiro-Wilk", hcenter bold border(bottom)
putexcel G74 = "Skewness", hcenter bold border(bottom)
putexcel H74 = "Kertosis", hcenter bold border(bottom)
putexcel I74 = "SK P Values", hcenter bold border(bottom)
swilk respinfectionincidence
return list
putexcel F75 = `r(p)', nformat ("#.###")
swilk respinfectionincidence if everbronchiectasis == 0
return list
putexcel F76 = `r(p)', nformat ("#.###")
swilk respinfectionincidence if everbronchiectasis == 1
return list
putexcel F77 = `r(p)', nformat ("#.###")
swilk respinfectionincidence if agegroup == 2
return list
putexcel F81 = `r(p)', nformat ("#.###")
swilk respinfectionincidence if agegroup == 1
return list
putexcel F80 = `r(p)', nformat ("#.###")
swilk respincidenceprebronch
return list
putexcel F78 = `r(p)', nformat ("#.###")
swilk respincidencepostbronch
return list
putexcel F79 = `r(p)', nformat ("#.###")


sktest respinfectionincidence
return list
putexcel G75 = `r(P_skew)', nformat ("#.###")
putexcel H75 = `r(P_kurt)', nformat ("#.###")
putexcel I75 = `r(P_chi2)', nformat ("#.###")
sktest respinfectionincidence if everbronchiectasis == 0
return list
putexcel G76 = `r(P_skew)', nformat ("#.###")
putexcel H76 = `r(P_kurt)', nformat ("#.###")
putexcel I76 = `r(P_chi2)', nformat ("#.###")
sktest respinfectionincidence if everbronchiectasis == 1
return list
putexcel G77 = `r(P_skew)', nformat ("#.###")
putexcel H77 = `r(P_kurt)', nformat ("#.###")
putexcel I77 = `r(P_chi2)', nformat ("#.###")
sktest respinfectionincidence if agegroup == 2
return list
putexcel G80 = `r(P_skew)', nformat ("#.###")
putexcel H80 = `r(P_kurt)', nformat ("#.###")
putexcel I80 = `r(P_chi2)', nformat ("#.###")
sktest respinfectionincidence if agegroup == 1
return list
putexcel G81 = `r(P_skew)', nformat ("#.###")
putexcel H81 = `r(P_kurt)', nformat ("#.###")
putexcel I81 = `r(P_chi2)', nformat ("#.###")
sktest respincidenceprebronch
return list
putexcel G78 = `r(P_skew)', nformat ("#.###")
putexcel H78 = `r(P_kurt)', nformat ("#.###")
putexcel I78 = `r(P_chi2)', nformat ("#.###")
sktest respincidencepostbronch
return list
putexcel G79 = `r(P_skew)', nformat ("#.###")
putexcel H79 = `r(P_kurt)', nformat ("#.###")
putexcel I79 = `r(P_chi2)', nformat ("#.###")


* Follow up to Lung Dx
putexcel A83:G83 = "Follow up till Bronchiectasis", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B84 = "Total", hcenter bold border(bottom)
putexcel C84 = "Median (IQR)", hcenter bold border(bottom)
putexcel D84 = "Min", hcenter bold border(bottom)
putexcel E84 = "Max", hcenter bold border(bottom)
putexcel F84 = "Mean (SD)", hcenter bold border(bottom)
putexcel A85 = "All", left bold border(right)
putexcel A86 = "Exlcuding <12Mnths XLA to Bronch", left italic border(right)
putexcel A87 = "Including <12Mnths XLA to Bronch as 0", left italic border(right)
*All
su followuptolungdx if everbronchiectasis==1, d
return list
local fubrmed = string(`r(p50)', "%9.2f")
local fubriqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fubrmediqr = "`fubrmed' (`fubriqr')"
putexcel B85 = "`fubrmediqr'"
putexcel C85 = `r(min)', nformat("#.##")
putexcel D85 = `r(max)', nformat("#.##")
local fubrmean = string(`r(mean)', "%9.2f")
local fubrsd = string(`r(sd)', "%9.2f")
local fubrmeansd = "`fubrmean' (`fubrsd')"
putexcel E85 = "`fubrmeansd'"
*Including those who were dx within 12 months of XLA Dx as 0
su followuptolungdx1 if everbronchiectasis==1, d
return list
local fubrmed = string(`r(p50)', "%9.2f")
local fubriqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fubrmediqr = "`fubrmed' (`fubriqr')"
putexcel B86 = "`fubrmediqr'"
putexcel C86 = `r(min)', nformat("#.##")
putexcel D86 = `r(max)', nformat("#.##")
local fubrmean = string(`r(mean)', "%9.2f")
local fubrsd = string(`r(sd)', "%9.2f")
local fubrmeansd = "`fubrmean' (`fubrsd')"
putexcel E86 = "`fubrmeansd'"
*Excluding those who were dx within 12 months of XLA Dx
su followuptolungdx1 if everbronchiectasis==1 & followuptolungdx1 != 0, d
return list
local fubrmed = string(`r(p50)', "%9.2f")
local fubriqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fubrmediqr = "`fubrmed' (`fubriqr')"
putexcel B87 = "`fubrmediqr'"
putexcel C87 = `r(min)', nformat("#.##")
putexcel D87 = `r(max)', nformat("#.##")
local fubrmean = string(`r(mean)', "%9.2f")
local fubrsd = string(`r(sd)', "%9.2f")
local fubrmeansd = "`fubrmean' (`fubrsd')"
putexcel E87 = "`fubrmeansd'"
**Costs"------
putexcel A89:G89 = "2016 Immunoglobulin Costs", merge vcenter hcenter bold underline font(16) border(bottom double)
putexcel B90 = "Total", hcenter bold border(bottom)
putexcel C90 = "Median (IQR)", hcenter bold border(bottom)
putexcel D90 = "Min", hcenter bold border(bottom)
putexcel E90 = "Max", hcenter bold border(bottom)
putexcel F90 = "Mean (SD)", hcenter bold border(bottom)
putexcel A91 = "Paediatric", left bold border(right)
putexcel A92 = "Adults", left italic border(right)
putexcel A93 = "All", left italic border(right)
**kids
su currentprice if agegroup==1, d
return list
putexcel B91 = `r(sum)', nformat("#.##")
local costmed = string(`r(p50)', "%9.2f")
local costiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local costmediqr = "`costmed' (`costiqr')"
putexcel C91 = "`costmediqr'"
putexcel D91 = `r(min)', nformat("#.##")
putexcel E91 = `r(max)', nformat("#.##")
local costmean = string(`r(mean)', "%9.2f")
local costsd = string(`r(sd)', "%9.2f")
local costmeansd = "`costmean' (`costsd')"
putexcel F91 = "`costmeansd'"
**adults
su currentprice if agegroup==2, d
return list
putexcel B92 = `r(sum)', nformat("#.##")
local costmed = string(`r(p50)', "%9.2f")
local costiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local costmediqr = "`costmed' (`costiqr')"
putexcel C92 = "`costmediqr'"
putexcel D92 = `r(min)', nformat("#.##")
putexcel E92 = `r(max)', nformat("#.##")
local costmean = string(`r(mean)', "%9.2f")
local costsd = string(`r(sd)', "%9.2f")
local costmeansd = "`costmean' (`costsd')"
putexcel F92 = "`costmeansd'"
**all
su currentprice, d
return list
putexcel B93 = `r(sum)', nformat("#.##")
local costmed = string(`r(p50)', "%9.2f")
local costiqr = string(`r(p75)'-`r(p25)', "%9.2f")
local costmediqr = "`costmed' (`costiqr')"
putexcel C93 = "`costmediqr'"
putexcel D93 = `r(min)', nformat("#.##")
putexcel E93 = `r(max)', nformat("#.##")
local costmean = string(`r(mean)', "%9.2f")
local costsd = string(`r(sd)', "%9.2f")
local costmeansd = "`costmean' (`costsd')"
putexcel F93 = "`costmeansd'"


keep studyid diagnosis ///
cd1920c cd1920cp geneticdefect genedetails btkexpress fhx fhxdetails screenedfhx igacu igmcu

export excel "H:\PhD\Result Data\Excel Sheets\excelresults.xlsx", sheet(DiagnosisData) firstrow (varl) sheetreplace
