
# Chaprter 1 SIngle netwotk analysis (load and clean data)-----


#Load library -----
library(XLConnect) # for load data
library(plyr) # manipulate the data
library(dplyr) # manipulate the data
library(lubridate) # manipulate the data


# Set working directory and filepath -----
wd <- "~/Documents/R.github/network.analysis.skep1" # call for the working directory
setwd(wd)
# gerwd() # check your working directoty


# Load raw data (Survey data in SKEP 1)------
#Filepath <- "~/Google Drive/1.SKEP1/SKEP1survey.xls" # please check your file in shared google drive
Filepath <- "E:/Google Drive/Data/SYT-SKEP/Survey/SKEP1survey.xls" # please check your file in shared google drive
data <- readWorksheetFromFile(Filepath, 
                 sheet = 1)

# Examine the raw data -----
#head(data) 
#str(data) # check the class of each variable
#summary(data)


# define the missing value -----
data[data == "-"] <- NA # replace '-' with NA
data[data == ""] <- NA # replace 'missing data' with NA


# to lower variable names -----
names(data) <- tolower(names(data))


# Type conversion ----

data <- transform(data, 
                  phase = as.factor(phase),
                  fno = as.character(fno),
                  identifier = as.character(identifier),
                  country = as.factor(country),
                  year = as.factor(year),
                  season  = as.factor(season),   
                  lat = as.numeric(lat),
                  long = as.numeric(long),      
                  village = as.character(village), 
                  fa = as.numeric(fa),
                  fn = as.character(fn),
                  lfm = as.character(lfm),
                  pc = as.factor(pc),
                  fp = as.character(fp),        
                  cem = as.factor(cem),     
                  ast = as.factor(ast),       
                  nplsqm = as.numeric(nplsqm),
                  ced = dmy(ced), # Date data try to use as.Data(., format = '%d-%b-%y') it is not working
                  cedjul = as.numeric(cedjul),
                  hd = dmy(hd), 
                  hdjul = as.numeric(hdjul),     
                  ccd = as.numeric(ccd),
                  cvr = as.character(cvr),
                  vartype = as.factor(vartype),
                  varcoded = as.factor(varcoded),
                  fym = as.character(fym),
                  fym.coded = as.factor(fym.coded),
                  n = as.numeric(n),
                  p = as.numeric(p) ,
                  k = as.numeric(k),
                  mf = as.numeric(mf),        
                  wcp = as.factor(wcp),      
                  mu = as.character(mu) ,     
                  iu = as.numeric(iu),     
                  hu = as.numeric(hu),      
                  fu = as.numeric(fu),      
                  cs  = as.factor(cs),      
                  ldg  =  as.numeric(ldg),  
                  yield = as.numeric(yield) ,
                  dscum = as.factor(dscum),   
                  wecum = as.factor(wecum),   
                  ntmax = as.numeric(ntmax), 
                  npmax = as.numeric(npmax),    
                  nltmax = as.numeric(nltmax),  
                  nlhmax = as.numeric(nltmax),  
                  waa = as.numeric(waa),      
                  wba = as.numeric(wba) ,   
                  dhx =  as.numeric(dhx),  
                  whx =  as.numeric(whx),     
                  ssx  = as.numeric(ssx),  
                  wma = as.numeric(wma), 
                  lfa = as.numeric(lfa),
                  lma = as.numeric(lma),   
                  rha  = as.numeric(rha) ,
                  thrx = as.numeric(thrx),    
                  pmx = as.numeric(pmx),    
                  defa  = as.numeric(defa) ,
                  bphx = as.numeric(bphx),   
                  wbpx = as.numeric(wbpx),    
                  awx  = as.numeric(awx), 
                  rbx =as.numeric(rbx),   
                  rbbx = as.numeric(rbbx),  
                  glhx  = as.numeric(glhx), 
                  stbx=as.numeric(stbx),    
                  rbpx = as.numeric(rbpx), 
                  hbx= as.numeric(hbx),
                  bbx = as.numeric(bbx),    
                  blba = as.numeric(blba),    
                  lba = as.numeric(lba),    
                  bsa = as.numeric(bsa),    
                  blsa = as.numeric(blsa),  
                  nbsa = as.numeric(nbsa),  
                  rsa  = as.numeric(rsa),   
                  lsa = as.numeric(lsa),    
                  shbx = as.numeric(shbx) ,  
                  shrx = as.numeric(shrx),    
                  srx= as.numeric(srx),    
                  fsmx = as.numeric(fsmx),   
                  nbx =  as.numeric(nbx),   
                  dpx = as.numeric(dpx),    
                  rtdx  = as.numeric(rtdx),  
                  rsdx  = as.numeric(rsdx),
                  gsdx  =as.numeric(gsdx),   
                  rtx = as.numeric(rtx)
) 

# Delete the unnessary variables variables without data (NA) ####
data$fno <- NULL
data$lat <- NULL
data$long <- NULL
data$phase <- NULL # there is only one type yype of phase in the survey
data$identifier <- NULL # this variable is not included in the analysis
data$village <- NULL # name of villages 
data$fa <- NULL # field area is not include in the analysis
data$fn <- NULL # farmer name can not be included in this survey analysis
data$fp <- NULL # I do not know what is fp
data$lfm <- NULL # there is only one type of land form in this survey
data$ced <- NULL # Date data can not be included in the network analysis
data$cedjul <- NULL # crop esptabishment julain date
data$hd <- NULL # Date data can not be included in the network analysis
data$hdjul <- NULL # harvest julian date
data$cvr <- NULL # cativar name is not cluded in network analysis
data$varcoded <- NULL # I will recode them 
data$fym.coded <- NULL # this fym.codeed will not include in network analysis
data$mu <- NULL # muluscicide has no record
data$nplsqm <- NULL # nplsqm is number of plant leaf per squremeter

# Recoding the factor ----
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

# save single data ------------
save(data, file = "output/single.data.Rdata ")

#eos -----------
