
title: "Code Book"
author: "Ana Clara"
date: "11/09/2020"
output: html_document
---

<<<<<<< HEAD
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
#run_analysis.R script
It manages the data to create a tidy Data set as required by 
the course project’s definition:

1. The dataset is downloaded and extract to ~./data/UCI HAR Dataset/
      
2. Data sets are assigned:
  2.1 First, features and activities labels:

  a) features contains data from the features.txt file. 
  Data comes from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ 
  and tGyro-XYZ;

  b) activities_labels contains data from the activity_labels.txt file. 
  This contains activities labels. 
  
  2.2 Second, the test set(30% of total data):

  c)subject_test contains data from the subject_test.txt file.
  This contains an identifier of the subject who carried out the experiment;

  d)X_test contains data from the X_test.txt file.
  A 561-feature vector with time and frequency domain variables;

  e)Y_test contains data from the y_test.txt file.
  This contains activities labels.
  
  2.3 Then, the training set(70% of total data):
    
  a)subject_train contains data from the subject_train.txt file.
    This contains an identifier of the subject who carried out the experiment;
    
  b)X_train contains data from the X_train.txt file.
  A 561-feature vector with time and frequency domain variables;
  
  c)Y_train contains data from the y_train.txt file.
  This contains activities labels;

3.Data sets are merged to create one data set:
  3.1 subject_data(10299 obs. of  1 variable) is created by rbinding 
  subject_test and subject_train   datasets;
  3.2 X_data(10299 obs. of  561 variables) is created by row-binding X_test 
  and X_train datasets;
  3.3 Y_data(10299 obs. of  1 variable) is created by row-binding Y_test and 
  Y_train datasets;
  3.4 Data(10299 obs. of  563 variables) is created by column-binding 
  subject_data,Y_data,and X_data.
        
4.From Data dataset is extracted only the variables required and is created 
the first Tidy Dataset(TidyData1):
  4.1 subject;
  4.2 code;
  4.3 measurements on the mean and standard deviation for each measurement.
  
5. Give descriptive names to activities and factorize this variable:
  5.1 TidyData1 is merge with activities_labels dataset and subsetted and 
  selected to have only descriptive names.
  
6. Variables names are setted to appropriate ones- abbreviations are substituted 
to complete names, besides other adjust to improve readability:

  6.1 'Acc' is substituted by 'Accelerometer';
  6.2 'Gyro'is substituted by 'Gyroscope';
  6.3 'Mag'is substituted by 'Magnitude';
  6.4 Any variable with the name beginning with 't' is substituted by 'time';
  6.5 Any variable with the name beginning with 'f' is substituted by 'frequency';
  6.6 'BodyBody' is substituted by 'Body';
  6.7 'tBody' is substituted by 'TimeBody';
  6.8 '.mean'is substituted by 'Mean';
  6.9 'Freq' is substituted by 'Frequency';
  6.10 '.gravity'is substituted by 'Gravity';
  6.11 '.std' is substituted by 'STD';
  6.12 '.gravity'is substituted by 'Gravity';
  6.13 All of '.x,','..x', or '...x' is substituted by '_X_';
  6.14 All of '.y,','..y', or '...y' is substituted by '_Y_';
  6.15 All of '.z,','..z', or '...z' is substituted by '_Z_';
  6.16 Any of '.','..','...' remaining or '_' in the end of a variable name 
  is substituted by '';

7. It is written to '~./data' the TidyData1.txt

8. From the TidyData1 is created the independent TidyData2(tibble [180 x 5] (S3: grouped_df/tbl_df/tbl/data.frame)). This contains the average of each variable 
for each activity and each subject

9. TidyData2 is written to '~./data' the TidyData2.txt 