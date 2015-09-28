# This script is the R script for running test the corelation with the Spearman correlation for both the cropping practice and crop injuires in differenct production environments.

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
require(XLConnect)

#### Set working directory and filepath ####
#wd <- 'C:/Users/sjaisong/Documents/GitHub/network.analysis.skep1' 
wd <- "~/Documents/Github/network.analysis.skep1" # for Mac
setwd(wd)

#### Loading the survey data #####
Filepath <- "~/Google Drive/1.SKEP1/SKEP1survey.xls" # for mac users
#Filepath <- "E:/Google Drive/Data/SYT-SKEP/Survey/SKEP1survey.csv" # for window users
data <- readWorksheetFromFile(Filepath, sheet = 1) # use the XLCOnnect package
#str(data)

# change the names of variables
names(data) <- tolower(names(data))

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
# data$country <- NULL
data$year <- NULL
#data$season <- NULL
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

########================ Use Vietnam data ============####
vnm.ds <- data %>% filter(country == "VNM" & season == "DS")

# correct technically
vnm.ds <- vnm.ds %>%
        select(-c(country, season)) %>%
        transform( n = as.numeric(n),
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

levels(vnm.ds$wcp)[levels(vnm.ds$wcp) == "hand"] <- 1
levels(vnm.ds$wcp)[levels(vnm.ds$wcp) == "herb"] <- 2
levels(vnm.ds$wcp)[levels(vnm.ds$wcp) == "herb-hand"] <- 3

vnm.ds$wcp <- as.numeric(as.factor(vnm.ds$wcp))

describe(vnm.ds)
# check the data properties

#vnm.ds <- vnm.ds[ ,apply(vnm.ds, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

#vnm.ds <- vnm.ds[complete.cases(vnm.ds),] # exclude row which cantain NA

vnm.ds$rbpx <- NULL

######### Drow the histrogram #####
names(vnm.ds)
data <-  vnm.ds
m.data <- melt(data)
varnames <- colnames(data)
i <- 1
out <- NULL
for(i in 1:length(varnames)) {
        gdata <- m.data %>% filter(variable == varnames[i])
        p <- ggplot(gdata, aes(x = value)) + 
                geom_histogram(stat = "bin") + ggtitle(paste("Histogram of", varnames[i], sep = " "))
        dev.new()
        print(p) 
        out[[i]] <- p
}

gdata <- m.data %>% filter(variable == varnames[1])
p <- ggplot(gdata, aes(x = value)) + 
        geom_histogram(stat = "bin") + ggtitle(paste("Histogram of", varnames[1], sep = " "))

grid.arrange(out[[1]],
             out[[2]],
             out[[3]],
             out[[4]],
             out[[5]],
             out[[6]],
             out[[7]],
             out[[8]],
             out[[9]],
             out[[10]],
             out[[11]],
             out[[12]],
             out[[13]],
             out[[14]],
             out[[15]],
             out[[16]],
             out[[17]],
             out[[18]],
             out[[19]],
             out[[20]],
             out[[21]],
             out[[22]],
             out[[23]],
             out[[24]],
             out[[25]],
             out[[26]],
             out[[26]],
             out[[28]],
             out[[29]],
             out[[30]],
             out[[32]],
             out[[33]],
             out[[34]],
             out[[35]],
             out[[36]],
             out[[37]],
             out[[38]],
             out[[39]],
             out[[40]],
             out[[41]],
             out[[42]],
             out[[43]],
             out[[44]],
             out[[45]],
             out[[46]],
             out[[47]],
             nrow = 10
)

# rename the variables
abbre <- c("CEM","N", "P", "K", "MF", "WCP", "IU", "HU", "FU", "LDG", "WA", "WB" ,"DH", "WH", "SS", "WM", "LF", "DEF", "BPH", "WPH", "AM", "RB", "RBB", "GLH", "STB","RBP","HB","BB", "BLB",  "LB", "BS", "BLS", "NBS", "RS", "LS", "SHB", "SHR", "SR", "FSM", "NB", "DP", "RTD", "RSD","GSD", "RT")
names(data) <-abbre

# compute the corr eff based on different corr measures
pearson <- cor(vnm.ds, method = "pearson", use = "pairwise.complete.obs") # pearson correlation

spearman <- cor(vnm.ds, method = "spearman", use = "pairwise.complete.obs") # spearman correlation

kendall <- cor(vnm.ds, method = "kendall", use = "pairwise.complete.obs")# kendall correlation

biweight <- bicor(vnm.ds, use = "pairwise.complete.obs") # Biweight Midcorrelation from WGCNA package

#### Cluster Analysis using Heat map ####
# compare similarity of corr eff from each measure using cluster analysis base on Euclid
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
cor.bind <- cbind(df.pearson.corval,
                  df.spear.corval,
                  df.kendall.corval,
                  df.biweight.cor.val)

##### Cluster Analysis and correlation matrix #####
cor.of.cor <- cor(cor.bind)
pheatmap(cor.of.cor, cellwidth = 50, cellheight = 50, fontsize = 16)

# from here the heat map and dendrogram showing that non-ranking measure and ranking measure still different in the outputs.

##### network graph #####
cropping <- 1:9
injuries <- 10:31
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
