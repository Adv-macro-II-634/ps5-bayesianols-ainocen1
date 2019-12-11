clear
set more off


import delimited C:\Users\ainocen1\Downloads\card.csv

*1) OLS of log wage on educ, exper, SMSA, race=black, region=south

reg lwage educ exper smsa black south

*2) Bayes Metropolis-Hastings algorithm

*MCMC
bayes: regress lwage educ exper smsa black south
bayesgraph diagnostics _all

*a) 
*Using Metropolis-Hastings algorithm, flat priors
bayesmh lwage educ exper smsa black south, likelihood(normal({var})) prior({lwage: _cons educ exper smsa black south}, flat) prior({var}, jeffreys)

bayesgraph histogram _all

*b) Prior beta_educ=0.06, CI[0.035, 0.085], SD = 2*SD_prior, flat else
*Computed for S using formula for CI
* 0.035 = 0.06 - 1.96(s/(n^0.5))
* 0.085 = 0.06 +- 1.96(s/(n^0.5))
* rounding off, sd = 2*sd = 1.40
* so, use variance = (1.4)^2 = 1.97

bayesmh lwage educ exper smsa black south, likelihood(normal({var})) prior({lwage: _cons exper smsa black south}, flat) prior({lwage: educ},normal(0.06,1.97)) prior({var}, jeffreys)

bayesgraph histogram _all
