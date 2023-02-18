# Asymetric default cost

This subfolder contains scripts and functions to estimate the parameters of default cost under the asssumption they differ across sectors. `Master.m` is the main file. There, I obtain empirical estimates from Argentinean data as a first step, and save those results in structure `d`. Note that I save parameters of the model in structure `p`, and vectors and matrices (grids for productivity and debt, transition matrix, etc.) in structure `v`. 

Then, I estimate default cost parameters using two methods: Indirect Inference (`p.moment=0`) and Simulated Method of Moments (`p.moment=1`). 
