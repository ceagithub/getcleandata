# Coursera Getting and cleaning data assignment
# A script to merge and clean Samsung Galaxy X accelerometer datasets

# This script requires the "dplyr" and "reshape2" packages to be installed

# load required packages
library(dplyr)
library(reshape2)

# download and extract the datasets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./projData.zip")
unzip("projData.zip", exdir = "./projData")

# read in the labels for the training/test variables and the activities
varLabels <- read.table("./projData/UCI HAR Dataset/features.txt")
actLabels <- read.table("./projData/UCI HAR Dataset/activity_labels.txt")
colnames(actLabels) <- c("activityNum", "activityName")

# read in and combine the training data, add column labels
subject_train <- read.table("./projData/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) <- "subject"
y_train <- read.table("./projData/UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "activityNum"
X_train <- read.table("./projData/UCI HAR Dataset/train/X_train.txt")
colnames(X_train) <- varLabels$V2
trainData <- cbind(subject_train, y_train, X_train)

# read in and combine the test data, add column labels
subject_test <- read.table("./projData/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- "subject"
y_test <- read.table("./projData/UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "activityNum"
X_test <- read.table("./projData/UCI HAR Dataset/test/X_test.txt")
colnames(X_test) <- varLabels$V2
testData <- cbind(subject_test, y_test, X_test)

# combine the training and test data into a single data frame
combined <- rbind(trainData, testData)

# add activity labels to data frame
labelled <- merge(actLabels, combined, by.x = "activityNum",
                  by.y = "activityNum")

# select columns for subset - all mean and standard deviation measurements,
# excluding meanFreq and angle measurements
tidy1 <- select(labelled, activityName, subject, contains("mean"),
                 -contains("meanFreq"), contains("std"), -contains("angle"))

# create vector of descriptive variable names for tidy data set

newLabels <- c("activityName", "subject", "tBodyAccMeanX", "tBodyAccMeanY",
               "tBodyAccMeanZ", "tBodyAccStDX", "tBodyAccStDY", "tBodyAccStDZ",
               "tGravityAccMeanX", "tGravityAccMeanY", "tGravityAccMeanZ",
               "tGravityAccStDX", "tGravityAccStDY", "tGravityAccStDZ",
               "tBodyAccJerkMeanX", "tBodyAccJerkMeanY", "tBodyAccJerkMeanZ",
               "tBodyAccJerkStDX", "tBodyAccJerkStDY", "tBodyAccJerkStDZ",
               "tBodyGyroMeanX", "tBodyGyroMeanY", "tBodyGyroMeanZ",
               "tBodyGyroStDX", "tBodyGyroStDY", "tBodyGyroStDZ",
               "tBodyGyroJerkMeanX", "tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ",
               "tBodyGyroJerkStDX", "tBodyGyroJerkStDY", "tBodyGyroJerkStDZ",
               "tBodyAccMagMean", "tBodyAccMagStD", "tGravityAccMagMean",
               "tGravityAccMagStD", "tBodyAccJerkMagMean", "tBodyAccJerkMagStD",
               "tBodyGyroMagMean", "tBodyGyroMagStD", "tBodyGyroJerkMagMean",
               "tBodyGyroJerkMagStD", "fBodyAccMeanX", "fBodyAccMeanY",
               "fBodyAccMeanZ", "fBodyAccStDX", "fBodyAccStDY", "fBodyAccStDZ",
               "fBodyAccJerkMeanX", "fBodyAccJerkMeanY", "fBodyAccJerkMeanZ",
               "fBodyAccJerkStDX", "fBodyAccJerkStDY", "fBodyAccJerkStDZ",
               "fBodyGyroMeanX", "fBodyGyroMeanY", "fBodyGyroMeanZ",
               "fBodyGyroStDX", "fBodyGyroStDY", "fBodyGyroStDZ",
               "fBodyAccMagMean", "fBodyAccMagStD", "fBodyAccJerkMagMean",
               "fBodyAccJerkMagStD", "fBodyGyroMagMean", "fBodyGyroMagStD",
               "fBodyGyroJerkMagMean", "fBodyGyroJerkMagStD")

# apply new variable names
colnames(tidy1) <- newLabels

# create second dataset with average of each variable from "subset"
# for each activity and each subject

melted <- melt(tidy1, id = c("activityName", "subject"))
tidy2 <- dcast(melted, activityName + subject ~ variable, mean)

write.table(tidy2, file = "./tidy2.txt" row.names = FALSE)
