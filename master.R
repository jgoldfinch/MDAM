#Multispecies dependent double-observer model (MDAM)
#Authors: Jessie Golding and Danielle Fagre
#Code for analyzing Danielle Fagre's pilot season (summer 2015)
#songbird data from the National Bison Range 

###Master code###

#Set working directory
setwd("C:\\Users\\jessie.golding\\Documents\\GitHub\\MDAM")

#Load packages needed for MDAM
source("run_loadpackages.R")

#Load pilot season data 

#Read data from csv file using access to R file
source("nbr.mdam.R")

#Output is dataframe mdam with all data from 2015 Pilot Season

#Data from NBR is already formatted.  Update format file later.

source("run_MDAMextension_cor.R")

save(out,file="Ch1")

###Plots and Tables - Chapter 1###
load("Ch1")
source("plot_MDAMextension_cor.R")


###MDAM - Chapter 2###
source("run_MDAMCh2.R")
save(out,file="Ch2")
load("Ch2")

###MDAM  - Chapter 2###
source("plot_MDAMextension_corCh2.R")


###MDAM - ALL SP###
source("run_MDAMextension_ALL.R")
save(out,file="ALL")
load("ALL")

### MDAM  - Plots for ALL SP ###
source("plot_MDAMextension_corCh2.R")
