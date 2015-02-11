########################Header################################################
# title         : Z-1map
# purpose       : plot the coordinates of survey fields;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 3-consistant.output.RData;
# outputs       : png;
# remarks 1     : ;
# remarks 2     : ;
#####################################################

#### Set working directory  ####
# set your working directory
wd = '~/Documents/R.github/network.analysis.skep1' 
setwd(wd)
#### End of set working directory ####

#### Load R.Data file from output folder ####
load(file = "output/3-consistent.output.RData")
#---------------------

# loading the required packages
require(ggplot2)
require(ggmap)

# creating a sample data.frame with your lat/lon points
lon <- data$Long
lat <- data$Lat
df <- as.data.frame(cbind(lon,lat))

# getting the map
mapgilbert <- get_map(location = c(lon = mean(df$lon), 
                                   lat = mean(df$lat)), 
                      zoom = 4,
                      maptype = "satellite", 
                      scale = 2)

# plotting the map with some points on it
ggmap(mapgilbert) +
        geom_point(data = df, 
                   aes(x = lon, y = lat, fill = "red", alpha = 0.8), 
                   size = 2, shape = 21
                   ) + 
        guides(fill=FALSE, 
               alpha=FALSE, 
               size=FALSE
               )

ggsave(filename = "SKEP1_survey_map.png",
       scale =2,
       path = "figs")


