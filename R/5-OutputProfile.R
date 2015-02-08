####################################################
#'title         : 5-OutputProfile
#'date          : January, 2015
#'purpose       : Select Injuries profiles
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : import excel file from the shared files and delete the 
#'output        : data frame and RData 
#####################################################
#---Load Library ----
library(plyr)
library(dplyr)
#---- Set working directory 
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#-----Load data from uptput folder
load(file ="output/3-consistent.output.RData")

#---- select the output profile which contain the insect pests and diseases ----
OutputProfile <- data %>% 
        select (#phase, # Phase No. #fno, 
        country, #year, 
        season,
        #cs,      
        ldg,  
        # yield, #dscum, #wecum,   
        #ntmax, 
        #npmax ,    
        #nltmax ,  
        #nlhmax ,  
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
        rsa ,   
        lsa,    
        shbx ,  
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

save(OutputProfile, file = 'output/5-OutputProfile.RData')

# eos

