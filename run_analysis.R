#Download of file
if (!file.exists('/data')){dir.create('./data')}
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
filename <- 'data.zip'
download.file(fileurl,destfile = paste('./data/',filename),method = 'curl')

#unzip file and reading it
if (!file.exists(paste('./data/',"UCI HAR Dataset"))) { 
  unzip(paste('./data/',filename),exdir = './data') 
}
#Assigning data sets

file_path <- ('./data/UCI HAR Dataset/')

##List of all features
features <- read.table(paste(file_path,'features.txt',sep=''),col.names = c('code_f','feature') )

##Links the class labels with their activity name
activities_labels <- read.table(paste(file_path,'activity_labels.txt',sep=''),col.names= c('code','activity'))

##Test data
file_path <- ('./data/UCI HAR Dataset/test/')

subject_test <- read.table(paste(file_path,'subject_test.txt',sep=''),col.names = 'subject')

###Test set
X_test <- read.table(paste(file_path,'X_test.txt',sep=''),col.names = features$feature)

###Test labels
Y_test <- read.table(paste(file_path,'y_test.txt',sep=''),col.names = 'code')

##Training data
file_path <- ('./data/UCI HAR Dataset/train/')

subject_train <- read.table(paste(file_path,'subject_train.txt',sep=''),col.names = 'subject')

###Training set
X_train <- read.table(paste(file_path,'X_train.txt',sep=''),col.names = features$feature)

###Training labels
Y_train <- read.table(paste(file_path,'y_train.txt',sep=''),col.names = 'code')

#Merging data sets
##Test and training sets
subject_data <- rbind(subject_test,subject_train) 
X_data <- rbind(X_test,X_train)
Y_data <- rbind(Y_test,Y_train)

##Merging all variables
Data <- cbind(subject_data,Y_data,X_data)

#Extracting mean and standard deviation for each measure
library(dplyr)
TidyData1 <- Data %>% select(subject,code,contains('std'),contains('mean'))

#Descriptive names to activities
TidyData1 <- TidyData1 %>%
  merge(activities_labels,by='code')
TidyData1 <- TidyData1 %>%
  select(subject,activity,tBodyAcc.std...X:angle.Z.gravityMean.)
TidyData1$activity <-as.factor(TidyData1$activity)

#Adjusting variables names

names(TidyData1)[2] <- 'activity'
names(TidyData1) <- gsub('Acc','Accelerometer',names(TidyData1))
names(TidyData1) <- gsub('Gyro','Gyroscope',names(TidyData1))
names(TidyData1) <- gsub('Mag','Magnitude',names(TidyData1))
names(TidyData1) <- gsub('^t','time',names(TidyData1))
names(TidyData1) <- gsub('^f','frequency',names(TidyData1))
names(TidyData1) <- gsub('BodyBody','Body',names(TidyData1))
names(TidyData1) <- gsub('tBody','TimeBody',names(TidyData1))
names(TidyData1) <- gsub('\\.mean','Mean',names(TidyData1))
names(TidyData1) <- gsub('Freq','Frequency',names(TidyData1))
names(TidyData1) <- gsub('\\.gravity','Gravity',names(TidyData1))
names(TidyData1) <- gsub('\\.std','STD',names(TidyData1))
names(TidyData1) <- gsub('\\.gravity','Gravity',names(TidyData1))
names(TidyData1) <- gsub('\\.{1,3}x','_X_',names(TidyData1),ignore.case = TRUE)
names(TidyData1) <- gsub('\\.{1,3}y','_Y_',names(TidyData1),ignore.case = TRUE)
names(TidyData1) <- gsub('\\.{1,3}z','_Z_',names(TidyData1),ignore.case = TRUE)
names(TidyData1) <- gsub('\\.{1,3}|_$','',names(TidyData1),ignore.case = TRUE)

write.table(TidyData1,file= './data/TidyData1.txt',col.names = TRUE)

#Second independent Tidy data set with the average of each variable for each 
#activity and each subject.
TidyData2 <- TidyData1 %>%
  group_by(subject, activity) %>%
  summarise(across(timeBodyAccelerometerSTD_X:timeBodyAccelerometerSTD_Z,mean))


TidyData2 <- TidyData1 %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

write.table(TidyData2,file= './data/TidyData2.txt',col.names = TRUE)

