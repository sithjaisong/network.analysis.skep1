####################################################
#'title         : 1-raw
#'date          : January, 2015
#'purpose       : Load raw data from 
#'                format
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : the xts file                
#'output        : data.frame and RData 
#####################################################
# The is the script of Exploratory Data Analysis
#------Load Library-----
 library(gdata)
#---- Set working directory 
# set your working directory
#wd = '~/Documents/R.github/network.analysis.skep1' 
#setwd(wd)

Filepath <- '~/Google Drive/1.SKEP1/SKEP1survey.xls'
#-----Load raw data (Survey data in SKEP 1)-----

data <- read.xls(Filepath, 
                 sheet = 1, 
                 header = TRUE,
                 stringsAsFactor = FALSE)

#------ Examine the raw data ------

 head(data) 
 str(data) # check the class of each variable
 summary(data)

#---save data to R object ----

save(data, file = "output/1-raw.skep1survey.RData")


