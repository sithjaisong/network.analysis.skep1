########################Header################################################
# title         : 3-2consistent
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
load(file = "output/3-1remove.skep1survey.RData")
#### End Load .RData file from output folder ####

#### Recoding the factor ####
# Previous crop
data$pc <- ifelse(data$pc == "rice", 1, 0)
 
#Crop establisment method
levels(data$cem)[levels(data$cem) == "trp"] <- 1
levels(data$cem)[levels(data$cem) == "TPR"] <- 1
levels(data$cem)[levels(data$cem) == "DSR"] <- 2
levels(data$cem)[levels(data$cem) == "dsr"] <- 2

# fym there are two type 0 and 1, raw data are recorded as no, yes, and value, if the value is 0 which mean 0 and if the value more than 0 which means 1 

data$fym <- ifelse(data$fym == "no", 0, 
                  ifelse(data$fym == "0", 0, 1
                         )
                  )
# vartype there are three type treditional varieties, modern varities and hybrid
data$vartype <- ifelse(data$vartype == "tv", 1,
                       ifelse(data$vartype == "mv", 2,
                              ifelse(data$vartype == "hyb", 3, NA
                                     )
                              )
                       )
# wcp weed control management
levels(data$wcp)[levels(data$wcp) == "hand"] <- 1
levels(data$wcp)[levels(data$wcp) == "herb"] <- 2
levels(data$wcp)[levels(data$wcp) == "herb-hand"] <- 3


# Crop Status
levels(data$cs)[levels(data$cs) == "very poor"] <- 1
levels(data$cs)[levels(data$cs) == "poor"] <- 2
levels(data$cs)[levels(data$cs) == "average"] <- 3
levels(data$cs)[levels(data$cs) == "good"] <- 4
levels(data$cs)[levels(data$cs) == "very good"] <- 5
#### end of recoding the factor ####


#### Save data to R object ####
save(data, file = "output/3-2consistent.output.RData")
#### end save data ####
# eos
