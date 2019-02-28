Codebook of class project 
"Human Activity Recognition Using Smartphones Dataset
Version 1.0"

Cathy Gao

Date: 02/25/2019

output: tidyData.csv and avgData.csv

## The goal is to prepare tidy data that can be used for later analysis.

## The zip file of the data for the project is available at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Creating the datasets: tidyData.csv and avgData.csv

### Guide to create the data files
1. download the data zip file and unzip the files under a folder. 
2. in the folder of "test", combine subject_test (1 column), y_test (1 column) and X_test which all have the same number of rows, 2947. 
3. in the folder of "train", combine subject_train, y_train and X_train which all have the same number of rows, 7352.
4. append the dataset from step3 to the dataset from step2 which have the same number of columns, 563. 
5. rename the first variable in the merged dataset as "id" which is originally from the subject_test file. 
6. download the txt file "activity_labels" and assign as labels to the y_test variable, i.e. the second variable in the merged dataset and rename the variable as "activity". 
7. download the txt file "features" and assign as names to the 3rd to 563rd variables of the merged dataset. There are 561 features in total - see the txt file "features_info" for details. 

###cleaning of the merged dataset
1. select features that contain "mean" and "std" measurements from the 561 features and have 33 "mean" features and 33 "std" ones. The first dataset is derived. Below are the R scripts that do the work. 

"mean<-grep("mean()", names(X), fixed=TRUE) #33 variables
std<-grep("std()", names(X), fixed=TRUE) #33 variables
tidyData<-X[,c(1:2, mean, std)]"

2. from the tidyDataset, summarize first by "id" (30 volunteers) and then by "activity" (6 levels), the average value of each of the 66 features. The result, avgData, consists of 30*6=180 rows and the same columns as the tidyDataset, 563. 

3. write out both R data files to csv files.  

## Description of the variables in the tidyData file
  - dimension: 10299 observations of 68 variables. 
  - a dataset that is composed of "id" of the 30 volunteers (subjects) and their 6 activities which are recorded in smartphone software with 33 features that have "mean" measures and 33 that have "std" measures. Each "id" logged in different frequencies of each of the six activities. 
  - "id" is a factor variable that starts from 1 and ends at 30, which is to identify the subject/volunteer.
    "activity" is a factor variable ranging from 1 to 6, which represents the six activities - see below the R script and the result. 
    
    levels(tidyData$activity)
[1] "WALKING"            "WALKING_UPSTAIRS"   "WALKING_DOWNSTAIRS" "SITTING"            "STANDING"           "LAYING"   

    the remaining 66 variables are features of the activities recorded by each "id" with varying frequencies in each activity. They are all numeric. Two signals we pick to include in tidyData are mean() and std() on the 33 patterns where the variables that end with XYZ represent three variables. The patterns are describled in the features_info file. 
    Below are explanations from the original features_info txt file from the zip file. 
    
    "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag"
"

Here are a few examples of the mean variables: "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z". 

Here are a few examples of the std variables: "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z". 


## Description of the variables in the avgData file
Here are the R script to obtain avgData from the tidyData file (see above): 
"library(dplyr)

avgData<-tidyData %>% group_by(id, activity) %>% summarize_all(list(~mean(.)))"

The dataset takes the mean of the 66 feature variables of the mean and the standard deviation and arranges it by volunteer id (1-30) and activity (1-6). The resulting dataset has 30*6=180 rows and 68 columns where the first is the id, the second is the activity and the remainder are the mean of the 66 features. 



          