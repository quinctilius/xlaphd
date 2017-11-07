****PhD Project XLA
***PRISM do file
***v1.0 15.09
***Ben Shillitoe

**Generating variables to pasteinto prism as i prefer their graphs!!!

***At some point I need to export these to an excel file and do the other stuff I have on prism
clear

do H:\open.do

gen igacubronch = igacu if everbronchiectasis == 1
gen igacunobronch = igacu if everbronchiectasis == 0
gen igmcunobronch = igmcu if everbronchiectasis == 0
gen igmcubronch = igmcu if everbronchiectasis == 1

