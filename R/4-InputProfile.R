########################Header################################################
#'title         : 4-InputProfile
# purpose       : subset the data: Input Profile (farmer's practices);
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 3-consistant.output.RData;
# outputs       : 4-InProfile.RData;
# remarks 1     : ;
# remarks 2     : ;
#####################################################
#### Load Library ####
library(plyr)
library(dplyr)
#### End od loading libraries ####

#### Set working directory ####
# set your working directory
#wd <- '~/Documents/R.github/network.analysis.skep1' 
wd <- 'C:/Users/sjaisong/Documents/GitHub/network.analysis.skep1' # for window

setwd(wd)
#### end of set wotking directory ####

#### Load data from uptput folder ####
load(file = "output/3-2consistent.output.RData")
#### end of load data from outout file ####

### select the output profile which contain the insect pests and diseases ###
InputProfile <- data %>% 
        select (country, 
                year, 
                season,
                pc,
                cem,
                #ast,
                #nplsqm,
                #ccd,
                vartype,
                fym,
                n,
                p,
                k,
                mf,
                wcp,
                iu,
                hu,
                fu,
                cs,      
                #ldg,  
                #yield,
                dscum, 
                wecum   
                ) 

#### end of subset dataset

#### Save data to R object ####
save(InputProfile, file = 'output/4-InputProfile.RData')
#### end save data ####

# eos
