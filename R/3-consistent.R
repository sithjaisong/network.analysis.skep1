########################Header################################################
# title         : 3-consistent
# purpose       : recoding the factors;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 2-correct.class.skep1.survey.RData;
# outputs       : 3-consistant.output.RData;
# remarks 1     : ;
# remarks 2     : ;
#####################################################

#### Set working directory  ####
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#### End of set working directory ####

#### Load R.Data file from output folder ####
load(file = "output/2-correct.class.skep1survey.RData")
#### End Load E.Data file from output folder ####

#### Recoding the factor ####
levels(data$cs)[levels(data$cs) == "very poor"] <- 1
levels(data$cs)[levels(data$cs) == "poor"] <- 2
levels(data$cs)[levels(data$cs) == "average"] <- 3
levels(data$cs)[levels(data$cs) == "good"] <- 4
levels(data$cs)[levels(data$cs) == "very good"] <- 5
#### end od recoding the factor ####


#### Save data to R object ####
save(data, file = "output/3-consistent.output.RData")
#### end save data ####
# eos
