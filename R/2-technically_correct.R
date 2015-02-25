########################Header################################################
# title         : 2-technically_correct
# purpose       : clean the data and corect the type of data;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 1-raw.skep1survey.RData in output folder;
# outputs       : 2-correct.class.skep1.survey.RData;
# remarks 1     : ;
# remarks 2     : ;
########################End#################################################
#### Load library ####
library(plyr)
library(dplyr)
library(lubridate)
#### End load libraries ####

##### Set working directory ####
# set your working directory
wd <- '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#### end setting directory ####

#### Load file from output folder ####
load(file = "output/1-raw.skep1survey.RData") # why not just source the initial script every time? I don't really like to do this unless I have no choice. 
#### end load file from foler ####

#### clean define the missing value ####
data[data == "-"] <- NA # replace '-' with NA
data[data == ""] <- NA # replace 'missing data' with NA
#### end cleaning of data ####



#### to lower variable names ####
names(data) <- tolower(names(data))
#### end setting the varibales ####

##### Type conversion ####

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

##### End of type convertion ####

#### Save data to R object ####
save(data, file = "output/2-correct.class.skep1survey.RData")
#### end save data ####

# eos
