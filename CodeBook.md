# CODE BOOK - Samsung Galaxy S accelerometer training and test tidy dataset

Data source:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

These data come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

Initially, all of the mean and standard deviation data from both the training and the test datasets were combined in the tt_extract dataset, along with the subject and activity fields.

Below is a description of each variable in the final dataset:

activityName - one of six activities (walking, walking upstairs, walking downstairs, sitting, standing, or laying) performed by the volunteer

subject - a number between 1 and 30 identifying the volunteer who performed the activity

All variables below with the prefix 't' are time domain signals and were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 

tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tBodyAccStDX
tBodyAccStDY
tBodyAccStDZ

- the above six variables represent the mean and standard deviations of the X, Y and Z axial variables for body acceleration signal, separated using a low pass Butterworth filter with a corner frequency of 0.3 Hz

tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tGravityAccStDX
tGravityAccStDY
tGravityAccStDZ

- the above six variables represent the mean and standard deviations of the X, Y and Z axial variables for gravity acceleraton signal, separated using a low pass Butterworth filter with a corner frequency of 0.3 Hz

tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyAccJerkStDX
tBodyAccJerkStDY
tBodyAccJerkStDZ

- the above six variables represent the mean and standard deviations of the X, Y and Z axial Jerk signals obtained by deriving the body linear acceleration in time

tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroStDX
tBodyGyroStDY
tBodyGyroStDZ

- the above six variables represent the mean and standard deviations of the X, Y and Z axial angular velocity (gyroscope signal)

tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyGyroJerkStDX
tBodyGyroJerkStDY
tBodyGyroJerkStDZ

- the above six variables represent the mean and standard deviations of the X, Y and Z axial Jerk signals obtained by deriving the angular velocity in time

tBodyAccMagMean
tBodyAccMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional body acceleration variable, calculated using the Euclidean norm

tGravityAccMagMean
tGravityAccMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional gravity acceleration variable, calculated using the Euclidean norm

tBodyAccJerkMagMean
tBodyAccJerkMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional body acceleration Jerk signal, calculated using the Euclidean norm

tBodyGyroMagMean
tBodyGyroMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional angular velocity, calculated using the Euclidean norm

tBodyGyroJerkMagMean
tBodyGyroJerkMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional angular velocity Jerk signal, calculated using the Euclidean norm

All variables below with the prefix 'f' are frequency domain signals produced using a Fast Fourier Transform (FFT) on their time domain counterparts

fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccStDX
fBodyAccStDY
fBodyAccStDZ

- the above six variables are the mean and standard deviation of the X, Y and Z axial frequency domain signals for body acceleration

fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkStDX
fBodyAccJerkStDY
fBodyAccJerkStDZ

- the above six variables are the mean and standard deviation of the X, Y and Z axial frequency domain Jerk signals for body acceleration

fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroStDX
fBodyGyroStDY
fBodyGyroStDZ

- the above six variables are the mean and standard deviation of the X, Y and Z axial frequency domain angular velocity signals

fBodyAccMagMean
fBodyAccMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional frequency domain body acceleration signal, calculated using the Euclidean norm

fBodyAccJerkMagMean
fBodyAccJerkMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional body acceleration Jerk signal, calculated using the Euclidean norm

fBodyGyroMagMean
fBodyGyroMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional frequency domain angular velocity signal, calculated using the Euclidean norm

fBodyGyroJerkMagMean
fBodyGyroJerkMagStD

- the above two variables are the mean and standard deviation of the magnitude of the three-dimensional frequency domain angular velocity Jerk signal, calculated using the Euclidean norm

----------------------------------------------------------

All data processing steps were performed using run_analysis.R so can be replicated easily by running the script. The steps will be outlined in more detail below.

The data were downloaded from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", to a destination file named projData.zip

The data were downloaded for the final run on 21st June 2015.

projData.zip was extracted into the working directory, to a folder called "projData".

The following files were then read into R, assigned to variables, and in some cases, variable names were added:

- "./projData/UCI HAR Dataset/features.txt" - this file contains all of the 561 variable names for the training and test datasets; assigned to varLabels

- "./projData/UCI HAR Dataset/activity_labels.txt" - this file contains the activity numbers and their corresponding names (only the numbers are included in the main datasets); assigned to actLabels; column names were added "activityNum" and "activityName" to assist with subsequent processing

- "./projData/UCI HAR Dataset/train/subject_train.txt" - contains the subject numbers corresponding to the training data; 7352 observations of 1 variable; assigned to subject_train; "subject" column name added

- "./projData/UCI HAR Dataset/train/y_train.txt" - contains the activity numbers for the training data; 7352 observations, 1 variable; assigned to y_train; column name "activityNum" added

- "./projData/UCI HAR Dataset/train/X_train.txt" - the main body of the training data, containing observations for each of the variables listed in "features.txt" - this dataset contains 7352 observations of 561 variables; assigned to X_train

subject_train, y_train, and X_train were then column-bound together to produce a single data frame named trainData 

"./projData/UCI HAR Dataset/test/subject_test.txt" - contains the subject numbers corresponding to the test data; 2947 obs. 1 variable; assigned to subject_test; column name "subject" added

"./projData/UCI HAR Dataset/test/y_test.txt" - contains the activity numbers for the training data; 2947 obs. 1 variable; assigned to y_test; "activityNum" column named added

"./projData/UCI HAR Dataset/test/X_test.txt" - the main body of the test data, containing observations for each of the variables listed in "features.txt" - this dataset contains 2947 observations of 561 variables; assigned to X_test

"subject_test", "y_test", and "X_test" were then column-bound together to produce a single data frame named "testData" 

trainData and testData were row-bound together to produce a single data frame called "combined"

The activity labels ("actLabels") were then merged with the complete dataset ("labelled")

This data frame was then subset to include only the mean and standard deviation measurements, using the dplyr package select function. The resulting data frame, "tidy1", contains columns for the activity measured, the subject performing the activity, and each of the mean and standard deviation measurements from the original datset. "tidy1" contains 10299 observations of 68 variables.

Finally, the variables in "tidy1" were renamed from the newLabels vector.

"tidy1" was then further processed in order to create a tidy datset with the average of each variable for each activity and each subject. There are multiple possibilities for this dataset, but in this script, the reshape2 package melt function was used alongside the dcast function, to produce "tidy2".

"tidy2" contains 180 observations and 68 variables
