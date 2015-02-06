####################################################
#'title         : 2-technically_correct
#'date          : January, 2015
#'purpose       :  
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : import excel file from the shared files and delete the 
#'output        : data frame and RData 
#####################################################
# 
library(plyr)
library(dplyr)
library(lubridate)
#-----Load file from output folder-----

load(file = "output/1-raw.skep1survey.RData")


#----- clean define the missing value -----

data[data == "-"] <- NA # replace '-' with NA
data[data == ""] <- NA # replace 'missing data' with NA

#----- to lower variable names ----- 
names(data) <- tolower(names(data))

#----- This step is to seelect the numeric data set -----

data <- transform(data, 
                  phase = as.factor(phase),
                  fno  = as.character(fno),
                  identifier = as.character(identifier),
                  country = as.factor(country),
                  year = as.factor(year),
                  season  = as.character(season),   
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
                  hd = dmy(hd),  # Date data
                  hdjul = as.numeric(hdjul),     
                  ccd = as.character(ccd),
                  cvr = as.character(cvr),
                  vartype = as.character(vartype),
                  varcoded = as.character(varcoded),
                  fym = as.character(fym),
                  fym.coded = as.character(fym.coded),
                  n = as.numeric(n),
                  p = as.numeric(p) ,
                  k = as.numeric(k),
                  mf = as.numeric(mf),        
                  wcp = as.character(wcp),      
                  mu = as.character(mu) ,     
                  iu = as.numeric(iu),     
                  hu = as.numeric(hu),      
                  fu = as.numeric(fu),      
                  cs  = as.factor(cs),      
                  ldg  =  as.numeric(ldg),  
                  yield = as.numeric(yield) ,
                  dscum = as.numeric(dscum),   
                  wecum = as.numeric(wecum),   
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

save(data, file="output/2-correct.class.skep1survey.RData")
