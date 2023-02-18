# Asymmetric default cost

This subfolder contains scripts and functions to estimate the parameters of default cost under the asssumption they differ across sectors. `Master.m` is the main file. There, I obtain empirical estimates from Argentinean data as a first step, and save those results in structure `d`. Note that I save parameters of the model in structure `p`, and vectors and matrices (grids for productivity and debt, transition matrix, etc.) in structure `v`. 

Then, I estimate default cost parameters using two methods: Indirect Inference (`p.moment=0`) and Simulated Method of Moments (`p.moment=1`). I follow a two-step procedure:
  1. I run a grid search over reasonable values of parameters. To do so, I use the function `gridsearch.m`. In that function, I use the structures `p`, `v`, and `d` and obtain parameters that minimize the criterion objective in an interval given by `p.LowBoundT` (`p.LowBoundN`) and `p.UpBoundT`(`p.UpBoundT`) for the case of tradable (non tradable) GDP using the function `inference.m`. Take into account the model is solved by value function iteration.
  2. I use a Matlab solver (`fminsearch`). See the function `solversearch.m`.
Results from both methodologies are saved in the self-explained structures `smm`and `ii`. 

Then I get the standard errors using those results and other structures by the function `standarderrors.m`.
