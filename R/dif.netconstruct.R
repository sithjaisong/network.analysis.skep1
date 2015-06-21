# load data from clean.R ----
load(file = "output/single.data.RData") # optional


data$year <- NULL
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

# diff net under dif searson
data$country <- NULL
data$season

data.dry <- subset(data, season %in% "DS") 
data.dry$season <- NULL
data.wet <- subset(data, season %in% "WS")
data.wet$season <- NULL

data.dry <- data.dry[ ,apply(data.dry, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

data.wet <- data.wet[ ,apply(data.wet, 2, var, na.rm = TRUE) != 0] 


data.dry <- data.dry[complete.cases(data.dry), ] # exclude row which cantain NA

data.wet <- data.wet[complete.cases(data.wet), ] # exclude row which cantain NA

# describe(data) option # I think utul this sptep data are ready to analysis
save(data.dry, data.wet, file = "output/diff.data.RData")
