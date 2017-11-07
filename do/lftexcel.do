*STATA v 14.2
*Ben Shillite
*b.shillitoe2@ncl.ac.uk

*XLA PhD Project

*Do File v1.0 5.5.17 - First interation

*Exports LFT Data to Excel

clear
set more off
set graphics off
do "H:\open.do"
*--------Setting Excel File
putexcel set "H:\PhD\Result Data\Excel Sheets\lftexcelresults.xlsx", sheet(LFT Data) replace
*----First and Last LFT Data
*---Formatting Table
putexcel A1:M1 = "First and Last LFT Data", merge vcenter hcenter bold underline font(16) border(all double)
putexcel B2:E2 = "All Patients", merge vcenter hcenter bold underline font(16) border(all double)
putexcel F2:I2 = "Ever Bronchiectasis",  merge vcenter hcenter bold underline font(16) border(all double)
putexcel J2:M2 = "Never Bronchiectasis", merge vcenter hcenter bold underline font(16) border(all double)
putexcel B3 = "Median(IQR)", hcenter bold border(bottom)
putexcel C3 = "Min", hcenter bold border(bottom)
putexcel D3 = "Max", hcenter bold border(bottom)
putexcel E3 = "Mean (SD)", hcenter bold border(bottom right)
putexcel F3 = "Median(IQR)", hcenter bold border(bottom)
putexcel G3 = "Min", hcenter bold border(bottom)
putexcel H3 = "Max", hcenter bold border(bottom)
putexcel I3 = "Mean (SD)", hcenter bold border(bottom right )
putexcel J3 = "Median(IQR)", hcenter bold border(bottom)
putexcel K3 = "Min", hcenter bold border(bottom)
putexcel L3 = "Max", hcenter bold border(bottom)
putexcel M3 = "Mean (SD)", hcenter bold border(bottom right )
putexcel A3 = "FEV1", hcenter bold border(all)
putexcel A4 = "Starting FEV1 (L)", left italic border(right)
putexcel A5 = "Latest FEV1 (L)", left italic border(right)
putexcel A6 = "Starting FEV1 % Predicted", left italic border(right)
putexcel A7 = "Latest FEV1 % Predicted", left italic border(right)
putexcel A8 = "Starting FEV1 Z Score", left italic border(right)
putexcel A9 = "Latest FEV1 Z Score", left italic border(right)
putexcel A10 = "FVC", hcenter bold border(all)
putexcel A11 = "Starting FVC (L)", left italic border(right)
putexcel A12 = "Latest FVC (L)", left italic border(right)
putexcel A13 = "Starting FVC % Predicted", left italic border(right)
putexcel A14 = "Latest FVC % Predicted", left italic border(right)
putexcel A15 = "Starting FVC Z Score", left italic border(right)
putexcel A16 = "Latest FVC Z Score", left italic border(right)
putexcel A17 = "FEV:FVC Ratio", left bold border(all)
putexcel A18 = "Starting FEV:FVC (L)", left italic border(right)
putexcel A19 = "Latest FEV:FVC (L)", left italic border(right)
putexcel A20 = "Starting FEV:FVC Z Score", left italic border(right)
putexcel A21 = "Latest FEV:FVC Z Score", left italic border(right)
*---Data for first/last lft data
**FEV1 Scores for All
*First
su fevfirst, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B4 = "`feviqr'"
putexcel C4 = `r(min)', nformat("#.##")
putexcel D4 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E4 = "`fevmeansd'"
*Last
su fevlatest, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B5 = "`feviqr'"
putexcel C5 = `r(min)', nformat("#.##")
putexcel D5 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E5 = "`fevmeansd'"
*FEV%Pred for All
*first
su percpredfevfirst, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B6 = "`feviqr'"
putexcel C6 = `r(min)', nformat("#.##")
putexcel D6 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E6 = "`fevmeansd'"
*FEV%Pred latest
su percpredfevlatest, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B7 = "`feviqr'"
putexcel C7 = `r(min)', nformat("#.##")
putexcel D7 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E7 = "`fevmeansd'"
*First FEV1 Zcore
su zfevfirst, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B8 = "`feviqr'"
putexcel C8 = `r(min)', nformat("#.##")
putexcel D8 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E8 = "`fevmeansd'"
*latest FEV1 Zcore
su zfevlatest, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel B9 = "`feviqr'"
putexcel C9 = `r(min)', nformat("#.##")
putexcel D9 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel E9 = "`fevmeansd'"
**FVC1 Scores for All
*First
su fvcfirst, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B11 = "`fvciqr'"
putexcel C11 = `r(min)', nformat("#.##")
putexcel D11 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E11 = "`fvcmeansd'"
*Last
su fvclatest, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B12 = "`fvciqr'"
putexcel C12 = `r(min)', nformat("#.##")
putexcel D12 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E12 = "`fvcmeansd'"
*fvc%Pred for All
*first
su percpredfvcfirst, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B13 = "`fvciqr'"
putexcel C13 = `r(min)', nformat("#.##")
putexcel D13 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E13 = "`fvcmeansd'"
*fvc%Pred latest
su percpredfvclatest, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B14 = "`fvciqr'"
putexcel C14 = `r(min)', nformat("#.##")
putexcel D14 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E14 = "`fvcmeansd'"
*First fvc Zcore
su zfvcfirst, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B15 = "`fvciqr'"
putexcel C15 = `r(min)', nformat("#.##")
putexcel D15 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E15 = "`fvcmeansd'"
*latest fvc Zcore
su zfvclatest, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel B16 = "`fvciqr'"
putexcel C16 = `r(min)', nformat("#.##")
putexcel D16 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel E16 = "`fvcmeansd'"
**FEV:fevfvc for all
*First
su fevfvcfirst, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel B18 = "`fevfvciqr'"
putexcel C18 = `r(min)', nformat("#.##")
putexcel D18 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel E18 = "`fevfvcmeansd'"
*Last
su fevfvclatest, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel B19 = "`fevfvciqr'"
putexcel C19 = `r(min)', nformat("#.##")
putexcel D19 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel E19 = "`fevfvcmeansd'"
*First fevfvc Zcore
su zfevfvcfirst, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel B20 = "`fevfvciqr'"
putexcel C20 = `r(min)', nformat("#.##")
putexcel D20 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel E20 = "`fevfvcmeansd'"
*latest fevfvc Zcore
su zfevfvclatest, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel B21 = "`fevfvciqr'"
putexcel C21 = `r(min)', nformat("#.##")
putexcel D21 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel E21 = "`fevfvcmeansd'"
**FIV1 Scores for for everbronchs
*First
su fevfirst if everbronchiectasis == 1, d 
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F4 = "`feviqr'"
putexcel G4 = `r(min)', nformat("#.##")
putexcel H4 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I4 = "`fevmeansd'"
*Last
su fevlatest if everbronchiectasis == 1, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F5 = "`feviqr'"
putexcel G5 = `r(min)', nformat("#.##")
putexcel H5 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I5 = "`fevmeansd'"
*FIV%Pred for Iver Fronch
*first
su percpredfevfirst if everbronchiectasis == 1, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F6 = "`feviqr'"
putexcel G6 = `r(min)', nformat("#.##")
putexcel H6 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I6 = "`fevmeansd'"
*FIV%Pred latest
su percpredfevlatest if everbronchiectasis == 1, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F7 = "`feviqr'"
putexcel G7 = `r(min)', nformat("#.##")
putexcel H7 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I7 = "`fevmeansd'"
*First FIV1 Zcore
su zfevfirst if everbronchiectasis == 1, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F8 = "`feviqr'"
putexcel G8 = `r(min)', nformat("#.##")
putexcel H8 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I8 = "`fevmeansd'"
*latest FIV1 Zcore
su zfevlatest if everbronchiectasis == 1, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel F9 = "`feviqr'"
putexcel G9 = `r(min)', nformat("#.##")
putexcel H9 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel I9 = "`fevmeansd'"
**FVG1 Scores for Iver Fronch
*First
su fvcfirst if everbronchiectasis == 1, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F11 = "`fvciqr'"
putexcel G11 = `r(min)', nformat("#.##")
putexcel H11 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I11 = "`fvcmeansd'"
*Last
su fvclatest if everbronchiectasis == 1, d
return list 
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F12 = "`fvciqr'"
putexcel G12 = `r(min)', nformat("#.##")
putexcel H12 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I12 = "`fvcmeansd'"
*fvc%Pred for Iver Fronch
*first
su percpredfvcfirst if everbronchiectasis == 1, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F13 = "`fvciqr'"
putexcel G13 = `r(min)', nformat("#.##")
putexcel H13 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I13 = "`fvcmeansd'"
*fvc%Pred latest
su percpredfvclatest if everbronchiectasis == 1, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F14 = "`fvciqr'"
putexcel G14 = `r(min)', nformat("#.##")
putexcel H14 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I14 = "`fvcmeansd'"
*First fvc Zcore
su zfvcfirst if everbronchiectasis == 1, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F15 = "`fvciqr'"
putexcel G15 = `r(min)', nformat("#.##")
putexcel H15 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I15 = "`fvcmeansd'"
*latest fvc Zcore
su zfvclatest if everbronchiectasis == 1, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel F16 = "`fvciqr'"
putexcel G16 = `r(min)', nformat("#.##")
putexcel H16 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel I16 = "`fvcmeansd'"
**FIV:fevfvc for all
*First
su fevfvcfirst if everbronchiectasis == 1, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel F18 = "`fevfvciqr'"
putexcel G18 = `r(min)', nformat("#.##")
putexcel H18 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel I18 = "`fevfvcmeansd'"
*Last
su fevfvclatest if everbronchiectasis == 1, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel F19 = "`fevfvciqr'"
putexcel G19 = `r(min)', nformat("#.##")
putexcel H19 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel I19 = "`fevfvcmeansd'"
*First fevfvc Zcore
su zfevfvcfirst if everbronchiectasis == 1, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel F20 = "`fevfvciqr'"
putexcel G20 = `r(min)', nformat("#.##")
putexcel H20 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel I20 = "`fevfvcmeansd'"
*latest fevfvc Zcore
su zfevfvclatest if everbronchiectasis == 1, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel F21 = "`fevfvciqr'"
putexcel G21 = `r(min)', nformat("#.##")
putexcel H21 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel I21 = "`fevfvcmeansd'"
**JMV1 Scores for for neverbronchs
*Jirst
su fevfirst if everbronchiectasis == 0, d 
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J4 = "`feviqr'"
putexcel K4 = `r(min)', nformat("#.##")
putexcel L4 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M4 = "`fevmeansd'"
*Last
su fevlatest if everbronchiectasis == 0, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J5 = "`feviqr'"
putexcel K5 = `r(min)', nformat("#.##")
putexcel L5 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M5 = "`fevmeansd'"
*JMV%Pred for never Jronch
*first
su percpredfevfirst if everbronchiectasis == 0, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J6 = "`feviqr'"
putexcel K6 = `r(min)', nformat("#.##")
putexcel L6 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M6 = "`fevmeansd'"
*JMV%Pred latest
su percpredfevlatest if everbronchiectasis == 0, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J7 = "`feviqr'"
putexcel K7 = `r(min)', nformat("#.##")
putexcel L7 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M7 = "`fevmeansd'"
*Jirst JMV1 Zcore
su zfevfirst if everbronchiectasis == 0, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J8 = "`feviqr'"
putexcel K8 = `r(min)', nformat("#.##")
putexcel L8 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M8 = "`fevmeansd'"
*latest JMV1 Zcore
su zfevlatest if everbronchiectasis == 0, d
return list
local fevmed = string(`r(p50)', "%9.2f")
local feviqr = string(`r(p75)'-`r(p25)', "%9.2f")
local feviqr = "`fevmed' (`feviqr')"
putexcel J9 = "`feviqr'"
putexcel K9 = `r(min)', nformat("#.##")
putexcel L9 = `r(max)', nformat("#.##")
local fevmean = string(`r(mean)', "%9.2f")
local fevsd = string(`r(sd)', "%9.2f")
local fevmeansd = "`fevmean' (`fevsd')"
putexcel M9 = "`fevmeansd'"
**JVK1 Scores for never Jronch
*Jirst
su fvcfirst if everbronchiectasis == 0, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J11 = "`fvciqr'"
putexcel K11 = `r(min)', nformat("#.##")
putexcel L11 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M11 = "`fvcmeansd'"
*Last
su fvclatest if everbronchiectasis == 0, d
return list 
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J12 = "`fvciqr'"
putexcel K12 = `r(min)', nformat("#.##")
putexcel L12 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M12 = "`fvcmeansd'"
*fvc%Pred for never Jronch
*first
su percpredfvcfirst if everbronchiectasis == 0, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J13 = "`fvciqr'"
putexcel K13 = `r(min)', nformat("#.##")
putexcel L13 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M13 = "`fvcmeansd'"
*fvc%Pred latest
su percpredfvclatest if everbronchiectasis == 0, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J14 = "`fvciqr'"
putexcel K14 = `r(min)', nformat("#.##")
putexcel L14 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M14 = "`fvcmeansd'"
*Jirst fvc Zcore
su zfvcfirst if everbronchiectasis == 0, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J15 = "`fvciqr'"
putexcel K15 = `r(min)', nformat("#.##")
putexcel L15 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M15 = "`fvcmeansd'"
*latest fvc Zcore
su zfvclatest if everbronchiectasis == 0, d
return list
local fvcmed = string(`r(p50)', "%9.2f")
local fvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fvciqr = "`fvcmed' (`fvciqr')"
putexcel J16 = "`fvciqr'"
putexcel K16 = `r(min)', nformat("#.##")
putexcel L16 = `r(max)', nformat("#.##")
local fvcmean = string(`r(mean)', "%9.2f")
local fvcsd = string(`r(sd)', "%9.2f")
local fvcmeansd = "`fvcmean' (`fvcsd')"
putexcel M16 = "`fvcmeansd'"
**JMV:fevfvc for all
*Jirst
su fevfvcfirst if everbronchiectasis == 0, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel J18 = "`fevfvciqr'"
putexcel K18 = `r(min)', nformat("#.##")
putexcel L18 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel M18 = "`fevfvcmeansd'"
*Last
su fevfvclatest if everbronchiectasis == 0, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel J19 = "`fevfvciqr'"
putexcel K19 = `r(min)', nformat("#.##")
putexcel L19 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel M19 = "`fevfvcmeansd'"
*Jirst fevfvc Zcore
su zfevfvcfirst if everbronchiectasis == 0, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel J20 = "`fevfvciqr'"
putexcel K20 = `r(min)', nformat("#.##")
putexcel L20 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel M20 = "`fevfvcmeansd'"
*latest fevfvc Zcore
su zfevfvclatest if everbronchiectasis == 0, d
return list
local fevfvcmed = string(`r(p50)', "%9.2f")
local fevfvciqr = string(`r(p75)'-`r(p25)', "%9.2f")
local fevfvciqr = "`fevfvcmed' (`fevfvciqr')"
putexcel J21 = "`fevfvciqr'"
putexcel K21 = `r(min)', nformat("#.##")
putexcel L21 = `r(max)', nformat("#.##")
local fevfvcmean = string(`r(mean)', "%9.2f")
local fevfvcsd = string(`r(sd)', "%9.2f")
local fevfvcmeansd = "`fevfvcmean' (`fevfvcsd')"
putexcel M21 = "`fevfvcmeansd'"
