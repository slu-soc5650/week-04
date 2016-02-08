// ==========================================================================

// SOC 4650/5650 - LAB 04

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

cd "/Volumes/Gox HD/GIS/Labs/week-04/Stata" // OS X syntax

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using lab-04-log.txt, text replace

// ==========================================================================

/* 
file name - lab-04-code.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - replicate lab 04
	                                                                               
created - 08 Feb 2016

updated - 08 Feb 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
Replicate all Stata sections of Lab 04; ArcGIS sections are included in
repo as images
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- Necessary code to clean census data for problem set 1
- Resulting 'clean' dataset

*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// PART 1 - Working with Spatial Data in Stata

// ==========================================================================

// questions 1 and 2 completed manually

// questions 3 is this file

// question 4
use census10ChrisPS1.dta

// question 5
save census10lab04.dta, replace

// question 6
label data "Data modified for lab 04"

notes _dta: Dataset created by Chris on 08 Feb 2016
notes _dta: Data created for lab 04

// question 7
drop pop10 white black nativeAmerican asian nativeHawaiian twoMore

// question 8
label variable id 
label variable state 
label variable state2 
label variable region 
label variable division10

// question 9 
label variable id "State ID Number"
label variable state "Full State Name"
label variable state2 "State Abbreviation"
label variable region "Census Bureau Region"
label variable division10 "Census Bureau Division"

// question 10
label values region .
label values division10 .

// question 11
label define regionlbl 1 "new england" 2 "midwest" 3 "south" 4 "midwest"
label values region regionlbl

label define divisionlbl 1 "new england" 2 "mid-atlantic" 3 "east north cntrl" 4 "west north cntrl" 5 "south atlantic" 6 "east south cntrl" 7 "west south cntrl" 8 "mountain" 9 "pacific"
label values division10 divisionlbl

// question 12
drop if region == 3

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
