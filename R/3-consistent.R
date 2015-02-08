####################################################
#'title         : 3-edit
#'date          : January, 2015
#'purpose       : Convert ordinal data (to what?)
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : import excel file from the shared files and delete the 
#'output        : data frame and RData (of what? why?)
#####################################################
# 
#---- Set working directory 
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)

#----Load R.Data file from output folder
load(file="output/2-correct.class.skep1survey.RData")

# This step is to seelect the numeric data set se

levels(data$cs)[levels(data$cs) == "very poor"] <- 1
levels(data$cs)[levels(data$cs) == "poor"] <- 2
levels(data$cs)[levels(data$cs) == "average"] <- 3
levels(data$cs)[levels(data$cs) == "good"] <- 4
levels(data$cs)[levels(data$cs) == "very good"] <- 5

save(data, file ="output/3-consistent.output.RData")

# eos

