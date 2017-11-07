*STATA V 14.2
*Ben Shillitoe
*b.shillitoe2@ncl.ac.uk

*XLA PhD Project
*v1.3 15.9.17 - added the prism file
*v1.2 5.5.2017 - This do file now runs quietly

*This is the master do File with 4 main components;
*	1)	Import and Clean Raw Data from Main Database and Individual Excel Files
*	2)	Generates Dummy Variables
*	3)  Exports Data to Excel File
*	4)	Exports Graphs

clear
set more off
run "H:\PhD\Result Data\Stata files\do\updatemaster"
run "H:\PhD\Result Data\Stata files\do\formatdata"
run "H:\PhD\Result Data\Stata files\do\excelexport"
run "H:\PhD\Result Data\Stata files\do\graphs"
run "H:\PhD\Result Data\Stata files\do\prism"
do "h:\open.do"
