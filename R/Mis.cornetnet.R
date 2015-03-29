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
library(energy)
library(MASS)
library(mblm)
library(minerva)
library(vegan)
library(Hmisc)
library(WGCNA)
library(corrplot)
library(qgraph)

#---- Set working directory ----
# set your working directory
wd <- '~/Documents/R.github/network.analysis.skep1'  # for Mac
# wd <- '' # for window

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

##### Technical correction #####
all

##### construct the correlation matrix ######
all.pearson <- cor(all, method = "pearson", use = "pairwise") # pearson correlation
all.spearman <- cor(all, method = "spearman", use = "pairwise") # spearman correlation
all.kendall <- cor(all, method = "kendall", use = "pairwise")# kendall correlation
all.biweight <- bicor(all, use = "pairwise") # Biweight Midcorrelation from WGCNA package
all.hoeffd <- ifelse(hoeffd(data.matrix(all))$P <= 0.05, hoeffd(data.matrix(all))$D, 0)
diag(all.hoeffd) <- 1        
#dcor(all) # this distence correlation is not succesful 
all.MIC <-  mine(all, ncores = 3)$MIC # Maximal Information Coefficient
all.MI <- mutualInfoAdjacency(all)$AdjacencyUniversalVersion1

#### similarity and dissimilarity
#eucladiant
#Kullback–Leibler
#Bray–Curtis

##### Transform the correlation matrix #####
# change from matrix to data frame, and extract the value of each correlation approach

### Peason correlation
df.pearson <- as.data.frame(all.pearson)
df.pearson.corval <- df.pearson[1]
colnames(df.pearson.corval) <- "pearson"

### Spearman correlation

df.spear <- as.data.frame(all.spearman)
df.spear.corval <- df.spear[1]
colnames(df.spear.corval) <- "spear"

### Kendall correlation

df.kendall <- as.data.frame(all.kendall)
df.kendall.corval <- df.kendall[1]
colnames(df.kendall.corval) <- "kendall"

### Biweight Midcorrelation
df.biweight <- as.data.frame(all.biweight)
df.biweight.cor.val <- df.biweight[1]
colnames(df.biweight.cor.val) <- "biweight"

### Hoeffd correlation
df.hoeffd <- as.data.frame(all.hoeffd)
df.hoeffd.cor.val <- df.hoeffd[1]
colnames(df.hoeffd.cor.val) <- "hoeffd"

### MIC maximum information coeficient
df.MIC <- as.data.frame(all.MIC)
df.MIC.cor.val <- df.MIC[1]
colnames(df.MIC.cor.val) <- "MIC"

### MI mutual information coeficient
df.MI <- as.data.frame(all.MI)
df.MI.cor.val <- df.MIC[1]
colnames(df.MI.cor.val) <- "MI"


#====================================================
##### Combine correlation value of each method ######
#===================================================
# will add more correlation
bind.cor <- cbind(df.pearson.corval,
                  df.spear.corval,
                  df.kendall.corval,
                  df.biweight.cor.val,
                  df.hoeffd.cor.val,
                  df.MIC.cor.val,
                  df.MI.cor.val)


##### Cluster Analysis and correlation matrix #####
cor.of.cor <- cor(bind.cor)
cc <- brewer.pal(6,"RdYlBu")
#heatmap(as.matrix(bind.cor)) # cluster 
heatmap(cor.of.cor, col = cc, symm = TRUE)

##### network graph #####

L <- averageLayout(all.pearson, all.spearman, all.kendall,all.hoeffd)

layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

q.pearson <- qgraph(all.pearson, sampleSize = nrow(all),
                    minimum = "sig",
                    bonf = TRUE)
q.spearman <- qgraph(all.spearman, sampleSize = nrow(all),
                    minimum = "sig",
                    bonf = TRUE)

q.kendall <- qgraph(all.kendall, sampleSize = nrow(all),
                     minimum = "sig",
                     bonf = TRUE)

q.hoeffd <- qgraph(all.hoeffd)

#spearman_FDR <- FDRnetwork(all.spearman, method = "qval")

#q.spearman <- qgraph(spearman_FDR)

#=============================
##### Network comparison #####
#============================

# Pearson Network
str.table.pearson <- centralityTable(q.pearson) %>% filter(measure == "Strength") %>% select(node, value) %>% rename(pearson = value)

# Spearman Network

str.table.spearman <- centralityTable(q.spearman) %>% filter(measure == "Strength") %>% select(node, value) %>% rename(spearman = value)

# Kendall Network
str.table.kendall <- centralityTable(q.kendall) %>% filter(measure == "Strength") %>% select(node, value) %>% rename(kendall = value)

### heatmap correlation of Strength of each network
str.table.bind <- merge(str.table.pearson,
                  str.table.spearman,
                  str.table.kendall
                  )

## Cluster Analysis and correlation matrix ##
cor.of.str.net <- cor(str.table.bind)
ccc <- brewer.pal(3,"RdYlBu")
#heatmap(as.matrix(bind.cor)) # cluster 
heatmap(cor.of.cor, col = cc, symm = TRUE)

#ND.hoeff.net <- fundamentalNetworkConcepts(all.hoeffd)$Connectivity

#plot(all$dpx,all$bsa) 
dev.off()
