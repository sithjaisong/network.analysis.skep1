#################Title###############################
#'title         : 5-1.OutputProfile_subset
#'date          : January, 2015
#'purpose       : Subset Injuries profiles
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : 
#'output        : data frame and RData 
###################End of Title###########################
# generate the network model for the season
#---Load Library----
library(plyr)
library(dplyr)
#---- Set working directory ----
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#-----Load data from uptput folder ----

load(file = "output/5-OutputProfile.RData")

data <- OutputProfile

#--- sunset data ----
#--- all data ----
all <- data %>% 
        select(-c(country, season)) # select out the country and season column

all <- all[,apply(all, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

all<- all[complete.cases(all),] # exclude row which cantain NA
#--- wet season data ----
ws <- data %>% 
        filter(season == "WS") %>%
        select(-c(country, season))

ws <- ws[,apply(ws, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ws<- ws[complete.cases(ws),] # exclude row which cantain NA

#--- dry season dat ----
ds <- data %>% 
        filter(season == "DS") %>%
        select(-c(country, season))

ds <- ds[,apply(ds, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ds<- ds[complete.cases(ds),] # exclude row which cantain NA

#---- The Philippines n = 40 ----
php <- data %>% 
        filter( country == "PHL") %>%
        select(-c(country, season))

php <- php[,apply(php, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

php <- php[complete.cases(php),] # exclude row which cantain NA

#--- India  N = 105 ---- 

ind <- data %>% 
        filter( country == "IND") %>%
        select(-c(country, season))

ind <- ind[,apply(ind, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ind <- ind[complete.cases(ind),] # exclude row which cantain NA

#--- Indonesia N= 100 -----
idn <- data %>% 
        filter( country == "IDN") %>%
        select(-c(country, season))

idn <- idn[,apply(idn, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

idn <- ind[complete.cases(idn),] # exclude row which cantain NA

#---- Thailand n = 105 ----

tha <- data %>% 
        filter( country == "THA") %>%
        select(-c(country, season))

tha <- tha[,apply(tha, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

tha <- ind[complete.cases(tha),] # exclude row which cantain NA

#--- Vietnam n = 105 ----
vnm <- data %>% 
        filter( country == "VNM") %>%
        select(-c(country, season))

vnm <- vnm[,apply(vnm, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

vnm <- ind[complete.cases(vnm),] # exclude row which cantain NA

save(all, ws, ds, php, ind, idn, tha, vnm, file = "output/5-1OutputProfile_subset.RData")
