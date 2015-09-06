########################Header################################################
#'title         : Evaluation of the methos for co occrence network construction
#'date          : April, 2015
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
library(reshape)
library(reshape2)
library(WGCNA)
library(corrplot)
library(qgraph)
library(igraph)
library(RColorBrewer)
#---- Set working directory ----
# set your working directory
#wd <- '~/Documents/R.github/network.analysis.skep1'  # for Mac
wd <- 'C:/Users/sjaisong/Documents/GitHub/network.analysis.skep1' # for window

setwd(wd)
#-----Load data from uptput folder ----

load(file = "output/5-1OutputProfile_subset.RData")

# there are 
#'all is all data
#'ds is selcted for dry season data
#'idn is selected for wet season data
#'ind is selected for Indonesia data
#'php is selected for Philippines data
#'tha is selected for Thailand data
#'vnm is select for Vietnam data
#'ws is selected for wet season data
##### End of loading the output profiles #####

##### Remove two variables that are not related to the injuries profiles
all$ldg <- NULL

row.names(all) <- NULL

colnames(all) <- c("DH", "WH", "SS", "WM", "LF", "DEF", "BPH", "WBP",  "AM" ,
                   "RB", "RBB", "GLH" ,"STB", "BLB", "LB"  ,"BS" , "BLS",
                   "NBS" ,"RS",  "LS"  ,"SHB", "SHR", "SR",  "FSM", "NB" ,
                   "DP", "RTD", "RSD" ,"RT")

name <- colnames(all)

##### EDS #####
#source("function/pairs.panels.R")

#pairs.panels(all)

##### Technical correction #####
#all

##### construct the correlation matrix ######
all.pearson <- cor(all, method = "pearson", use = "pairwise") # pearson correlation

all.spearman <- cor(all, method = "spearman", use = "pairwise") # spearman correlation

all.kendall <- cor(all, method = "kendall", use = "pairwise")# kendall correlation

all.biweight <- bicor(all, use = "pairwise") # Biweight Midcorrelation from WGCNA package


#===========================================
##### Transform the correlation matrix #####
#============================================

# change from matrix to data frame, and extract the value of each correlation approach

### Peason correlation
df.pearson <- as.data.frame(all.pearson)
df.pearson.corval <- df.pearson[1]
colnames(df.pearson.corval) <- "Pearson"

### Spearman correlation

df.spear <- as.data.frame(all.spearman)
df.spear.corval <- df.spear[1]
colnames(df.spear.corval) <- "Spearman"

### Kendall correlation

df.kendall <- as.data.frame(all.kendall)
df.kendall.corval <- df.kendall[1]
colnames(df.kendall.corval) <- "Kendall"

### Biweight Midcorrelation
df.biweight <- as.data.frame(all.biweight)
df.biweight.cor.val <- df.biweight[1]
colnames(df.biweight.cor.val) <- "Biweight"


##### network graph #####
InsectInjuiry <- 1:13
Disease <- 14:29

injuries <- list( InsectInjuiry ,Disease)

diag(all.spearman) <- 0
q.spearman <- qgraph(
        all.spearman, 
        layout = "spring", 
        threshold = 0.20,
        #cut = 0.3,
        maximum = 1,
        #sampleSize = nrow(all),
        #minimum = "sig", 
        groups = injuries, 
        color = c("skyblue", "wheat"),
        vsize = 5, 
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        # bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)

#clusteringPlot(q.spearman)

clusZ.sp <- clustZhang(q.spearman)
clusZ.sp <- cbind(node = rownames(clusZ.sp), clusZ.sp)
row.names(clusZ.sp) <- NULL
clusZ.sp %>% ggplot( aes(x= clustZhang, y = reorder(node, clustZhang))) + geom_point() + xlab("clustering coefficient") + ylab("Variables") + ggtitle("Clusering coefficient  \nin wet netwotk")


cen <- centrality_auto(q.spearman)
clus <- clustcoef_auto(q.spearman)

topo <- cen$node.centrality
topo$node <- row.names(topo)
row.names(topo) <- NULL
topo.melt <- melt(topo)
topo %>% ggplot(aes(x= Betweenness, y = reorder(node, Betweenness))) + 
        geom_point(size = 3, color ="blue") +
        theme_bw() +
        theme(panel.grid.major.x =  element_blank(),
              panel.grid.minor.x =  element_blank(),
              panel.grid.major.y = element_line(color = "grey", linetype = 3))


topo %>% ggplot(aes(x= Strength, y = reorder(node, Strength))) + geom_point() 


#+ xlab("clustering coefficient") + ylab("Variables") + ggtitle("Clusering coefficient  \nin wet netwotk")
