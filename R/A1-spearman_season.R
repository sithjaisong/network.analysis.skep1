# generate the network model for the season
#-- Wet season

load(file = 'output/4-select.split.RData')

data <- OutputProfile

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
            title = "Spearman's correlation based Network with bonf correction in Wet season")

#----------------------------Dry season---------------------
ds.select.data <- select.output %>% 
        filter( season == "DS")

ds.select.data <- ds.select.data[-c(1:2)]

c.ds.select.data <- ds.select.data[complete.cases(ds.select.data),]


c.ds.select.data <- subset( c.ds.select.data, select = -c(rtdx)) # remove the column named stbx

ds.spear.cor <- cor(c.ds.select.data[-1], method = "spearman")


q4<- qgraph(ds.spear.cor,
            sampleSize = nrow(c.select.data),
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
            title = "Spearman's correlation based Network with bonf correction in Dry season")
