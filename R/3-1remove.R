########################Header################################################
# title         : 3-clean
# purpose       : recoding the factors;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 2-correct.class.skep1.survey.RData;
# outputs       : 3-consistant.output.RData;
# remarks 1     : ;
# remarks 2     : ;
#####################################################
### Set working directory  ####
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#### End of set working directory ####

#### Load R.Data file from output folder ####
load(file = "output/2-correct.class.skep1survey.RData")
#### End Load .RData file from output folder ####

#### Delete the unnessary variables variables without data (NA) ####
data$phase <- NULL # there is only one type yype of phase in the survey
data$identifier <- NULL # this variable is not included in the analysis
data$village <- NULL
data$fa <- NULL # field area is not include in the analysis
data$fn <- NULL # farmer name can not be included in this survey analysis
data$fp <- NULL # I do not know what is fp
data$lfm <- NULL # there is only one type of land form in this survey
data$ced <- NULL # Date data can not be included in the network analysis
data$cedjul <- NULL
data$hd <- NULL # Date data can not be included in the network analysis
data$hdjul <- NULL
data$cvr <- NULL
data$varcoded <- NULL # I will recode them 
data$fym.coded <- NULL
data$mu <- NULL # no record
data$nplsqm <- NULL
#### Delete the unnessary variables variables without data (NA) ####

#### Save data to R object ####
save(data, file = "output/3-1remove.skep1survey.RData")
#### end save data ####
