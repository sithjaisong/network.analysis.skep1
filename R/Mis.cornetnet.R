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
library(energy)
library(MASS)
library(mblm)
library(minerva)
library(vegan)
library(Hmisc)
library(WGCNA)
library(corrplot)
library(qgraph)
library(corrgram)
library(RColorBrewer)
library(pheatmap)
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

#all.hoeffd <- ifelse(hoeffd(data.matrix(all))$P <= 0.05, hoeffd(data.matrix(all))$D, 0)
#diag(all.hoeffd) <- 1        
#dcor(all) # this distence correlation is not succesful 
#all.MIC <-  mine(all, ncores = 3)$MIC # Maximal Information Coefficient
#all.MI <- mutualInfoAdjacency(all)$AdjacencyUniversalVersion1

#### similarity and dissimilarity
#eucladiant
#Kullback–Leibler
#Bray–Curtis
#source("function/cor.mtest.R")
#res1 <- cor.mtest(all, 0.95)
#corrplot(all.pearson, p.mat = res1[[1]], sig.level = 0.05)

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

### Hoeffd correlation
# df.hoeffd <- as.data.frame(all.hoeffd)
# df.hoeffd.cor.val <- df.hoeffd[1]
# colnames(df.hoeffd.cor.val) <- "hoeffd"

### MIC maximum information coeficient
# df.MIC <- as.data.frame(all.MIC)
# df.MIC.cor.val <- df.MIC[1]
# colnames(df.MIC.cor.val) <- "MIC"

### MI mutual information coeficient
# df.MI <- as.data.frame(all.MI)
# df.MI.cor.val <- df.MIC[1]
# colnames(df.MI.cor.val) <- "MI"


#===================================================
# Check the distribution of the correlation in the correlation matrix
#
#===================================================

#We do not neet the 1 in correlation matrix
remove <- 1
vCorPear <- as.vector(all.pearson)
noO <-vCorPear[!vCorPear %in% 1]
histogram(noO)
# Pearson's correlation coefficents of survey data are around tendding on the negative values.
histogram(as.vector(all.spearman))
# the distribution of correlation coefficients are scatttered around the -5 to 5 

#====================================================
##### Combine correlation value of each method ######
#===================================================
# will add more correlation
bind.cor <- cbind(df.pearson.corval,
                  df.spear.corval,
                  df.kendall.corval,
                  df.biweight.cor.val
                  #df.hoeffd.cor.val,
                  #df.MIC.cor.val,
                  #df.MI.cor.val
                  )

##### Cluster Analysis and correlation matrix #####
cor.of.cor <- cor(bind.cor)
pheatmap(cor.of.cor, cellwidth = 50, cellheight = 50, fontsize = 16,
, filename = "figs/heatmapcorofcor1.png")

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
                     #threshold = 0.20,
                     cut = 0.3,
                     #maximum = 1,
                     sampleSize = nrow(all),
                     minimum = "sig", 
                     #groups = injuries, 
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


cluster.mem <- list( one <- c(6,9,10, 11,15, 16, 26, 27, 28, 29),
                     two <- c(1,2,5,8,11,12,13,21))

 qgraph(
        all.spearman, 
        layout = "spring", 
        threshold = 0.20,
        cut = 0.3,
        maximum = 1,
        sampleSize = nrow(all),
        minimum = "sig", 
        groups = cluster.mem, 
        color = c("skyblue", "wheat", "red"),
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

centralityPlot(all.spearman)
clusteringPlot(all.spearman)
powers <- c(c(1:10), seq(from = 12, to=20 , by =2))
sft <- pickSoftThreshold(all, powerVector = powers)

# q.hoeffd <- qgraph(all.hoeffd, layout = "spring")
# 
# q.MI <- qgraph(all.MI, layout = "spring")
# 
# q.MIC <- qgraph(all.MIC)

#spearman_FDR <- FDRnetwork(all.spearman, method = "qval")

#q.spearman <- qgraph(spearman_FDR)
dev.off()

#=============================
##### Network comparison #####
#============================

# Pearson Network

str.table.pearson <- centralityTable(q.pearson) %>% filter(variable == "Strength") %>% select(node, value) %>% rename(pearson = value)

# Spearman Network

str.table.spearman <- centralityTable(q.spearman) %>% filter(variable == "Strength") %>% select(node, value) %>% rename(spearman = value)

# Kendall Network
str.table.kendall <- centralityTable(q.kendall) %>% filter(variable == "Strength") %>% select(node, value) %>% rename(kendall = value)

### heatmap correlation of Strength of each network
t.list <- list(str.table.pearson,
               str.table.spearman,
               str.table.kendall)

str.table.bind <- merge_recurse(t.list)

## Cluster Analysis and correlation matrix ##
cor.of.str.net <- cor(str.table.bind[-1])
ccc <- brewer.pal(3,"RdYlBu")
#heatmap(as.matrix(bind.cor)) # cluster 
heatmap(cor.of.str.net, col = cc, symm = TRUE)

#ND.hoeff.net <- fundamentalNetworkConcepts(all.hoeffd)$Connectivity

#plot(all$dpx,all$bsa) 
dev.off()

head(all)
lo
#### Check correlation line on the xy plot #####

WBP <- all$WBP
BPH <- all$BPH
DF <- data.frame(WBP, BPH)

#DF <- DF %>% filter(BLB >0  & BLS >0)
cor.test(DF$BPH, DF$WBP, method = "pearson")

lin <- ggplot(DF,aes(x = WBP, y = BPH)) +geom_point() #+ coord_trans(xtrans = "log10", ytrans = "log10") # + scale_x_log10() + scale_y_log10()
lin
lin +stat_smooth()
lin  + stat_smooth(method = "lm", formula = y ~ x, size = 1)
lin + stat_smooth(method = "loess", formula = y ~ x, size = 1)
lin + stat_smooth(method = "lm", formula = y ~ x + I(x^2), size = 1)
lin + stat_smooth(method = "lm", formula = y ~ poly(x, 2), size = 1)
lin + stat_smooth(method = "gam", formula = y ~ s(x), size = 1)

#lin + stat_smooth(method = 'nls', formula = 'y~a*x^b', start = list(a = 1,b=1)) + geom_text(x = 600, y = 1, label = power_eqn(DF), parse = TRUE)

power_eqn = function(df, start = list(a =300,b=1)){
        m = nls(WM ~ a*BLB^b, start = start, data = df);
        eq <- substitute(italic(y) == a  ~italic(x)^b, 
                         list(a = format(coef(m)[1], digits = 2), 
                              b = format(coef(m)[2], digits = 2)))
        as.character(as.expression(eq));                 
}


lin <- ggplot(DF,aes(BLB, WM)) +geom_point()+
        geom_smooth(method = "lm")
glin <- lin + geom_smooth(method = "glm",
                          family = gaussian(link="log"))


#========================================================

NBS <- all$nbs
FSM <- all$fsm
DF2 <- data.frame(NBS, FSM)

DF2 <- DF2 %>% filter( NBS > 0 )

lin <- ggplot(DF2,aes(NBS, FSM)) +geom_point()+
        geom_smooth(method = "lm")
glin <- lin + geom_smooth(method = "glm")
glin


#===================================
DH <- all$dhx
FSM <- all$fsm
DF3 <- data.frame(DH, FSM)

DF3 <- DF3 %>% filter( FSM > 0 & DH >0)

 ggplot(DF3,aes(DH, FSM)) +geom_point()+
        geom_smooth()
glin <- lin + geom_smooth(method = "glm")
glin
