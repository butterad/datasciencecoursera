#Codebook

##Tidy Data Set: activities_tidy_data.txt

The 'run_analysis.R' program generates a tidy data set called "activities_tidy_data.txt". 

The information within this file is based on data collected from the accelerometers from 
the Samsung Galaxy S smartphone. A full description of this is available at:

     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is sourced from the following:

     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
Thirty (30) people participated in the study with age between 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while carrying a waist-mounted 
smartphone with embedded inertial sensors. 

Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset, the following information is provided:
•	Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
•	Triaxial Angular velocity from the gyroscope.
•	A 561-feature vector with time and frequency domain variables.
•	Its activity label.
•	An identifier of the subject who carried out the experiment.

###Variables Information

####Activity: 
Factor - with six (6) levels: "LAYING", "SITTING", "STANDING". "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"

####subject: 
Character - identifying the volunteers who are identified as "subject_01" to "subject_30"

####Features: 
Numeric

######The 'mean' measurement columns include: 

 [1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
 [3] "tBodyAcc-mean()-Z"                    "tGravityAcc-mean()-X"                
 [5] "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
 [7] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
 [9] "tBodyAccJerk-mean()-Z"                "tBodyGyro-mean()-X"                  
[11] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[13] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[15] "tBodyGyroJerk-mean()-Z"               "tBodyAccMag-mean()"                  
[17] "tGravityAccMag-mean()"                "tBodyAccJerkMag-mean()"              
[19] "tBodyGyroMag-mean()"                  "tBodyGyroJerkMag-mean()"             
[21] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[23] "fBodyAcc-mean()-Z"                    "fBodyAcc-meanFreq()-X"               
[25] "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
[27] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[29] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-meanFreq()-X"           
[31] "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
[33] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[35] "fBodyGyro-mean()-Z"                   "fBodyGyro-meanFreq()-X"              
[37] "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
[39] "fBodyAccMag-mean()"                   "fBodyAccMag-meanFreq()"              
[41] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-meanFreq()"      
[43] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-meanFreq()"         
[45] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-meanFreq()"     
[47] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[49] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"
[51] "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
[53] "angle(Z,gravityMean)"   

######The 'std' (standard deviation) measurement columns include: 

 [1] "tBodyAcc-std()-X"           "tBodyAcc-std()-Y"           "tBodyAcc-std()-Z"          
 [4] "tGravityAcc-std()-X"        "tGravityAcc-std()-Y"        "tGravityAcc-std()-Z"       
 [7] "tBodyAccJerk-std()-X"       "tBodyAccJerk-std()-Y"       "tBodyAccJerk-std()-Z"      
[10] "tBodyGyro-std()-X"          "tBodyGyro-std()-Y"          "tBodyGyro-std()-Z"         
[13] "tBodyGyroJerk-std()-X"      "tBodyGyroJerk-std()-Y"      "tBodyGyroJerk-std()-Z"     
[16] "tBodyAccMag-std()"          "tGravityAccMag-std()"       "tBodyAccJerkMag-std()"     
[19] "tBodyGyroMag-std()"         "tBodyGyroJerkMag-std()"     "fBodyAcc-std()-X"          
[22] "fBodyAcc-std()-Y"           "fBodyAcc-std()-Z"           "fBodyAccJerk-std()-X"      
[25] "fBodyAccJerk-std()-Y"       "fBodyAccJerk-std()-Z"       "fBodyGyro-std()-X"         
[28] "fBodyGyro-std()-Y"          "fBodyGyro-std()-Z"          "fBodyAccMag-std()"         
[31] "fBodyBodyAccJerkMag-std()"  "fBodyBodyGyroMag-std()"     "fBodyBodyGyroJerkMag-std()"