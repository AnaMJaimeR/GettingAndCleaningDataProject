#GETTING AND CLEANING DATA COURSE PROJECT
#DATA SCIENCE SPECIALIZATION. JHU-COURSERA
#Week 4 Peer-graded Assignment

#The data linked  to from the course website represent data collected from the 
#accelerometers from the Samsung Galaxy S smartphone.

###Set working directory###

setwd("~/COURSERA/JHU-Data Science Specialization/GIT BASH/GettingAndCleaningDataProject")


###Download the data###

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "samsung.zip",method="wininet",mode="wb")
#Unzip the files
unzip("samsung.zip")

#TEST FILES
setwd("~/COURSERA/JHU-Data Science Specialization/GIT BASH/GettingAndCleaningDataProject/UCI HAR Dataset/test")
#Each row identifies the subject who performed the activity for each window sample
subject_test<-read.table("subject_test.txt")
#read the test set
x_test<-read.table("X_test.txt")
#read the test labels
y_test<-read.table("y_test.txt")

#TRAIN FILES
setwd("~/COURSERA/JHU-Data Science Specialization/GIT BASH/GettingAndCleaningDataProject/UCI HAR Dataset/train")
#Each row identifies the subject who performed the activity for each window sample
subject_train<-read.table("subject_train.txt")
#read the train set
x_train<-read.table("X_train.txt")
#read the train labels
y_train<-read.table("y_train.txt")

#FEATURES FILES
setwd("~/COURSERA/JHU-Data Science Specialization/GIT BASH/GettingAndCleaningDataProject/UCI HAR Dataset")
#features of the dataset
features<-read.table("features.txt")

#CLASS LABEL-ACTIVITY NAME
activity_names<-read.table("activity_labels.txt")

#Set original working directory
setwd("~/COURSERA/JHU-Data Science Specialization/GIT BASH/GettingAndCleaningDataProject")


###1.###
###Merge the training and test sets to create one data set

#TEST
#Set the column names for subject_test
names(subject_test)<-c("subject")
#Set the column names for x_test by using the features.txt file
names(x_test)<-features[,2]
#Set the column names for y_test
names(y_test)<-c("activity_labels")
#merge the test files
test<-cbind(subject_test,x_test)
test<-cbind(test,y_test)

#TRAIN
#Set the column names for subject train
names(subject_train)<-c("subject")
#Set the column names for x_train by using the features.txt file
names(x_train)<-features[,2]
#Set the column names for y_train
names(y_train)<-c("activity_labels")
#merge the train files
train<-cbind(subject_train,x_train)
train<-cbind(train,y_train)

#remove those objects I am not using any more from the environment
rm(subject_test,subject_train,x_train,x_test,y_train,y_test,url)

#MERGING TEST WITH TRAIN
complete_data<-rbind(train,test)


###2.###
###Extract only the measurements on the mean and standard deviation for each
###measurement

#Identify the columns names that contain the word mean on it
mean_positions<-grep("mean()",names(complete_data),value=TRUE)
#exclude those corresponding to meanFreq() measurements
a<-grep("meanFreq",mean_positions,invert = TRUE)
mean_positions<-mean_positions[a]
#final vector including the columns positions containing measurements on the mean
mean_positions<-which(names(complete_data)%in%mean_positions)

#Identify the columns that contain measurements on the standard deviation (std)
std_positions<-grep("std()",names(complete_data))

#Identify the column containing the subject
b<-which(names(complete_data)=="subject")

#Identify the column containing the activity labels
c<-which(names(complete_data)=="activity_labels")

#Final list of the columns containing measurements on the mean or std
final_columns<-c(b,c,mean_positions,std_positions)

#First tidy data set
tidy_data<-complete_data[,final_columns]

#remove those objects I am not using any more from the environment
rm(a,b,c,final_columns,mean_positions,std_positions,test,train,complete_data,features)


###3.###
###Name the activities in the data set with descriptive activity names from
###the "activity_labels.txt" file

activity_names$V2<-as.character(activity_names$V2)

for(i in 1:length(tidy_data$activity_labels)){
  for(j in 1:6){
if(tidy_data$activity_labels[i]==j){
 tidy_data$activity[i]<-activity_names[j,2] 
    }
  }
}
#TEST:sum(tidy_data$activity[which(tidy_data$activity_labels==1)]!="WALKING")
#sum(tidy_data$activity[which(tidy_data$activity_labels==2)]!="WALKING_UPSTAIRS")
#sum(tidy_data$activity[which(tidy_data$activity_labels==3)]!="WALKING_DOWNSTAIRS")
#sum(tidy_data$activity[which(tidy_data$activity_labels==4)]!="SITTING")
#sum(tidy_data$activity[which(tidy_data$activity_labels==5)]!="STANDING")
#sum(tidy_data$activity[which(tidy_data$activity_labels==6)]!="LAYING")

tidy_data<-tidy_data[,-which(names(tidy_data)=="activity_labels")]
tidy_data$subject<-as.factor(tidy_data$subject)
tidy_data$activity<-as.factor(tidy_data$activity)

#remove those objects I am not using any more from the environment
rm(i,j,activity_names)

###4.###
###Labels the data set with descriptive variable names

#The descriptive variable names were assigned during step ###1.### in order to 
#facilitate the identification of those variables corresponding to measurements on
#the mean and on the standard deviation for step ###2.###

#I consider that the variable names contained in the "features.txt" file are
#sufficiently descriptive and need no modification because
#they give comprenhensive information about each variable. At a first moment, a letter
#indicate the variable domain (t sets for time and f sets for frequency).
#The second part of the variable names give information about the motion components
#(Body sets for body motion and Gravity sets for gravitational motion). The third part
#of the names tells whether the sensor signals were captured by the accelerometer or 
#the gyroscope (Acc sets for accelerometer and Gyro sets for Gyroscope). In some cases,
#there is a fourth component that tells whether Jerk signals or magnitude were calculated
#(Jerk sets for Jerk signals and Mag sets for magnitude).After this, the next 
#component of the names gives information about the set of variables that were 
#estimated from the signals captured (mean() sets for mean value and std() sets for 
#standard deviation). Finally, in some cases a final component is included and it tells
#the direction of the signal captured (X sets for x-axis direction, Y sets for y-axis
#direction and Z sets for z-axis direction)

#Therefore, I do not make any changes to the variable names given in the "features.txt"
#file. The variable that identifies the subject who performed the activity was labeled
#as "subject" during step ###1.###. The variable that identifies the activity performed
#by the subject was created and labeled as "activity" during step ###3.###. 



###5.###
###From the data set in step ###4.###, creates a second, independent tidy data set 
###with the average of each variable for each activity and each subject.

#independent tidy data set (average summary)
library(plyr)
ind_tidy_data<-ddply(tidy_data,.(activity,subject),numcolwise(mean))

for(i in 3:length(names(ind_tidy_data))){
names(ind_tidy_data)[i]<-paste("average:",names(ind_tidy_data)[i])
}

#For the independent tidy data set (average summary) the word "average:" is added
#at the start of each variable name (for measurement variables), since those
#values are modified when the information is summarized. In this way, the 
#objective is to give specific information through the variable names and
#to be more descriptive. In this way, names are updated in order to give accurate 
#information about which kind of calculation is now shown by the summarized variables.


###6.###
###Tidy data set as a text file
write.table(ind_tidy_data,file="ind_tidy_data.txt",row.names = FALSE )