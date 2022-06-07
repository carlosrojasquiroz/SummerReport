********************************************************************************
* Summer Report
********************************************************************************
* Carlos Rojas Quiroz
* European University Institute
* June 2021
********************************************************************************
* In this do-file I run some regressions to obtain the behaviour of tradable
* and non-tradable GDP to a default event. I follow the approach from Gourinchas
* and Obstfeld (2012).
********************************************************************************
clear
cls
set more off
********************************************************************************
import excel "/Users/carlosrojasquiroz/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/Summer Report/Data/DataSet_v4.xlsx", sheet("Sheet1") firstrow clear



xtset Id Time

by Id: gen lTus2015=log(T_US2015/L.T_US2015) 
by Id: gen lNTus2015=log(NT_US2015/L.NT_US2015)

by Id: gen lTusPC=log(T_C/L.T_C)
by Id: gen lNTusPC=log(NT_C/L.NT_C)

forvalues y = 0/8 {
gen DEF`y' = Default_GO[_n-4+`y']
 }
 
gen coef0=.
gen sd0=.
gen n0=.
gen g0=.

local i = 1

forvalues y = 0/8 {
*
xtreg lNTus2015 DEF`y' i.Time, fe vce(robust) 
mat E1 = e(b)
mat VarB1= e(V)
mat N1=e(N)
mat EG1=r(r)
** 
replace coef0 = E1[1,1] in `i'
replace sd0 = VarB1[1,1]^0.5 in `i'
replace n0=N1[1,1] in `i'
replace g0=EG1[1,1] in `i'
local `i++'
}
