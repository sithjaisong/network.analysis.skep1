########################Header################################################
#'title         : B-InputProfile_network
# purpose       : network model: Input Profile (farmer's practices);
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 4-InputProfile.RData;
# outputs       : ;
# remarks 1     : ;
# remarks 2     : ;
#####################################################
#### Load Library ####
library(WGCNA)
library(qgraph)
#### End od loading libraries ####

##### Load data #####
load(file = 'output/4-InputProfile.RData')
data <- InputProfile
#data$pc <- as.factor(data$pc)
#data$vartype <- as.factor(data$vartype)
#data$fym <- as.factor(data$fym)
##### End of load data #####

##### mutualInfoAdj function #####
MIadj <- mutualInfoAdjacency(datE = data)
##### end of mutual #####

##### visualize mutual adj #####
L <- averageLayout(MIadj[[2]], MIadj[[3]], MIadj[[4]], MIadj[[5]])
layout(matrix(c(1,2,3,4), 2,2, byrow = TRUE))
qgraph(MIadj[[2]],layout = L)
qgraph(MIadj[[3]],layout = L)
qgraph(MIadj[[4]],layout = L)
qgraph(MIadj[[5]],layout = L)
##### end of visualize mutual adj #####
