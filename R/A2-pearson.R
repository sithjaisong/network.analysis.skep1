###############################################################################
#'title         : Building the Pearson correlation based Network 
#'date          : July, 2014
#'purpose       : Visual the survey data to network model
#'writed by     : Sith Jaisong (s.jaisong@irri.org)
#'contact       : International Rice Research Institute
#'input         : data frame named ds from the previous step (2.cleaning the data.R)
#'output        : Pearson correlation based network 
###############################################################################

library(caret) # find the high correlation
library(corrplot) # visualize the correlation plot
library(fdrtool) # Local False Discovery Rates and Higher Criticism
library(qgraph) # Network construct

######----Correlation matrix-----######
# creat the correlation matrix

cor.test <- cor(selected.data, use = "everything", method = "pearson")

# creat the p-value matirx 
source("pvalue.mat.R")

pvalu <- pval.mat(selected.data, 0.95, method = "pearson") # find the P-value matirx by using Pearson correlation at 0.95  

pvalu <- as.vector(pvalu)

### find the FDL  from fdrtool package

fdr <- fdrtool(pvalu, statistic="pvalue", color.figure=F)

# set the correlation threshold from the estimation from FDR package 

highlyCor <- findCorrelation(cor.test, fdr$param[1]) # cutoff at fdr$param[1]

dat.filted <- selected.data[,-highlyCor]

# Plot corrplot
corrplot(cor(selected.data), order = "hclust", addrect = 5)

###
qgraph(cor(dat.filted), 
       layout = "spring",
       title = "Pearson correlation based Network")
