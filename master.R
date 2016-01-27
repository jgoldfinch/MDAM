#Multispecies dependent double-observer model (MDAM)
#Authors: Jessie Golding and Danielle Fagre
#Code for analyzing Danielle Fagre's pilot season (summer 2015)
#songbird data from the National Bison Range 

###Master code###

#Set working directory
#CHANGE when changing users
setwd("C:/Users/jessie.golding/Documents/GitHub/MDAM")

#Load packages needed for MDAM
source("run_loadpackages.R")

#Load pilot season data 

#Read data from csv file using format file nbr.mdam.R (which cuts down the number of species to 4)
source("nbr.mdam.R")

#Output is dataframe "mdam" with all data from 2015 Pilot Season

source("run_MDAM.R")

save(out,file="pilot")

###Code for loading the saved output later###
load("pilot")


