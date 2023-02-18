# Sectoral Productivity Losses from Sovereign Default Events: a simulation-based approach

This folder contains files for the replication of my Summer Report. This is a short quantitative project that estimated parameters associated with default cost between sectors (tradable and nontradable GDP) for the typical case of Argentina. I defined tradable GDP as Manufacturing value-added (ISIC divisions 15-37) and nontradable GDP as Services value-added (ISIC divisions 45-99). Data is collected from World Bank's dataset.

### ⚠️ Caveat
Construction value-added was not considered because of its non-availability in the dataset. Its inclusion may affect the observation of the sensibility of nontradable GDP to sovereign default events. On the other hand, Construction sectoral dynamics could differ from Services strongly (especially in the aftermath of a sovereign debt crisis), which could be a reason for including that sector as an independent block with its own characteristics (parameters and constraints).       

## 🗂 Files

### Datasets
- `Argentina_DataSet.xlsx`: This file has information on the Argentinean economy, like dates on financial crises, debt to GDP ratio, TFP, investment, net exports, real exchange rate, sovereign spreads, an others. 
- `CountriesDefault.xlsx`: Information of behavior of tradable and nontradable GDPs for the following defaulters: 
    -  Argentina, 2002		
    -  Chile, 1983		
    -  Costa Rica, 1981		
    -  Ecuador, 1999		
    -  Grenada, 2004		
    -  Greece, 2012		
    -  México, 1982		
    -  Pakistan, 1999		
    -  Peru, 1984		
    -  Turkey, 2001		
    -  Uruguay, 2003		
    -  Ukraine, 2015

