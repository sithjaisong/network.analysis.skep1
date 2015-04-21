########################Header################################################
#'title         : A1-spearman_season
#'date          : January, 2015
#'purpose       : Select Injuries profiles
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : import excel file from the shared files and delete the 
#'output        : data frame and RData 
##################End of Title##############################
# generate the network model for the season
#---Load Library ----
library(qgraph)
# 
#---- Set working directory -----
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#-----Load data from uotput folder ----

load(file = "output/5-1OutputProfile_subset.RData")

#### Spear's man correaltion network of SKEP1 ####
all.spear <- cor(all, method = "spearman")

q.all.spear<- qgraph(all.spear,
            sampleSize = nrow(all),
            graph = 'assosciation',
            #layout = "spring",
            minimum = "sig",
            maximum = 0.6,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = TRUE,
            #------ node
            vsize = c(1.5,8),
            #------edge
            borders = FALSE,
            vTrans = 200,
            edge.labels = TRUE,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in South and South East Asia",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.all'
)
#### end of Spear's man correaltion network of SKEP1 ####

##### Kendall Correlation #####
all.kend <- cor(all, method = "kendall", use = "pairwise") 

q.all.kendall <- 
        
        qgraph(all.kend,
                     sampleSize = nrow(all),
                     graph = 'assosciation',
                     #layout = "spring",
                     minimum = "sig",
                     maximum = 0.6,
                     # cut = 0.3 ,
                     # threshold = "locfdr",
                     bonf = TRUE,
                     #------ node
                     vsize = c(1.5,8),
                     #------edge
                     borders = FALSE,
                     vTrans = 200,
                     edge.labels = TRUE,
                     edge.label.cex = 0.5,
                     layout = "spring",
                     title = "Kendall's correlation based Network with bonf correction in South and South East Asia"
                    # filetype = 'pdf',
                    # filename ='figs/qgraph.kend.all'
)

####


#### Spear's man correaltion network of Wet season ####
# construc the correlation network by spear's man correlation
# and select out the edges that show unsig by apply the bonferinr adjectment
# set the node size follwowing the connection, which nodes have
ws.spear.cor <- cor(ws, method = "spearman")

q.ws.spear<- qgraph(ws.spear.cor,
            sampleSize = nrow(ws),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = TRUE,
            #------ node
            vsize = c(1.5,8),
            #------edge
            borders = FALSE,
            vTrans = 200,
            edge.labels = TRUE,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Wet season",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.ws'
            )
#### end of Spear's man correaltion network of wet season ####

#### Spear's man correaltion network of Dry season ####
# find the spear's man correaltion 
ds.spear.cor <- cor(ds, method = "spearman")

# construc the correlation network by spear's man correlation
# and select out the edges that show unsig by apply the bonferinr adjectment
# set the node size follwowing the connection, which nodes have
q.ds.spear <- qgraph(ds.spear.cor,
            sampleSize = nrow(ds),
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
            title = "Spearman's correlation based Network with bonf correction in Dry season",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.ds'
            )
#### end of Spear's man correaltion network of Dry season ####

#### Save data to R object ####
save(all, ws, ds, q.all.spear, q.ds.spear, q.ws.spear, file = "output/A-1spear.all.season.RData")
#### end save data ####

#--- compare graph ----
# L <- averageLayout(PCorMat, PCorMat_FDR)
# layout(t(1:2))
#qgraph(PCorMat, layout = L, title = "Partial correlation network", maximum = 1, cut = 0.1, minimum = 0, esize = 20)
#qgraph(PCorMat_FDR, layout = L, title = "Local FDR partial correlation network", maximum = 1, cut = 0.1, minimum = 0, esize = 20)

# FDRnetwork is the function to adjust the 

#eos


