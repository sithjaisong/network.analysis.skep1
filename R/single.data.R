# Single netowrk analysis


# load library -----
library(psych) # for exploratoty data
library(WGCNA) # network analysis package
library(qgraph) # network analysis package

# load data from clean.R ----
load(file = "output/single.data.RData") # optional

# remove some countries, years, and seasons
#names(data)
# This data still have countries, year , and season in the data frame
# Single network will determine whole data set
# so it will be removed those variables

data$country <- NULL
data$year <- NULL
data$season <- NULL
data$yield <- NULL

# change the vartype -----
data <- transform(data,
                 cem = as.numeric(as.factor(cem)),
                 ast = as.numeric(as.factor(ast)),
                 wcp = as.numeric(as.factor(wcp)),
                 cs = as.numeric(as.factor(cs)),
                 dscum = as.numeric(as.factor(dscum)),
                 wecum = as.numeric(as.factor(wecum))
                 )


# remove rows with NA
data$rbpx <- NULL # no data in rbpx

# IMPORTANT to remove the variable with S.E = 0 -------- 
#because it will not accept if you want to test correlation 

data <- data[ ,apply(data, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

data <- data[complete.cases(data), ] # exclude row which cantain NA

# describe(data) option # I think utul this sptep data are ready to analysis

# save data for single network analysis -----
save(data, file = "output/clean.single.data.RData")

#eos
