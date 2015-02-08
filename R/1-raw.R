##############################################################################
# title         : 1-raw.R;
# purpose       : Loads raw data for network analysis of Syngenta SKEP1 data;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : which XLS file?;
# outputs       : what data.frame and RData?;
# remarks 1     : ;
# remarks 2     : ;
##############################################################################

#### Load Library ####
 library(gdata)
#### end load libraries ####

#### Set working directory and filepath ####
wd = "~/Documents/R.github/network.analysis.skep1" 
setwd(wd)

Filepath <- "~/Google Drive/1.SKEP1/SKEP1survey.xls"
#### End directory and filepath ####


##### Load raw data (Survey data in SKEP 1) ####
data <- read.xls(Filepath, 
                 sheet = 1, 
                 header = TRUE,
                 stringsAsFactor = FALSE)
#### End load raw data ####

#### Examine the raw data ####
 head(data) 
 str(data) # check the class of each variable
 summary(data)
#### end raw data ####

#### Save data to R object ####
 save(data, file = "output/1-raw.skep1survey.RData")
#### end save data ####

# eos
