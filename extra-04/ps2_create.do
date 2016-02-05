// ==========================================================================

// SOC 4650/5650 - CREATE PROBLEM SET 2

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

cd "/Users/`c(username)'/Documents/Working"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using ps2_create.txt, text replace

// ==========================================================================

/* 
file name - ps2_create.do

project name -	SOC 4650/5650 - Into to GISc - Spring 2016
                                                                                 
purpose - Create dataset for Stata portion of the second problem set
	                                                                               
created - 04 Feb 2016

updated - 04 Feb 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file imports raw data from an .xls file obtained from the City
of Baltimore's Open Data system. These data represent services available 
to individuals who are homeless in the City of Baltimore.

https://data.baltimorecity.gov/Health/Homeless-Services/uukz-aw5g

It cleans the location variables for future use, creates two new numeric
variables for the problem set, and does other minor editing tasks to 
prepare the data for the assignment.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
Homeless_Services.xls 
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// PART 1 - IMPORT

// ==========================================================================

import excel Homeless_Services.xls, sheet("Homeless_Services.csv") firstrow

save baltimoreHomless.dta, replace

// ==========================================================================
// ==========================================================================

// PART 2 - CLEAN LOCATION

// ==========================================================================

// the variable Location1 has numerous text formatting issues
list Location1 in 1

/* in particular, it contains multiple pieces of information when a good
variable should only contain a single piece of information */

// beginning by splitting Location1 into two variables at the first "("

rename Location1 locRaw
split locRaw, p("(")

rename locRaw1 streetDrty // incomplete data
rename locRaw2 latLongDrty // incomplete data

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// clean latLongDrty

// remove trailing ")" from end of string
replace latLongDrty = substr(latLongDrty,1,length(latLongDrty)-1)

// split the variable into x and y fields
split latLongDrty, p(", ") // creates two string fields

rename latLongDrty2 x // convert string to numeric
rename latLongDrty1 y // convert string to numeric

order x y, last // re order variables

drop latLongDrty // remove unneeded precursor variable

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// clean street address

// there are carriage returns in the street address variable
list streetDrty in 1

// remove carriage returns
replace streetDrty = subinstr(streetDrty,char(10)," ",.)

// remove leading and training spaces
replace streetDrty = trim(streetDrty)

// result
list streetDrty in 1

// remove 'Baltimore, MD' from each street address
gen streetDrty2 = substr(streetDrty,1,length(streetDrty) - 14)

// result
list streetDrty2 in 1

// there are two street addresses that contain suite or floor numbers

// split street address if there is a comma in the address
split streetDrty2, p(",")

rename streetDrty21 streetAdd
rename streetDrty22 streetSuite

// result
list streetAdd streetSuite in 1/5

// drop unneeded location variables
drop locRaw streetDrty streetDrty2

// ==========================================================================
// ==========================================================================

// PART 3 - CREATE NUMERIC TYPE

// ==========================================================================

// the variable Type is string - need to create numeric to practice labeling

generate typeNum = .
replace typeNum = 1 if Type == "Drop-in Center"
replace typeNum = 2 if Type == "Emergency Shelter"
replace typeNum = 4 if Type == "Health Care"

// ==========================================================================
// ==========================================================================

// PART 4 - REORDER VARIABLES

// ==========================================================================

order ïOrganization Type typeNum, first

// ==========================================================================
// ==========================================================================

// PART 5 - EXPORT EXCEL FILE

// ==========================================================================

export excel using baltimoreHomeless.xls, firstrow(variables) replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
