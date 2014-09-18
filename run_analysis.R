## Coursera: getdata-007 Course Project
## This script assumes that the Samsung dataset (i.e. the data inside the UCI HAR Dataset
## folder is in your working directory)

library(dplyr)

## This section read's and merges the training and test datasets into one dataset
xtest<-read.table("./test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
ytest<-read.table("./test/y_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_sub<-read.table("./test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_set<-cbind(ytest, test_sub, xtest)


xtrain<-read.table("./train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
ytrain<-read.table("./train/y_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_sub<-read.table("./train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_set<-cbind(ytrain, train_sub, xtrain)

comb_set<-rbind(test_set, train_set)

##read the and set the column names
cols<-read.table("./features.txt", header=FALSE, stringsAsFactors=FALSE)
cols<-cols[,2]

##rename some of the columns to be more descriptive
setnames(comb_set, 3:563, cols)
setnames(comb_set, 1, "Activity")
setnames(comb_set, 2, "Subject")

## This section sets descriptive activity names to name the activities in the data set
activity<-read.table("./activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)
for (i in (1:6)) {
    suppressWarnings(comb_set$Activity[as.numeric(comb_set$Activity)==i]<-activity[i,2])
}

## This section extracts only the measurements on the mean and standard deviation for each measurement
mean_loc<-grep("mean", names(comb_set))
std_loc<-grep("std", names(comb_set))
extract<-c(1, 2, mean_loc, std_loc)
extract<-sort(extract)

extracted_set<-comb_set[, extract]


## From the data set in above, this section creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.
l<-length(extracted_set)
suppressWarnings(mean_aggregated<-aggregate(
    extracted_set, by=list(extracted_set$Activity, extracted_set$Subject), 
    data=extracted_set[,3:l], FUN=mean, simplify=TRUE))

l2<-length(mean_aggregated)
mean_aggregated<-mean_aggregated[c(1:2, 5:l2)]

##rename to be more descriptive
l3<-length(mean_aggregated)
n<-names(mean_aggregated)[3:l3]
setnames(mean_aggregated, 1, "Activity")
setnames(mean_aggregated, 2, "Subject")
setnames(mean_aggregated, 3:l3, paste("Avg.of.", n))

melted<-mean_aggregated

##This section melts the data if you prefer a long narrow data table
##melted<-melt(mean_aggregated, id.vars=c("Activity", "Subject"))
##setnames(melted, 3, "Measured Variable")
##setnames(melted, 4, "Average Value of Measure")
##melted<-tbl_dt(melted)
##melted<-arrange(melted, Subject)


##write the dataset to working directory
write.table(melted, "./tidy_data.txt", row.names=FALSE)
