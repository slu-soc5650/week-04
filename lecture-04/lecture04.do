// ==========================================================================

// SOC 4650/5650 - LECTURE 04

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

// cd "/Users/`c(username)'/Documents/Active"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

log using lecture04.txt, text replace

// ==========================================================================

/* 
file name - lecture04_create.do

project name -	SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - replicate lecture 04 Stata commands
	                                                                               
created - 03 Feb 2016

updated - 03 Feb 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This file replicates the Stata commands covered in Lecture 04
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
census80.dta (found on GitHub)
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// WEEK 3 REVIEW

// ==========================================================================

use census80.dta // open the census80.dta dataset

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

summarize pop // descriptive statistics

summarize pop if state2 == "MO" // using strings

// ==========================================================================

// WEEK 4 MATERIAL 

// ==========================================================================

// re-label the data

label data "1980 Census, Modified by Chris"

notes drop _all

notes _dta: Created by Chris on 03 Feb 2016
notes _dta: Modifies data downloaded from Week 04 repo on GitHub

save census80Mod.dta, replace // save change

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// remove unneeded variables

// approach one - drop with individual varnames specified

drop pop poplt5 pop5_17 pop18p pop65p popurban medage death marriage divorce

clear

use census80Mod.dta // reopen the census80.dta dataset


// approach 2 - drop with a range of varnames specified

drop pop-divorce

clear

use census80Mod.dta // open the census80.dta dataset


// approach 3 - keep with individual varnames specified

keep state state2 region

// could also use a range of varnames in concert with the keep command

save census80Mod.dta, replace // save change

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// clean state variable

label variable state "state, full name"

notes state: re-labeled on 03 Feb 2016 by Chris

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// clean state2 variable

label variable state2 "state, 2-letter abbrev"

notes state2: re-labeled on 03 Feb 2016
notes state2: data is the official two letter abbreviation for each state

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// clean region variable

label variable region "census region"

label define regiondef 1 "new england" 2 "midwest" 3 "south" 4 "west"

label values region regiondef

label variable region "US census bureau region"

notes region: re-labeled on 03 Feb 2016
notes region: values labeled using official census bureau region names

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// print all notes

notes

// print only dataset notes

notes _dta 

// print only some variable notes

notes state state2

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

save census80Mod.dta, replace // save change

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// more drop and keep

// drop states in new england

drop if region == 1

clear

use census80Mod.dta // open the census80.dta dataset


// drop two states

drop if state2 == "MA" | state2 == "VT"

clear

use census80Mod.dta // open the census80.dta dataset


// keep all western states

keep if region == 4


// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
