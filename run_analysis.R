# Info File http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data files https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# R script run_analysis.R does the following:
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#
########################
# download data - verify directory - unzip contents
fileName <- "projectdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"
#
# 
if(!file.exists(fileName)){
        download.file(url,fileName, mode = "wb") 
}
# 
if(!file.exists(dir)){
        unzip("projectdata.zip", files = NULL, exdir=".")
}
########################
# read all files 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
#########################
#
### 1. Merges the training and the test sets to create one data set.
extract_mean_std <- rbind(X_train,X_test)
#
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Use the vector to subset data from the mean and standard deviation of each measurement.
mean_std <- grep("mean()|std()", features[, 2]) 
extract_mean_std <- extract_mean_std[,mean_std]
#
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
# using gsub remove "()" 
activity_names <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(extract_mean_std) <- activity_names[mean_std]
# combine the test and train and apply to name the activities
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'
# 
# group the activity column of dataSet, re-name lable of levels with activity_levels, and apply it to dataSet.
act_group <- factor(dataSet$activity)
levels(act_group) <- activity_labels[,2]
dataSet$activity <- act_group
# combine subject, activity, and mean and std only data set to create final data set.
extract_mean_std <- cbind(subject,activity, extract_mean_std)
#
# group the activity column of dataSet, re-name lable of levels with activity_levels, and apply it to dataSet.
act_group <- factor(extract_mean_std$activity)
levels(act_group) <- activity_labels[,2]
dataSet$activity <- act_group
#
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
        install.packages("reshape2")
}
library("reshape2")

# melt data to tall skinny data and cast means. Finally write the tidy data to the working directory as "tidy_data.txt"
baseData <- melt(extract_mean_std,(id.vars=c("subject","activity")))
secondDataSet <- dcast(baseData, subject + activity ~ variable, mean)
names(secondDataSet)[-c(1:2)] <- paste("[mean of]" , names(secondDataSet)[-c(1:2)] )
write.table(secondDataSet, "tidy_data.txt", sep = ",")
#
