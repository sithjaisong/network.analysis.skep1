# with layout == circle with weighted vertices 

sm.q <- qgraph(sm.cor, 
       #layout = L,           
       layout = "spring",
       graph = "assosciation",
       #layout = "circle",
       weighted = TRUE,
       nNodes = length(names(data)),
       #----addtional options for correlation matric
       threshold = "bonferroni", # "bonferroni"
       #cut = 0.3,
       maximum = 1,
       minimum = "sig",
       sampleSize = nrow(data),
       diag = FALSE, # set not shown diagonal or loop edge 
       vsize = c(1.5, 10),
       #vsize = 3, # set size of vertices
       line = 1, # set the thinckness of edges
       groups = cluster.mem, 
       color = c("khaki3" ,"skyblue", "seagreen3"),
       posCol = "cornflowerblue", 
       negCol = "lightcoral",
      #curve = 0.5,
       #curvePivot = TRUE,
       #curveAll = TRUE,
       borders = FALSE,
       legend = TRUE,
      legend.cex = 0,
       legend.mode = "names",
       curve = TRUE,
       fade = TRUE,
       vTrans = 200,
       bonf = TRUE,
       legend.mode = "group",
       #filetype = "jpg",
       #filename = "figs/SingNet",
       title = "Spearman"
)

smallworldness(sm.q) # compute the small-worldness index 
# the result show that it is not small world network

scaleFreePlot()

sm.i <- as.igraph(sm.q)
plot(sm.i)
hist(degree(sm.i), col = "lightblue", xlim = c(0, 40),
     xlab = "Vertex Degree", ylab = "Frequency", main ="")
hist(graph.strength(sm.i), col = "pink", xlim = c(-3, 3),
     xlab = "Vertex Strength", ylab = "Frequency", main ="")
ecount(sm.i)
vcount(sm.i)
d.sm.i <- degree(sm.i)
dd.sm.i <- degree.distribution(sm.i)
d <- 1:max(d.sm.i) - 1
ind <- (dd.sm.i != 0)
plot(d[ind], dd.sm.i[ind], log="xy", col = "blue",
     xlab = c("Log-Degree"), ylab = c("Log-Internsity"),
     main = "Log-Log Degree Distribution")
sm.layout <- fastgreedy.community(sm.i)
sm.i
