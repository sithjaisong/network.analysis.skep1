#====== Loading the package
library(ggplot2)
require(dplyr)
require(reshape)
require(reshape2)
require(qgraph)
library(gridExtra)
library(cowplot)
library(lubridate)
library(XLConnect)
library(qgraph)
library(IsingFit)
library(psych)

#=== Loading the data ####

#Filepath <- "E:/Google Drive/1.SKEP1/SKEP1survey.xls" # please check your file in shared google drive
Filepath <- "~/Google Drive/1.SKEP1/SKEP1survey.xls"
data <- readWorksheetFromFile(Filepath, sheet = 1)


#====== clean define the missing value ####

data[data == "-"] <- NA # replace '-' with NA
data[data == ""] <- NA # replace 'missing data' with NA


##### to lower variable names ####

names(data) <- tolower(names(data))


#### correct type of data ####

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
                  ced = dmy(ced),# Date data try to use as.Data(., format = '%d-%b-%y') it is not working
                  cedjul = as.numeric(cedjul),
                  hd = dmy(hd), 
                  hdjul = as.numeric(hdjul),     
                  ccd = as.numeric(ccd),
                  cvr = as.character(cvr),
                  vartype = as.factor(vartype),
                  varcoded = as.factor(varcoded),
                  fym = as.character(fym),
                  fymcoded = as.factor(fymcoded),
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

#### Delete the unnessary variables variables without data (NA) ####
data$phase <- NULL # there is only one type yype of phase in the survey
data$identifier <- NULL # this variable is not included in the analysis
data$village <- NULL
data$fa <- NULL # field area is not include in the analysis
data$fn <- NULL # farmer name can not be included in this survey analysis
data$fp <- NULL # I do not know what is fp
data$lfm <- NULL # there is only one type of land form in this survey
data$ced <- NULL # Date data can not be included in the network analysis
data$cedjul <- NULL
data$hd <- NULL # Date data can not be included in the network analysis
data$hdjul <- NULL
data$cvr <- NULL
data$varcoded <- NULL # I will recode them 
data$fym.coded <- NULL
data$mu <- NULL # no record
data$nplsqm <- NULL
#### Delete the unnessary variables variables without data (NA) ####

describe(data)

OutputProfile <- data %>% 
        select (
                country, 
                season,
                pc,
                cem,    
                varcoded,
                n,
                p,
                k,
                mf,        
                wcp,      
                mu,     
                iu,     
                hu,      
                fu,   
                dhx,  
                whx,     
                ssx,  
                wma, 
                lfa,
                lma,   
                rha, 
                thrx,    
                pmx,    
                defa,
                bphx,   
                wbpx,
                awx, 
                rbx,   
                rbbx,  
                glhx, 
                stbx,
                hbx,  
                bbx,    
                blba,    
                lba,    
                bsa,    
                blsa,  
                nbsa,  
                rsa,   
                lsa,    
                shbx,  
                shrx,    
                srx,    
                fsmx,   
                nbx,   
                dpx,    
                rtdx,  
                rsdx,
                gsdx,   
                rtx 
        ) 

data <- OutputProfile

#### The Philippines n = 40 ####
# php <- data %>% 
#         filter( country == "PHL") %>%
#         select(-c(country, season))
# 
# php <- php[,apply(php, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0
# 
# php <- php[complete.cases(php),] # exclude row which cantain NA
#### end Philippines subset ####

#==========Ignore
# #### India  N = 105 #### 
# ind <- data %>% 
#         filter( country == "IND") %>%
#         select(-c(country, season))
# 
# ind <- ind[,apply(ind, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0
# 
# ind <- ind[complete.cases(ind),] # exclude row which cantain NA
# #### end India subset ####
# 
# ##### Indonesia N= 100 ####
# idn <- data %>% 
#         filter( country == "IDN") %>%
#         select(-c(country, season))
# 
# idn <- idn[,apply(idn, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0
# 
# idn <- idn[complete.cases(idn),] # exclude row which cantain NA
# #### end Indonesia subset ####
# 
# #### Thailand n = 105 ####
# 
tha <- data %>% 
        filter(country == "THA") %>%
        select(-country)

tha <- tha[,apply(tha, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

tha <- tha[complete.cases(tha),] # exclude row which cantain NA
# #### end Thailand subset ####
# 
# #### Vietnam n = 105 ####
# vnm <- data %>% 
#         filter( country == "VNM") %>%
#         select(-c(country, season))
# 
# vnm <- vnm[,apply(vnm, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0
# 
# vnm <- vnm[complete.cases(vnm),]
# 
