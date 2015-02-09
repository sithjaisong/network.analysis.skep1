########################Header################################################
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

load(file = "output/5-1OutputProfile_subset.RData")

#---- The Philippines n = 40 ----
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

#### Save data to R object ####
save(q.idn.spear, q.idn.spear, q.tha.spear, q.vnm.spear, file = "output/A-1spear.country.RData")
#### end save data ####
