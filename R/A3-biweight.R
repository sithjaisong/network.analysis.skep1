##########################Title###############################################
#'title         : Biweight Midcorrelation correlation based Network 
#'date          : Feb, 2015
#'purpose       : Visual the survey data to network model
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : load from the output file 
#'output        : Pearson correlation based network 
########################End of Title############################################
#---- Read Me First ----
# please check the package wiht bioconduct before 
# if after you download WGCNA package, then it still can not run because it need other package form bioconduct 
#source("http://bioconductor.org/biocLite.R")
#biocLite("preprocessCore")
# if still not working, remove the package and re-download 

#---Load Library ----
library(qgraph) # Network construct
library(WGCNA)
library(flashClust)
options(stringsAsFactors = FALSE) # data frame created after executing that line will not auto-convert to factors
allowWGCNAThreads()

#--- set your working directory----
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#-----Load data from output folder ----
# you should run A1-spearman before 
load(file = "output/A-1spear.all.season.RData")
load(file = "output/A-1spear.country.RData")
# You will have all, ws, ds, php, ind, idn, tha and vnm in your environment

######----Correlation matrix based on Biweight-----######
# Pearson correlation is sensitive to the outliers, so we should delete them before we perform. I prefer to use 
clustaltree <- flashClust(dist(all), method = "average")

plot(clustaltree, 
     main = "Clustering to detect outliers",
     sub="",
     xlab="",
     cex.lab = 1.5,
     cex.axis = 1.5,
     cex.main = 2
)
# The dendrogram shows 
clus <- cutreeStatic(clustaltree, cutHeight = 2750, minSize = NULL)
table(clus) # show the member of group after cut at height = 4000
keep.samples <- clus == 1 # select only group 1, and group 2 is the out-group

all <- all[keep.samples, ] # this data without outlier

#--- Pearson Correaltion Network

all.bicor <- bicor(all)
#all.pearson <- cor(all, method = "pearson", use = "pairwise.complete.obs")
#all.pearson <- cov(all, method = "pearson", use = "pairwise.complete.obs")
q.all.bicor<- qgraph(all.bicor,
                       sampleSize = nrow(all),
                       graph = 'assosciation',
                       minimum = "sig",
                       maximum = 0.6,
                       #cut = 0.1 ,
                       # threshold = "locfdr",
                       bonf = TRUE,
                       #------ node
                       vsize = c(1.5,8),
                       #------edge
                       borders = T,
                       vTrans = 200,
                       edge.labels = TRUE,
                       edge.label.cex = 0.5,
                       layout = "spring",
                       filetype = 'pdf',
                       filename ='figs/qgraph.bicor.all',
                       title = "Biweight correlation based Network with bonf correction in South and South East Asia"
)



