1. Reads data and Merges the two files - files are as follows:
subject_test : subject IDs for test
subject_train : subject IDs for train
X_test : values of variables in test
X_train : values of variables in train
y_test : activity ID in test
y_train : activity ID in train
activity_labels : Description of activity IDs in y_test and y_train
features : description(label) of each variables in X_test and X_train

extract_mean_std : bind of X_train and X_test

2. Extracts only the measurements on the mean and standard deviation for each measurement.
Use the vector to subset data from the mean and standard deviation of each measurement.

MeanStd contains mean and std labels extracted from the features table

3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
using gsub remove "()" and set values to a clean set of data to then use to apply to table

activity_names : the temporary cleaned data
subject : bind of subject_train and subject_test
activity : bind of y_train and y_test

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
check if reshape2 package is installed and install if needed

using clean labels melt and write the tidy data to "tidy_data.txt"

