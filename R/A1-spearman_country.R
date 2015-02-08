# network construction in each country
# For the Philippines n = 40
php.select.data <- select.output %>% 
        filter( country == "PHL")
php.select.data <- php.select.data[-c(1:2)]
describe(php.select.data)
c.php.select.data <- php.select.data[complete.cases(php.select.data),]
c.php.select.data <- subset(c.php.select.data, select = -c(rbbx,stbx,rsdx))
php.spear.cor <- cor(c.php.select.data[-1], method = "spearman")
q5<- qgraph(php.spear.cor,
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
            title = "Spearman's correlation based Network with bonf correction in Philippines")

# For India 
ind.select.data <- select.output %>% 
        filter( country == "IND")

ind.select.data <- ind.select.data[-c(1:2)]
describe(ind.select.data)
#c.ind.select.data <- ind.select.data[complete.cases(ind.select.data),]
ind.select.data <- subset(ind.select.data, select = -c(ssx,awx,stbx,bsa,blsa,nbsa,rsa,lsa,shrx,srx,dpx,rtdx,rsdx))
ind.spear.cor <- cor(ind.select.data[-1], method = "spearman")
q6<- qgraph(ind.spear.cor,
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
            title = "Spearman's correlation based Network with bonf correction in India")





# For Indonesia
idn.select.data <- select.output %>% 
        filter( country == "IDN")

idn.select.data <- idn.select.data[-c(1:2)]
describe(idn.select.data)
idn.select.data <- idn.select.data[complete.cases(idn.select.data),]
#idn.select.data <- subset(idn.select.data, select = -c(ssx,awx,stbx,bsa,blsa,nbsa,rsa,lsa,shrx,srx,dpx,rtdx,rsdx))
idn.spear.cor <- cor(idn.select.data[-1], method = "spearman")
q7<- qgraph(idn.spear.cor,
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
            title = "Spearman's correlation based Network with bonf correction in Indonesia")


# For Thailand
tha.select.data <- select.output %>% 
        filter( country == "THA")

tha.select.data <- tha.select.data[-c(1:2)]
describe(tha.select.data)
tha.select.data <- tha.select.data[complete.cases(tha.select.data),]
tha.select.data <- subset(tha.select.data, select = -c(awx, rbbx, stbx, rtdx, rsdx))
tha.spear.cor <- cor(tha.select.data[-1], method = "spearman")
q8<- qgraph(tha.spear.cor,
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
            title = "Spearman's correlation based Network with bonf correction in Thailand")


# For Vietnam
vnm.select.data <- select.output %>% 
        filter( country == "VNM")

vnm.select.data <- vnm.select.data[-c(1:2)]
describe(vnm.select.data)
vnm.select.data <- vnm.select.data[complete.cases(vnm.select.data),]
vnm.select.data <- subset(vnm.select.data, select = -c(rbbx,stbx))
vnm.spear.cor <- cor(vnm.select.data[-1], method = "spearman")
q9<- qgraph(vnm.spear.cor,
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
            title = "Spearman's correlation based Network with bonf correction in Vietnam")
#---- result
clusterCoef(abs(vnm.spear.cor))

# eos
