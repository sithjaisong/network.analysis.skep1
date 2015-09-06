#======= Loadign the package 
#
library(plyr)
library(dplyr)
library(reshape)
library(reshape2)
library(energy)
library(MASS)
library(mblm)
library(minerva)
library(vegan)
library(Hmisc)
library(WGCNA)
library(igraph)
library(qgraph)
library(RColorBrewer)
# End of loading the library


#---- Set working directory ----
# set your working directory 
#wd <- '~/Documents/R.github/network.analysis.skep1'  # for Mac
wd <- 'C:/Users/sjaisong/Documents/GitHub/network.analysis.skep1' # for window

setwd(wd)
#-----Load data from uptput folder ----

load(file = "output/5-1OutputProfile_subset.RData")
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

all.hoeffd <- ifelse(hoeffd(data.matrix(all))$P <= 0.05, hoeffd(data.matrix(all))$D, 0)

diag(all.hoeffd) <- 1        

dcor(all) # this distence correlation is not succesful 

all.MIC <-  mine(all, ncores = 3)$MIC # Maximal Information Coefficient

all.MI <- mutualInfoAdjacency(all)$AdjacencyUniversalVersion1

#### similarity and dissimilarity
#eucladiant
#KullbackâLeibler
#Brayâ€“Curtis
#source("function/cor.mtest.R")
#res1 <- cor.mtest(all, 0.95)
#corrplot(all.pearson, p.mat = res1[[1]], sig.level = 0.05)

##### network graph #####
InsectInjuiry <- 1:13
Disease <- 14:29

injuries <- list( InsectInjuiry ,Disease)

L <- averageLayout(all.pearson,all.biweight, all.kendall, all.spearman ) #,all.hoeffd, all.MI, all.MIC)

layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
# 
# q.pearson <- qgraph(all.pearson , layout = L, sampleSize = nrow(all),
#                     minimum = "sig",
#                     bonf = TRUE, title = "Pearson")
# q.biweight <- qgraph(all.biweight, layout = L, sampleSize = nrow(all),
#                     minimum = "sig",
#                     bonf = TRUE,  title = "Biweight")
# 
# q.kendall <- qgraph(all.kendall,layout = L,  sampleSize = nrow(all),
#                      minimum = "sig",
#                      bonf = TRUE,  title = "Kendall")

diag(all.spearman) <- 0

q.spearman <- qgraph(
        all.spearman, 
        layout = "spring", 
        threshold = 0.20,
        cut = 0.3,
        maximum = 1,
        sampleSize = nrow(all),
        minimum = "sig", 
        groups = injuries, 
        color = c("skyblue", "wheat"),
        vsize = 5, 
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        #bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)


# I generated the another one namned q.spearman.test
q.spearman.test <- qgraph(
        abs(all.spearman), 
        layout = "spring", 
        threshold = 0.20,
        cut = 0.3,
        maximum = 1,
        sampleSize = nrow(all),
        minimum = "sig", 
        groups = injuries, 
        color = c("skyblue", "wheat"),
        vsize = 5, 
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        #bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)

ig.spearman.test <- as.igraph(q.spearman.test)

wt <- walktrap.community(ig.spearman.test)

modularity(wt)
membership(wt)
fastgreedy.community(ig.spearman)

edge.betweenness.community(ig.spearman)

plot(wt, ig.spearman ,edge.arrow.size=0.01)


diag(all.spearman) <- 0
qgraph(all.spearman)

g <- graph.adjacency(all.spearman, mode = "undirected", weighted= T, diag=F)
g$layout <- layout.fruchterman.reingold
plot(g, edge.arrow.size=0.01)
