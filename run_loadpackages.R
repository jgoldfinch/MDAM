#Multispecies dependent double-observer model 
#Author: Jessie Golding
#1/28/2016

### R code for loading packages needed for MDAM ###

# Install Packages if not installed

if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
if("car" %in% rownames(installed.packages()) == FALSE) {install.packages("car")}
if("R2jags" %in% rownames(installed.packages()) == FALSE) {install.packages("R2jags")}
if("raster" %in% rownames(installed.packages()) == FALSE) {install.packages("raster")}
if("rgdal" %in% rownames(installed.packages()) == FALSE) {install.packages("rgdal")}
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr")}
if("ggplot2" %in% rownames(installed.packages()) == FALSE) {install.packages("ggplot2")}
if("wesanderson" %in% rownames(installed.packages()) == FALSE) {install.packages("wesanderson")}
if("gridExtra" %in% rownames(installed.packages()) == FALSE) {install.packages("gridExtra")}
if("reshape2" %in% rownames(installed.packages()) == FALSE) {install.packages("reshape2")}
if("RColorBrewer" %in% rownames(installed.packages()) == FALSE) {install.packages("RColorBrewer")}
if("RODBC" %in% rownames(installed.packages()) == FALSE) {install.packages("RODBC")}
if("mcmcplots" %in% rownames(installed.packages()) == FALSE) {install.packages("mcmcplots")}



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