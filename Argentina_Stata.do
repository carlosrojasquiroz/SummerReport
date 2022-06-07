clear
cls
set more off
********************************************************************************
import excel "/Users/carlosrojasquiroz/Desktop/Summer Report/Argentina_DataSet.xlsx",sheet("Argentina") firstrow clear

tsset Time
gen shock=Default_RR
local j=8
********************************************************************************
forvalues y = 0/`j' {
gen Def_`y' =Default_RR[_n-`j'/2+`y']
gen Curr_`y' =Currency_RR[_n-`j'/2+`y']
gen Bank_`y' =Systemic_RR[_n-`j'/2+`y']
gen IFC_`y'=IFC[_n-`j'/2+`y']
}
******************************************************************************** 
gen coef1=.
gen sd1=.
gen coef2=.
gen sd2=.
********************************************************************************
local i = 1
forvalues y = 0/`j' {
*
reg Cyc_T_US2015 Def_`y' Curr_`y' Bank_`y' IFC_`y', vce(robust) 
mat E1 = e(b)
mat VarB1= e(V)
** 
replace coef1 = E1[1,1] in `i'
replace sd1 = VarB1[1,1]^0.5 in `i'
*
reg Cyc_NT_US2015 Def_`y' Curr_`y' Bank_`y' IFC_`y', vce(robust) 
mat E2 = e(b)
mat VarB2= e(V)
** 
replace coef2 = E2[1,1] in `i'
replace sd2 = VarB2[1,1]^0.5 in `i'
*
local `i++'
}
********************************************************************************
