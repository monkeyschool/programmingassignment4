## The script loads the test / training datasets and merges them in a tidy dataset


## 
## load the features.txt dataset
## 
loadFeatures <- function(dir) {
    fileName = paste(dir,"/features.txt",sep="")
    colName = c("num","label")
    tbl_features <- read_delim(fileName, delim = " ", col_names = colName)
}
##
## load the raw dataset
##
loadDataset <- function(dir, type, featlbl) {
    fileName = filePath(dir, "subject", type)
    colName = "subject"
    tbl_subject <- read_delim(fileName, delim = " ", col_names = colName)
    # add new column 'type' (values = [test,train])
    nbRows = nrow(tbl_subject)
    tbl_subject <- add_column(tbl_subject, 'type' = c(rep(type,nbRows))) 
    # labels (activities)
    fileName = filePath(dir, "y", type)
    colName = "activity"
    tbl_y <- read_delim(fileName, delim = " ", col_names = colName)
    # This part uses descriptive activity names
    tbl_y <- mutate(tbl_y, activity = recode(activity,
                                        `1` = "WALKING",
                                        `2` = "WALKING_UPSTAIRS",
                                        `3` = "WALKING_DOWNSTAIRS",
                                        `4` = "SITTING",
                                        `5` = "STANDING",
                                        `6` = "LAYING"))


    # load X dataset
    fileName = filePath(dir, "X", type)
    colName = featlbl
    tbl_X <- read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )

    nb_signals = 128
    subdirdata = "Inertial Signals"
    # body_acc_x/y/z
    datasetname = "body_acc_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_acc_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_acc_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    # body_gyro_x/y/z
    datasetname = "body_gyro_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_gyro_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_gyro_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    # total_acc_x/y/z
    datasetname = "total_acc_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "total_acc_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "total_acc_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    ## merge dataset
    tbl_test <- bind_cols(tbl_subject,
                          tbl_y,
                          tbl_X,
                          tbl_body_acc_x,
                          tbl_body_acc_y,
                          tbl_body_acc_z,
                          tbl_body_gyro_x,
                          tbl_body_gyro_y,
                          tbl_body_gyro_z,
                          tbl_total_acc_x,
                          tbl_total_acc_y,
                          tbl_total_acc_z)
}

## 
## build a full file path
## 
filePath <- function(dir, fileName, type) {

    paste(dir,"/",type,"/",paste(fileName,"_",type,sep=""),".txt",sep="")
    
}

# use 'readr' library to make directly some tibble
library(readr)
library(tibble)
library(dplyr)

# my local repository of initial dataset
setwd("~/R/03 - Geting and Cleaning Data")

##
## Merges the training and the test sets to create one data set.
## 

## Load Test dataset
folderName <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"

# load features with labels (only once)
ft_lbl<-loadFeatures(folderName)

# dataset TEST
typeOfDataSet <- "test"
dt_test<-loadDataset(folderName, typeOfDataSet, ft_lbl$label)

# dataset TRAINING
typeOfDataSet <- "train"
dt_training<-loadDataset(folderName, typeOfDataSet, ft_lbl$label)

# global merge
dt_total <- bind_rows(dt_test, dt_training)

## 
## Extracts only the measurements on the mean and standard deviation for each measurement.
## 
dt_extract <- dt_total[grepl("subject|activity|-mean|-std", names(dt_total))]

## Uses descriptive activity names to name the activities in the data set
## 
## Creates a second, independent tidy data set with the avg of each variable for each activity and each subject
## -----------------------------------------------------------------
gby_subject_activity <- group_by(dt_extract, subject, activity)
dt_stats <- summarise_all(gby_subject_activity, tibble::lst(mean))
write.table(dt_stats, file="dt_stats.txt", row.name=FALSE)

