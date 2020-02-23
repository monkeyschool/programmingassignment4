# programmingassignment4
#
This project consists of the following:
#
Summary
An R script run_analysis.R provides the resulting tidy dataset 

dt_total (10299 observations of 1716 variables): tidy raw data
dt_stats (180 observations of 81 variables): tidy data set with the average of some specific variables (i.e all mean and standard deviation variables) for each activity and each subject

To Run
a) Before starting the script, please ensure your working session (see: setwd() command) contains the uncompressed original repository (that contains the original deflated dataset):

   ./getdata_projectfiles_UCI HAR Dataset
b) To start the script, type (on RStudio for example):

   source("run_analysis.R")
c) At the end, an abstract of dt_stats is displayed (using tibble::glimpse() command)

d) and a dt_stats.txt is generated
