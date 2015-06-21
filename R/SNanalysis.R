# Single network construction -------

# load library-----
library(WGCNA)
library(qgraph)
library(igraph)
library(RColorBrewer)

# loading data ----
load(file = "output/clean.single.data.RData") # will return data

names(data)
# select out 
data$pc <- NULL # exclude previous crop
data$cem <- NULL # exclude crop establisment
data$ast <- NULL # exclude age of seedling at transplating
data$ccd <- NULL # exclude ccd
data$vartype <- NULL # exclude vartype
data$fym <- NULL # exclude fym

# exclude crop growth
data$ntmax <- NULL # exclude number of tiller (max)
data$npmax <- NULL # exclude number of panicles (max)
data$ntmax <- NULL # exclude number of tiller (max)
data$npmax <- NULL # exclude number of panicles (max)
data$nltmax <- NULL # exclude number of leave per tiller (max)
data$nlhmax <- NULL # exclude number of leave per hill ( maximum)
data$cs <- NULL # exclude crop status

# group the 
#names(data)
# create the lists of cropping practices and injuiry profiles 
cluster.mem <- list(CropManagement <- c(1:11), # cropping practices
                     InjProfile <- c(12:42) # injury profiles
                    )



# correlation adjacency matrix contruction -----
# Pearson correlation matrix
ps.cor <- cor(data, method = "pearson", use = "pairwise") # pearson correlation


# Spearman correlation matrix
sm.cor <- cor(data, method = "spearman", use = "pairwise") # spearman correlation


# Kandell correlation matrix
kd.cor <- cor(data, method = "kendall", use = "pairwise")# kendall correlation


# Biweight midcorrelaiton matrix
bw.cor <- bicor(data, use = "pairwise") # Biweight Midcorrelation from WGCNA package


# Network model contruction -----

#qgraph(sm.cor, layout = "spring") # this graph will be include all the sprea correlation coefficent

#L <- averageLayout(sm.cor, ps.cor, kd.cor, bw.cor)
#layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
sm.q <- qgraph(sm.cor, 
        #layout = L,           
       layout = "spring",
       #layout = "circle",
       #----addtional options for correlation matric
       threshold = "bonferroni", # "bonferroni"
       #cut = 0.3,
       maximum = 1,
       minimum = "sig",
       sampleSize = nrow(data),
       diag = FALSE, # set not shown diagonal or loop edge 
       #vsize = c(1.5, 10),
       vsize = 5, # set size of vertices
       line = 3, # set the thinckness of edges
      # groups = cluster.mem, 
      # color = c("khaki3" , "seagreen3"),
       posCol = "cornflowerblue", 
       negCol = "lightcoral",
      # curveAll = TRUE,
       borders = FALSE,
       legend = FALSE,
       vTrans = 200,
       bonf = TRUE,
       legend.mode = "group",
       #filetype = "jpg",
       #filename = "figs/SingNet",
       title = "Spearman"
)

 qgraph(ps.cor,
                   layout = L,  
                   #layout = "spring",
                   #layout = "circle",
                   #----addtional options for correlation matric
                   threshold = "bonferroni", # "bonferroni"
                   #cut = 0.3,
                   maximum = 1,
                   minimum = "sig",
                   sampleSize = nrow(data),
                   diag = FALSE, # set not shown diagonal or loop edge 
                   vsize = c(1.5, 10),
                   #vsize = 5, # set size of vertices
                   line = 3, # set the thinckness of edges
                   groups = cluster.mem, 
                   color = c("khaki3" ,"skyblue", "seagreen3"),
                   posCol = "cornflowerblue", 
                   negCol = "lightcoral",
                   # curveAll = TRUE,
                   borders = FALSE,
                   legend = FALSE,
                   vTrans = 200,
                   bonf = TRUE,
                   legend.mode = "group",
                   #filetype = "jpg",
                   #filename = "figs/SingNet",
                   title = "Pearson"
)

 qgraph(kd.cor,
                   layout = L,  
                   #layout = "spring",
                   #layout = "circle",
                   #----addtional options for correlation matric
                   threshold = "bonferroni", # "bonferroni"
                   #cut = 0.3,
                   maximum = 1,
                   minimum = "sig",
                   sampleSize = nrow(data),
                   diag = FALSE, # set not shown diagonal or loop edge 
                   vsize = c(1.5, 10),
                   #vsize = 5, # set size of vertices
                   line = 3, # set the thinckness of edges
                   groups = cluster.mem, 
                   color = c("khaki3" ,"skyblue", "seagreen3"),
                   posCol = "cornflowerblue", 
                   negCol = "lightcoral",
                   # curveAll = TRUE,
                   borders = FALSE,
                   legend = FALSE,
                   vTrans = 200,
                   bonf = TRUE,
                   legend.mode = "group",
                   #filetype = "jpg",
                   #filename = "figs/SingNet",
                   title = "Kandell"
)

qgraph(bw.cor,
                   layout = L,  
                   #layout = "spring",
                   #layout = "circle",
                   #----addtional options for correlation matric
                   threshold = "bonferroni", # "bonferroni"
                   #cut = 0.3,
                   maximum = 1,
                   minimum = "sig",
                   sampleSize = nrow(data),
                   diag = FALSE, # set not shown diagonal or loop edge 
                   vsize = c(1.5, 10),
                   #vsize = 5, # set size of vertices
                   line = 3, # set the thinckness of edges
                   groups = cluster.mem, 
                   color = c("khaki3" ,"skyblue", "seagreen3"),
                   posCol = "cornflowerblue", 
                   negCol = "lightcoral",
                   # curveAll = TRUE,
                   borders = FALSE,
                   legend = FALSE,
                   vTrans = 200,
                   bonf = TRUE,
                   legend.mode = "group",
                   #filetype = "jpg",
                   #filename = "figs/SingNet",
                   title = "Biweight"
)


qgraphMixed(sm.cor, sm.cor,  
            #layout = "spring",
            #layout = "circle",
            #----addtional options for correlation matric
            threshold = "bonferroni", # "bonferroni"
            #cut = 0.3,
            maximum = 1,
            minimum = "sig",
            #sampleSize = nrow(data),
            diag = FALSE, # set not shown diagonal or loop edge 
            vsize = c(1.5, 10),
            #vsize = 5, # set size of vertices
            line = 3, # set the thinckness of edges
            #groups = cluster.mem, 
            #color = c("khaki3" ,"skyblue", "seagreen3"),
            posCol = "cornflowerblue", 
            negCol = "lightcoral",
            # curveAll = TRUE,
            borders = FALSE,
            legend = FALSE,
            vTrans = 200,
            bonf = TRUE,
            legend.mode = "group",
            #filetype = "jpg",
            #filename = "figs/SingNet",
            title = "Biweight"
            )
