# generate the network model for the season


load(file = 'output/4-select.split.RData')
data <- OutputProfile

#-- Wet season
ws <- data %>% 
        filter(season == "WS") %>%
        select(-c(country, season))

ws <- ws[, apply(ws, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ws<- ws[complete.cases(ws),] # exclude row which cantain NA

ws.spear.cor <- cor(ws, method = "spearman")

q3<- qgraph(ws.spear.cor,
            sampleSize = nrow(ws),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = TRUE,
            #------ node
            vsize = c(1.5,8),
            #------edge
            borders = FALSE,
            vTrans = 200,
            edge.labels = TRUE,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Wet season",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.ws'
            )

#----------------------------Dry season---------------------

ds <- data %>% 
        filter(season == "DS") %>%
        select(-c(country, season))

ds <- ds[, apply(ds, 2, var, na.rm = TRUE) != 0] # exclude the column with variation = 0

ds<- ds[complete.cases(ds),] # exclude row which cantain NA

ds.spear.cor <- cor(ds, method = "spearman")

q4<- qgraph(ds.spear.cor,
            sampleSize = nrow(ds),
            graph = 'assosciation',
            minimum = "sig",
            maximum = 1,
            # cut = 0.3 ,
            # threshold = "locfdr",
            bonf = T,
            #------ node
            vsize = c(1.5,6),
            #------edge
            borders=T,
            #vTrans=200,
            edge.labels = T,
            edge.label.cex = 0.5,
            layout = "spring",
            title = "Spearman's correlation based Network with bonf correction in Dry season",
            filetype = 'pdf',
            filename ='figs/qgraph.spear.ds'
            )
