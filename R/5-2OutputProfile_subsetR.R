########################Header################################################
#'title         : 5-1.OutputProfile_subset
# purpose       : subset Output data by season and country;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 5-OutputProfile.RData;
# outputs       : 5-1OutputProfile_subset.RData;
# remarks 1     : ;
# remarks 2     : ; 
###################End###########################
# generate the network model for the season
#---Load Library----
library(plyr)
library(dplyr)
#---- Set working directory ----
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)

#####Load data from uptput folder ####

load(file = "output/5-1OutputProfile.RData")

data <- OutputProfile

##### subset data ####

#### all data ####
all <- data %>% 
        select(-c(country, season)) # select out the country and season column

all <- all[,apply(all, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

all<- all[complete.cases(all),] # exclude row which cantain NA
#### end subset all ####

####  subset wet season data ####
ws <- data %>% 
        filter(season == "WS") %>%
        select(-c(country, season))

ws <- ws[,apply(ws, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ws<- ws[complete.cases(ws),] # exclude row which cantain NA
### end subset wet season data ####

#### subset dry season data ####
ds <- data %>% 
        filter(season == "DS") %>%
        select(-c(country, season))

ds <- ds[,apply(ds, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ds<- ds[complete.cases(ds),] # exclude row which cantain NA
#### end subset dry season data

##### The Philippines n = 40 ####
php <- data %>% 
        filter( country == "PHL") %>%
        select(-c(country, season))

php <- php[,apply(php, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

php <- php[complete.cases(php),] # exclude row which cantain NA
#### end Philippines subset ####

#### India  N = 105 #### 
ind <- data %>% 
        filter( country == "IND") %>%
        select(-c(country, season))

ind <- ind[,apply(ind, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ind <- ind[complete.cases(ind),] # exclude row which cantain NA
#### end India subset ####

##### Indonesia N= 100 ####
idn <- data %>% 
        filter( country == "IDN") %>%
        select(-c(country, season))

idn <- idn[,apply(idn, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

idn <- idn[complete.cases(idn),] # exclude row which cantain NA
#### end Indonesia subset ####

#### Thailand n = 105 ####

tha <- data %>% 
        filter( country == "THA") %>%
        select(-c(country, season))

tha <- tha[,apply(tha, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

tha <- tha[complete.cases(tha),] # exclude row which cantain NA
#### end Thailand subset ####

#### Vietnam n = 105 ####
vnm <- data %>% 
        filter( country == "VNM") %>%
        select(-c(country, season))

vnm <- vnm[,apply(vnm, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

vnm <- vnm[complete.cases(vnm),] # exclude row which cantain NA
#### end Vietnam subset ####

#### Save data to R object ####
save(all, ws, ds, php, ind, idn, tha, vnm, file = "output/5-2OutputProfile_subset.RData")
#### end save data ####
#eos
