# Getting and Cleaning Data Course Project

## R Program Name:   run_analysis.R

### Goal
The goal of this project is to prepare tidy data that can be used for later analysis. 

The data linked to from the course website represents data collected from the accelerometers 
from the Samsung Galaxy S smartphone. A full description is available at:

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is available at the following link:

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This R script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average 
   of each variable for each activity and each subject.

### Set the Working Directory

No assumptions are made with this code, therefore, we set the working directory to the designated
working directory on the host computer ("C:/DennisFiles/Coursera/R-workdir").

### Install the "reshape2" Package
The 'reshape2' package is installed so to allow for the need of the transformation of data between 
wide and long formats. Specifically, the 'melt' function is used in STEP 4 to take wide-format 
data and transform it ('melt') into long-format data. Also, the 'dcast' function is used to average 
each variable for each activity and each subject.

### Download the "Human Acticity Recognition Using Smartphones" data set.
We then download the zipped data for the project and then 'unzip' the file. The folder 'UCI HAR Dataset' 
will be created.


### STEP 1: Merge the training datasets and the test datasets to create one dataset.
This step includes reading all required .txt files and labelling the columns. 

#### Part 1: Read the datasets from the main folder "/UCI HAR Dataset": 
We read the following files first: 

1. 'activity_labels.txt' - Links the class labels with their activity name.
2. 'features.txt'        - The complete list of variables of each feature vector.

Also, the 'features_info.txt' file is used to understand the information about the variables 
used on the feature vector. 'features_column_names' is used to ensure consistent naming of
column names for both the 'test' dataset and the 'train' dataset.

#### Part 2: Read the datasets from the 'test' sub-folder ('/UCI HAR Dataset/test'):
We then read all the required 'test' data sets: 

1. 'X_test.txt'       - Test data set.
2. 'y_test.txt'       - Test Subject IDs labels.
3. 'subject_test.txt' - Activity IDs of the test subjects

#### Part 3: Read the datasets from the 'train' sub-folder ('/UCI HAR Dataset/train'):
We then read all the required 'train' data sets: 

1. 'X_train.txt' - Training data set.
2. 'y_train.txt' - Training Subject IDs labels. 
3. 'subject_train.txt' - Activity IDs of the train subjects

#### Part 4: Combine datasets together
We first combine all the 'test' datasets together (columns include: subject IDs, 
activity IDs, and data).

Secondly, we combine all the 'train' datasets together (columns include: subject IDs, 
activity IDs, and data).

Lastly, we combine the 'test' dataset and the 'train' dataset into one.


### STEP 2. Extract only the measurements on the mean and standard deviation for each measurement.
As there are numerous columns that represent either 'mean' data or 'std' (standard deviation) data, 
'grep' pattern matching can be used to identify the columns required. Since 'grep' returns the indices 
of the columns that yielded a match, a second step will be needed to collect the names of the columns.

This step is separated into three parts: 

1. Find 'mean' measurement columns and collect the names of the columns.
2. Find 'std' (standard deviation) measurement columns and collect the names of the columns.
3. Write all activities data for 'mean' and 'std' to a new dataset. Only include 'subject_id',
   'activity_id', all mean columns, and all std columns.


### STEP 3. Use descriptive activity names to name the activities in the datset. 
This will be accomplished by merging the 'activity_labels' dataset (created in STEP 1, Part 1) 
with the 'test_train_mean_std_data' dataset (created in the previous step) via the 'activity_id'.


### STEP 4. Appropriately label the data set with descriptive variable names.
In this step, take wide-format data and transform it ('melt') into long-format data and provide 
the descriptive activity names. This will allow for easier management of the dataset.


### STEP 5. Create the independent tidy dataset.
From the data set just created, create the independent tidy dataset which holds the average of 
each variable for each activity and each subject.

Use the 'dcast' function (from the 'reshape2' package) which will average each variable. Then 
create the independent tidy dataset.