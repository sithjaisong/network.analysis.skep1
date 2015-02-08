#################Title###############################
#'title         : A1-spearman_season
#'date          : January, 2015
#'purpose       : Select Injuries profiles
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : import excel file from the shared files and delete the 
#'output        : data frame and RData 
###################End of Title###########################
# generate the network model for the season
#---Load Library----
library(plyr)
library(dplyr)
library(qgraph)

#---- Set working directory ----
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#-----Load data from uptput folder ----

load(file = "output/5-OutputProfile.RData")

data <- OutputProfile

#----network construction in each country ----
#---- The Philippines n = 40 ----

php <- data %>% 
        filter( country == "PHL") %>%
        select(-c(country, season))

php <- php[,apply(php, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

php <- php[complete.cases(php),] # exclude row which cantain NA

php.spear <- cor(php, method = "spearman")

q.php.spear <- qgraph(php.spear,
            sampleSize = nrow(php),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Philippines",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.php'
)

#--- India  N = 105 ---- 

ind <- data %>% 
        filter( country == "IND") %>%
        select(-c(country, season))

ind <- ind[,apply(ind, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ind <- ind[complete.cases(ind),] # exclude row which cantain NA

ind.spear <- cor(ind, method = "spearman")

q.ind.spear <- qgraph(ind.spear,
            sampleSize = nrow(ind),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in India",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.ind'
)

#--- Indonesia N= 100 -----
idn <- data %>% 
        filter( country == "IDN") %>%
        select(-c(country, season))

idn <- idn[,apply(idn, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

idn <- ind[complete.cases(idn),] # exclude row which cantain NA

idn.spear <- cor(idn, method = "spearman")

q.idn.spear <- qgraph(idn.spear,
            sampleSize = nrow(idn),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Indonesia",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.idn'
)

#---- Thailand n = 105 ----

tha <- data %>% 
        filter( country == "THA") %>%
        select(-c(country, season))

tha <- tha[,apply(tha, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

tha <- ind[complete.cases(tha),] # exclude row which cantain NA

tha.spear <- cor(tha, method = "spearman")

q.tha.spear <- qgraph(tha.spear,
            sampleSize = nrow(tha),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Thailad",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.tha'
)

#--- Vietnam n = 105 ----
vnm <- data %>% 
        filter( country == "VNM") %>%
        select(-c(country, season))

vnm <- vnm[,apply(vnm, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

vnm <- ind[complete.cases(vnm),] # exclude row which cantain NA

vnm.spear <- cor(vnm, method = "spearman")

q.vnm.spear <- qgraph(vnm.spear,
            sampleSize = nrow(ind),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Vietnam",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.vnm'
)

#---- Network perperties ----
#clusterCoef(abs(vnm.spear.cor))

save(php, idn, idn, tha, vnm, q.php.spear, q.idn.spear, q.idn.spear, q.tha.spear, q.vnm.spear, file = "output/A-1spear.country.RData")
