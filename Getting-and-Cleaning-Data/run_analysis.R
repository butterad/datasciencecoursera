##  Getting and Cleaning Data Course Project
##  R Program Name:   run_analysis.R
##
##  The goal of this project is to prepare tidy data that can be used for later analysis. 
##
##  The data linked to from the course website represents data collected from the accelerometers 
##  from the Samsung Galaxy S smartphone. A full description is available at:
##
##  	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
##  The data for the project is available at the following link:
##
##  	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
##  This R script does the following:
##
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. From the data set in step 4, creates a second, independent tidy data set with the average 
##     of each variable for each activity and each subject.
##

##  Set the Working Directory

setwd("C:/DennisFiles/Coursera/R-workdir")

##  Install the "reshape2" package so to allow for easy transformation of data between wide and 
##  long formats. The 'melt' function is used in STEP 4 to take wide-format data and transform
##  it ('melt') into long-format data. The 'dcast' function is then used to average each variable 
##  for each activity and each subject.

install.packages("reshape2")
library(reshape2)

##  Download the zipped data for the project and then 'unzip' the file. The folder 'UCI HAR Dataset' 
##  will be created.

download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 	      destfile='project_files.zip')

unzip('project_files.zip')

##  STEP 1: Merge the training datasets and the test datasets to create one dataset.
##          This will mean reading all required .txt files and label the columns. 
##
##  Part 1: Read the datasets from the main folder "/UCI HAR Dataset": 
##
##  1. 'activity_labels.txt' - Links the class labels with their activity name.
##  2. 'features.txt'        - The complete list of variables of each feature vector.
##
##  Note that 'features_info.txt' is used to understand the information about the variables 
##  used on the feature vector. 'features_column_names' will be used to ensure consistent naming
##  column names for both the 'test' dataset and the 'train' dataset.
##

	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
		      		      col.names=c("activity_id","activity_name"))

	features <- read.table("./UCI HAR Dataset/features.txt")
	features_column_names <-  features[,2]

##  Part 2: Read the datasets from the 'test' sub-folder ('/UCI HAR Dataset/test'):
##
##  1. 'X_test.txt'       - Test data set.
##  2. 'y_test.txt'       - Test Subject IDs labels.
##  3. 'subject_test.txt' - Activity IDs of the test subjects
##

	testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
	colnames(testdata) <- features_column_names

	test_subject_id <- read.table("./UCI HAR Dataset/test/subject_test.txt")
	colnames(test_subject_id) <- "subject_id"

	test_activity_id <- read.table("./UCI HAR Dataset/test/y_test.txt")
	colnames(test_activity_id) <- "activity_id"

##  Part 3: Read the datasets from the 'train' sub-folder ('/UCI HAR Dataset/train'):
##
##  1. 'X_train.txt' - Training data set.
##  2. 'y_train.txt' - Training Subject IDs labels. 
##  3. 'subject_train.txt' - Activity IDs of the train subjects
##

	traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
	colnames(traindata) <- features_column_names

	train_subject_id <- read.table("./UCI HAR Dataset/train/subject_train.txt")
	colnames(train_subject_id) <- "subject_id"

	train_activity_id <- read.table("./UCI HAR Dataset/train/y_train.txt")
	colnames(train_activity_id) <- "activity_id"

##  Part 4: Combine datasets together
##
##  First, combine 'test' datasets together: subject IDs, activity IDs, and data.
##

	test_data <- cbind(test_subject_id , test_activity_id , testdata)

##  Secondly, combine 'train' datasets together: subject IDs, activity IDs, and data.
##

	training_data <- cbind(train_subject_id , train_activity_id , traindata)

##  Lastly, combine the test dataset and the train dataset into one.
##

	test_training_data <- rbind(training_data,test_data)

##
##  STEP 2. Extract only the measurements on the mean and standard deviation for each measurement.
##  
##          As there are numerous columns that represent either 'mean' data or 'std' (standard
##          deviation) data, 'grep' pattern matching can be used to identify the columns required. 
##          Since 'grep' returns the indices of the columns that yielded a match, a second step 
##          will be needed to collect the names of the columns.
##
##  Part 1: Find 'mean' measurement columns and collect the names of the columns.
##

	mean_column_index <- grep("mean",names(test_training_data),ignore.case=TRUE)
	mean_column_names <- names(test_training_data)[mean_column_index]

##  Part 2: Find 'std' (standard deviation) measurement columns and collect the names of the columns.
##

	std_column_index <- grep("std",names(test_training_data),ignore.case=TRUE)
	std_column_names <- names(test_training_data)[std_column_index]

##  Part 3: Write all activities data for 'mean' and 'std' to a new dataset. Only include
##          'subject_id','activity_id', all mean columns, and all std columns.
##

	test_train_mean_std_data <-test_training_data[,c("subject_id","activity_id",mean_column_names,std_column_names)]

##
##  STEP 3. Use descriptive activity names to name the activities in the datset. 
##
##          This will be accomplished by merging the 'activity_labels' dataset (created in STEP 1, 
##          Part 1) with the 'test_train_mean_std_data' dataset (created in the previous step) via 
##          the 'activity_id'.
##

	activities <- merge(activity_labels,test_train_mean_std_data,
	                    by.x="activity_id",by.y="activity_id",all=TRUE)


##
##  STEP 4. Appropriately label the data set with descriptive variable names.
##
##          In this step, take wide-format data and transform it ('melt') into long-format data and 
##          provide the descriptive activity names. This will allow for easier management of the dataset.
##

	activities_long <- melt(activities,id=c("activity_id","activity_name","subject_id"))


##
##  STEP 5. From the data set just created, create the independent tidy dataset which holds the 
##          average of each variable for each activity and each subject.
##
##  Part 1. The 'dcast' function (from the 'reshape2' package) will average each variable.
## 
 
	activities_averaged <- dcast(activities_long,activity_id + activity_name + subject_id ~ variable,mean)
       
##  Part 2. Create the independent tidy dataset
##

	write.table(activities_averaged,"./activities_tidy_data.txt", row.names = FALSE)
