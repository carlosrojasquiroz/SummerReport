clear
cls
set more off
********************************************************************************
import excel "/Users/carlosrojasquiroz/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/Summer Report/Data/Argentina_DataSet.xlsx", sheet("Sheet1") firstrow clear

tsset Time

gen shock=Default_RR

forvalues y = 0/8 {
gen Def_`y' =Default_RR[_n-4+`y']
gen Curr_`y' =Currency_RR[_n-4+`y']
gen Bank_`y' =Systemic_RR[_n-4+`y']
gen IFC_`y'=IFC[_n-4+`y']
 }
 
gen coef1=.
gen sd1=.
gen n1=.
gen coef2=.
gen sd2=.
gen n2=.

local i = 1

forvalues y = 0/8 {
*
reg Cyc_T_US2015 Def_`y' Curr_`y' Bank_`y' IFC_`y', vce(robust) 
mat E1 = e(b)
mat VarB1= e(V)
mat N1=e(N)
** 
replace coef1 = E1[1,1] in `i'
replace sd1 = VarB1[1,1]^0.5 in `i'
replace n1=N1[1,1] in `i'
*
reg Cyc_NT_US2015 Def_`y' Curr_`y' Bank_`y' IFC_`y', vce(robust) 
mat E2 = e(b)
mat VarB2= e(V)
mat N2=e(N)
** 
replace coef2 = E2[1,1] in `i'
replace sd2 = VarB2[1,1]^0.5 in `i'
replace n2=N2[1,1] in `i'


local `i++'
}
