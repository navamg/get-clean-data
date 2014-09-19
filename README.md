#README for Coursera getdata-007 Course



##General Notes on the script

'run_analysis.R' contains a script that takes as its input the files contained in the 
'Human Activity Recognition Using Smartphones Dataset' conducted by Jorge L. Reyes-Ortiz, 
Davide Anguita, Alessandro Ghio, Luca Oneto (specifically the files contained in the 
folder named 'UCI HAR Dataset'); the output of the script is a tidy data set 
named 'tidy_data.txt' written to the working directory

**The script assumes that all files are contained inside the 'UCI HAR Dataset' are copied 
into the R working directory"**

The script does the following with the files in the UCI HAR Dataset
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set called 
'tidy_data.txt' with the average of each variable for each activity and each 
subject.

Even though there are a large amount of measures per activity and subject, the author
of the script has opted to present the data in a wide format following the tidy data
principals set forth in Henry Wickham's Tidy Data paper 
(http://vita.had.co.nz/papers/tidy-data.pdf)

### to run the script
* Make sure the files in the data in UCI HAR Dataset are in the working directory
* Make sure run_analysis.R is in the working directory
* use source("run_analysis.R") to execute the script

###to read the output
Reading output via text editors is extremely unwieldy, it will be easier to use the 
following R commands (assuming tidy_data.txt is in your working directory):
* tidy<-read.table("./tidy_data.txt", header=TRUE)
* View(tidy)

##Codebook
* The X_test.txt, y_test.txt, and subject_test.txt files were read as tables and column
bound together so that y_test forms the leftmost column, and subject_test forms the second
column
* The X_train.txt, y_train.txt, and subject_train.txt files were read as tables and 
column bound together so that y_train forms the leftmost column, and subject)_test forms
the second column
* the two data tables above were then row bound to create one large dataset that contains
all test and train data
* The measured variable names were read from features.txt and were attached as 
column to the test and train large data set
* The first two columns which contains the activity number and subject number were named 
"Activity" and "Subject"
* activity numbers in the Activity column were replaced with more descriptive activity 
names as read from the activity_labels.txt file
*using the new activity labels, labels containing "mean" and "std" were subsetted out 
of the large dataset along with the Activity and Subject data
* Using the aggregate function the mean of the mean and standard deviation variables 
were calculated by Subject and Activity
* The resulting table was given descriptive column names and written to the working 
directory as "tidy_data.txt", with row.names=FALSE
* Variables: 
..* Activity: The activity performed by the volunteer (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
..* Subject: A number representing which volunteer performed the activity
..* Avg.of.._______: Variable representing the mean value of the mean and std. dev. 
variables measured in the UCI HAR Dataset provided