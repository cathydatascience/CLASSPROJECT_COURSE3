#read the datasets
setwd("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
#activity contains labels of the six activities
activity<-read.table("activity_labels.txt")
#features has 561 activities
#subject_test/subject_train has the id of the volunteers

#subject_test that has 2947 rows and 1 column 
subject_test<-read.table("./test/subject_test.txt")
#test has 9 volunteers
table(subject_test)
#X_test that has 2947 rows and 561 columns
X_test<-read.table("./test/X_test.txt")
#y_test that has 2947 rows and 1 column
y_test<-read.table("./test/y_test.txt")

#train that has 7352 rows and has 21 volunteers
subject_train<-read.table("./train/subject_train.txt")
#X_train has 7352 rows and 561 columns
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")

#combine subject_test and y_test to X_test
names(subject_test)<-c("id")
names(y_test)<-c("activity")
X_testjoin<-cbind(subject_test, y_test, X_test)

names(subject_train)<-c("id")
names(y_train)<-c("activity")
X_trainjoin<-cbind(subject_train, y_train, X_train)

#X is the merged dataset from which the tidyData and avgData are derived. 
X<-rbind(X_testjoin, X_trainjoin)

#change variable "id" and "activity" to factor variables
X$id<-factor(X$id)
activity_labels<-read.table("./activity_labels.txt")
X$activity<-factor(X$activity, labels = activity_labels[,2])
feature_labels<-read.table("./features.txt", stringsAsFactors = FALSE)
feature<-feature_labels[,2]
names(X)[3:563]<-feature_labels[,2]

#cleaning the data
mean<-grep("mean()", names(X), fixed=TRUE) #33 variables
std<-grep("std()", names(X), fixed=TRUE) #33 variables

tidyData<-X[,c(1:2, mean, std)]

write.csv(tidyData, "./tidyData.csv", row.names=FALSE)

#a second, independent tidy dataset with avg of the features, i.e. columns 3 to 68
library(dplyr)

avgData<-tidyData %>% group_by(id, activity) %>% summarize_all(list(~mean(.)))

write.csv(avgData, "./avgData.csv", row.names=FALSE)

