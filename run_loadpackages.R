#Multispecies dependent double-observer model 
#Author: Jessie Golding
#7/31/2015

### R code for loading packages needed for MDAM ###

# Install Packages
install.packages("plyr")
install.packages("dplyr")
install.packages("car")
install.packages("R2jags")
install.packages("raster")
install.packages("rgdal")
install.packages("stringr")
install.packages("ggplot2")
install.packages("wesanderson")
install.packages("gridExtra")
install.packages("reshape2")
install.packages("RColorBrewer")
install.packages("RODBC")
install.packages("mcmcplots")



# Load Packages
require(plyr)
require(dplyr)
require(car)
require(R2jags)
require(raster)
require(rgdal)
require(stringr)
require(ggplot2)
require(wesanderson)
require(gridExtra)
require(reshape2)
require(RColorBrewer)
require(RODBC)
require(mcmcplots)

print("packagesloaded")