# Single network construction -------

# load library-----
library(WGCNA)
library(qgraph)
library(igraph)
library(RColorBrewer)

# loading data ----
load(file = "output/single.data.RData")

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

# create the lists of cropping practices and injuiry profiles 
cluster.mem <- list( one <- c(23:53), # injuiry profiles
                     two <- c(1:14), # cropping practices
                     three <- c(15:22) #plant profiles
                        )


#qgraph(sm.cor, layout = "spring") # this graph will be include all the sprea correlation coefficent

#L <- averageLayout(sm.cor, ps.cor, kd.cor, bw.cor)
#layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
qgraph(sm.cor, 
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
