rm(list = ls()) # Optional
##### Load library #####
library(BayesianFirstAid)
library(BEST)
library(dplyr)
##### End of loading library #####

##### Load data
load(file = "output/3-2consistent.output.RData")
##### End of load data

##### Estimate Yield of all location ######
yield<- data$yield
mean(yield)
BEST_yield <- BESTmcmc(as.numeric(yield)) 
summary(BEST_yield)
plot(BEST_yield)
plotAll(BEST_yield)
##### End of Estimate Yield of all locations #####

##### Estimate Yield in Philippines #####
php.yield <- data %>%
        filter(country == "PHL") %>%
        select(yield)
mean(php.yield)
php.yield <- as.numeric(php.yield$yield) # data input must be numeric 
BEST_php.yield <- BESTmcmc(php.yield)
save(BEST_php.yield, file = "output/BayEstPhiYield.RData")
summary(BEST_php.yield)
plotAll(BEST_php.yield)
##### End of estimate yield Philippines #####

##### Estimate Yield in India #####
ind.yield <- data %>%
        filter(country == "IND") %>%
        select(yield)
#mean(ind.yield)
ind.yield <- as.numeric(ind.yield$yield) # data input must be numeric 
BEST_ind.yield <- BESTmcmc(ind.yield)
summary(BEST_ind.yield)
plotAll(BEST_ind.yield)
##### End of estimate yield India #####

##### Estimate Yield in Indonesia #####
idn.yield <- data %>%
        filter(country == "IDN") %>%
        select(yield)
#mean(idn.yield)
idn.yield <- as.numeric(idn.yield$yield) # data input must be numeric 
BEST_idn.yield <- BESTmcmc(idn.yield)
summary(BEST_idn.yield)
plotAll(BEST_idn.yield)
##### End of estimate yield Indonesia #####

##### Estimate Yield in Thailand #####
tha.yield <- data %>%
        filter(country == "THA") %>%
        select(yield)
#mean(tha.yield)
tha.yield <- as.numeric(tha.yield$yield) # data input must be numeric 
BEST_tha.yield <- BESTmcmc(tha.yield)
summary(BEST_tha.yield)
plotAll(BEST_tha.yield)
##### End of estimate yield Thailand #####


##### Estimate Yield in Vietnam #####
vnm.yield <- data %>%
        filter(country == "VNM") %>%
        select(yield)
#mean(vnm.yield)
vnm.yield <- as.numeric(vnm.yield$yield) # data input must be numeric 
BEST_vnm.yield <- BESTmcmc(vnm.yield)
summary(BEST_vnm.yield)
plotAll(BEST_vnm.yield)
##### End of estimate yield Vietnam #####

##### Save #####
save(BEST_php.yield, file = "output/BayEstPhiYield.RData")
