###Load libraries ####
require(dplyr)
require(ggplot2)
require(gridExtra)
require(pheatmap)
require(plyr)
require(htmlwidgets)
require(igraph)
require(lattice)
library(lubridate)
require(psych)
require(qgraph)
require(reshape)
require(reshape2)
require(RColorBrewer)
require(WGCNA)

#### Set working directory and filepath ####
#wd <- "~/Documents/R.github/network.analysis.skep1" 
wd <- 'C:/Users/sjaisong/Documents/GitHub/network.analysis.skep1'
setwd(wd)

#Filepath <- "~/Google Drive/1.SKEP1/SKEP1survey.xls" for mac users
Filepath <- "E:/Google Drive/Data/SYT-SKEP/Survey/SKEP1survey.csv" # for window users

data <- read.csv(Filepath)

names(data) <- tolower(names(data))

describe(data)

#### Delete the unnessary variables variables without data (NA) ####
#### Keep only the cropping practices and injury profiles #####

data$phase <- NULL # there is only one type yype of phase in the survey
data$identifier <- NULL # this variable is not included in the analysis
data$village <- NULL
data$fa <- NULL # field area is not include in the analysis
data$fn <- NULL # farmer name can not be included in this survey analysis
data$fp <- NULL # I do not know what is fp
data$lfm <- NULL # there is only one type of land form in this survey
data$ced <- NULL # Date data can not be included in the network analysis
data$cedjul <- NULL
data$hd <- NULL # Date data can not be included in the network analysis
data$hdjul <- NULL
data$cvr <- NULL
data$varcoded <- NULL # I will recode them 
data$fym.coded <- NULL
data$mu <- NULL # no record
data$nplsqm <- NULL
data$fno <- NULL
data$country <- NULL
data$year <- NULL
data$season <- NULL
data$lat <- NULL
data$long <- NULL
data$pc <- NULL
data$ast <- NULL
data$ccd <- NULL
data$vartype <- NULL
data$fym <-NULL
data$fymcoded <-NULL
## remove the plant info
data$yield <- NULL
data$cs <- NULL
data$dscum <- NULL
data$wecum <- NULL
data$ntmax <- NULL
data$nltmax <- NULL
data$npmax <- NULL
data$nlhmax <- NULL
data$cem <- NULL
# no data
data$lm <- NULL
data$rh <- NULL
data$thr <- NULL
data$pm <- NULL
####end of remove non cropping practice and injury profiles

data <- transform(data, 
                  n = as.numeric(n),
                  p = as.numeric(p) ,
                  k = as.numeric(k),
                  mf = as.numeric(mf),        
                  wcp = as.factor(wcp),      
                  iu = as.numeric(iu),     
                  hu = as.numeric(hu),      
                  fu = as.numeric(fu),      
                  ldg  =  as.numeric(ldg),  
                  waa = as.numeric(waa),      
                  wba = as.numeric(wba) ,   
                  dhx =  as.numeric(dhx),  
                  whx =  as.numeric(whx),     
                  ssx  = as.numeric(ssx),  
                  wma = as.numeric(wma), 
                  lfa = as.numeric(lfa),
                  lma = as.numeric(lma),   
                  rha  = as.numeric(rha) ,
                  thrx = as.numeric(thrx),    
                  pmx = as.numeric(pmx),    
                  defa  = as.numeric(defa) ,
                  bphx = as.numeric(bphx),   
                  wbpx = as.numeric(wbpx),    
                  awx  = as.numeric(awx), 
                  rbx =as.numeric(rbx),   
                  rbbx = as.numeric(rbbx),  
                  glhx  = as.numeric(glhx), 
                  stbx=as.numeric(stbx),    
                  rbpx = as.numeric(rbpx), 
                  hbx= as.numeric(hbx),
                  bbx = as.numeric(bbx),    
                  blba = as.numeric(blba),    
                  lba = as.numeric(lba),    
                  bsa = as.numeric(bsa),    
                  blsa = as.numeric(blsa),  
                  nbsa = as.numeric(nbsa),  
                  rsa  = as.numeric(rsa),   
                  lsa = as.numeric(lsa),    
                  shbx = as.numeric(shbx) ,  
                  shrx = as.numeric(shrx),    
                  srx= as.numeric(srx),    
                  fsmx = as.numeric(fsmx),   
                  nbx =  as.numeric(nbx),   
                  dpx = as.numeric(dpx),    
                  rtdx  = as.numeric(rtdx),  
                  rsdx  = as.numeric(rsdx),
                  gsdx  =as.numeric(gsdx),   
                  rtx = as.numeric(rtx)
) 


levels(data$wcp)[levels(data$wcp) == "hand"] <- 1
levels(data$wcp)[levels(data$wcp) == "herb"] <- 2
levels(data$wcp)[levels(data$wcp) == "herb-hand"] <- 3

data$wcp <- as.numeric(as.factor(data$wcp))

######### Drow the histrogram #####
# m.data <- melt(data)
# varnames <- colnames(data)
# i <- 1
# out <- NULL
# for(i in 1:length(varnames)) {
#         gdata <- m.data %>% filter(variable == varnames[i])
#         p <- ggplot(gdata, aes(x = value)) + 
#                 geom_histogram(stat = "bin") + ggtitle(paste("Histogram of", varnames[i], sep = " "))
#         dev.new()
#         print(p) 
#         out[[i]] <- p
# }
# 
# grid.arrange(out[[1]],
#              out[[2]],
#              out[[3]],
#              out[[4]],
#              out[[5]],
#              out[[6]],
#              out[[7]],
#              out[[8]],
#              out[[9]],
#              out[[10]],
#              out[[11]],
#              out[[12]],
#              out[[13]],
#              out[[14]],
#              out[[15]],
#              out[[16]],
#              out[[17]],
#              out[[18]],
#              out[[19]],
#              out[[20]],
#              out[[21]],
#              out[[22]],
#              out[[23]],
#              out[[24]],
#              out[[25]],
#              out[[26]],
#              out[[26]],
#              out[[28]],
#              out[[29]],
#              out[[30]],
#              out[[31]],
#              out[[32]],
#              out[[33]],
#              out[[34]],
#              out[[35]],
#              out[[36]],
#              out[[37]],
#              out[[38]],
#              out[[39]],
#              out[[40]],
#              out[[41]],
#              out[[42]],
#              out[[43]],
#              out[[44]],
#              out[[45]],
#              out[[46]],
#              out[[47]],
#              out[[48]],
#              out[[49]],
#              nrow = 10
# )


abbre <- c("CEM","N", "P", "K", "MF", "WCP", "IU", "HU", "FU", "LDG", "WA", "WB" ,"DH", "WH", "SS", "WM", "LF", "DEF", "BPH", "WPH", "AM", "RB", "RBB", "GLH", "STB","RBP","HB","BB", "BLB",  "LB", "BS", "BLS", "NBS", "RS", "LS", "SHB", "SHR", "SR", "FSM", "NB", "DP", "RTD", "RSD","GSD", "RT")
names(data) <-abbre


pearson <- cor(data, method = "pearson", use = "pairwise.complete.obs") # pearson correlation

spearman <- cor(data, method = "spearman", use = "pairwise.complete.obs") # spearman correlation

kendall <- cor(data, method = "kendall", use = "pairwise.complete.obs")# kendall correlation

biweight <- bicor(data, use = "pairwise.complete.obs") # Biweight Midcorrelation from WGCNA package


### Peason correlation
df.pearson <- as.data.frame(pearson)
df.pearson.corval <- df.pearson[1]
colnames(df.pearson.corval) <- "Pearson"

### Spearman correlation

df.spear <- as.data.frame(spearman)
df.spear.corval <- df.spear[1]
colnames(df.spear.corval) <- "Spearman"

### Kendall correlation

df.kendall <- as.data.frame(kendall)
df.kendall.corval <- df.kendall[1]
colnames(df.kendall.corval) <- "Kendall"

### Biweight Midcorrelation
df.biweight <- as.data.frame(biweight)
df.biweight.cor.val <- df.biweight[1]
colnames(df.biweight.cor.val) <- "Biweight"

#====================================================
##### Combine correlation value of each method ######
#===================================================
# will add more correlation
bind.cor <- cbind(df.pearson.corval,
                  df.spear.corval,
                  df.kendall.corval,
                  df.biweight.cor.val)

##### Cluster Analysis and correlation matrix #####
cor.of.cor <- cor(bind.cor)
pheatmap(cor.of.cor, cellwidth = 50, cellheight = 50, fontsize = 16)

# from here the heat map and dendrogram showing that non-ranking measure and ranking measure still different in the outputs.



##### network graph #####
cropping <- 1:9
injuries <- 10:45

groups_info <- list(cropping, injuries)

diag(spearman) <- 0

q.spearman <- qgraph(
        spearman, 
        layout = "spring", 
        threshold = 0.20,
        #cut = 0.3,
        maximum = 1,
        #sampleSize = nrow(data),
        #minimum = "sig", 
        groups = groups_info, 
        color = c("skyblue", "wheat"),
        vsize = 5, 
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)

c.spearman <- qgraph(
        spearman, 
        layout = "circle", 
        threshold = 0.20,
        #cut = 0.3,
        maximum = 1,
        #sampleSize = nrow(data),
        #minimum = "sig", 
        groups = groups_info, 
        color = c("skyblue", "wheat"),
        vsize = c(1.5, 10), # vsiz = c(1.5, 10)
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)

cor_auto(data, missing = "listwise")

describe(data)

c.auto <- qgraph(
        cor_auto(data),
        layout = "circle", 
        threshold = 0.20,
        #cut = 0.3,
        maximum = 1,
        #sampleSize = nrow(data),
        #minimum = "sig", 
        groups = groups_info, 
        color = c("skyblue", "wheat"),
        vsize = c(1.5, 10), # vsiz = c(1.5, 10)
        line = 3,
        posCol = "forestgreen",
        negCol = "firebrick3",
        borders = FALSE,
        legend = FALSE,
        vTrans = 200,
        bonf = TRUE,
        # filetype = "jpg",
        #filename = "figs/APPSnetwork5"
        title = "Spearman"
)
