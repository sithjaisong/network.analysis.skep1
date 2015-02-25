########################Header################################################
#'title         : 5-OutputProfile
# purpose       : subset the data: Output data (insect and disease);
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 3-consistant.output.RData;
# outputs       : 5-OutputProfile.RData;
# remarks 1     : ;
# remarks 2     : ;
#####################################################
#### Load Library ####
library(plyr)
library(dplyr)
#### End od loading libraries ####

#### Set working directory ####
# set your working directory
wd <- '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#### end of set wotking directory ####

#### Load data from uptput folder ####
load(file = "output/3-2consistent.output.RData")
#### end of load data from outout file ####

### select the output profile which contain the insect pests and diseases ###
OutputProfile <- data %>% 
        select (
        #phase, 
        #phase No. 
        #fno, 
        country, 
        #year, 
        season,
        #cs,      
        ldg,  
        #yield,
        #dscum, 
        #wecum,   
        #ntmax, 
        #npmax,    
        #nltmax,  
        #nlhmax,  
        #waa,      
        #wba,   
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
        #rbpx,  
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

#### end of subset dataset

#### Save data to R object ####
save(OutputProfile, file = 'output/5-1OutputProfile.RData')
#### end save data ####

# eos
