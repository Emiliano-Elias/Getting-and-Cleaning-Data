###
###     Coursera *Getting* and *Cleaning* Data Project ----
###                  Emiliano Elias Dena
###

###     Step 0.1. Install and load dplyr. ----
if(!require(dplyr)){
    install.packages("dplyr")
    }; library(dplyr)

###     Step 0.2. Download and unzip data  ----
zipname <- "getdata_dataset.zip" 
filename <- "UCI HAR Dataset"    

if (!file.exists(zipname)){
    urlzip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(urlzip, zipname, method="curl")
}

if (!file.exists("filname")) { 
    unzip(zipname) 
}

###     Step 0.3. Read training, test and activity data. ----
trainingSubjects <- read.table(file.path(filename, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(filename, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(filename, "train", "y_train.txt"))

testSubjects <- read.table(file.path(filename, "test", "subject_test.txt"))
testValues <- read.table(file.path(filename, "test", "X_test.txt"))
testActivity <- read.table(file.path(filename, "test", "y_test.txt"))

features <- read.table(file.path(filename, "features.txt"), as.is = TRUE)

activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

###     Step 1. Merge the training and the test sets. ----
humanActivity <- rbind(
    cbind(trainingSubjects, trainingValues, trainingActivity),
    cbind(testSubjects, testValues, testActivity)
)

rm(trainingSubjects, trainingValues, trainingActivity, 
   testSubjects, testValues, testActivity)

colnames(humanActivity) <- c("subject", features[, 2], "activity")

###     Step 2. Extract mean and standard deviation ----

columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))
humanActivity <- humanActivity[, columnsToKeep]

###     Step 3. Name the activities. ----
humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])


###     Step 4. Label the data set with descriptive variable names. ----

humanActivityCols <- colnames(humanActivity)
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

colnames(humanActivity) <- humanActivityCols

###     Step 5. Create a tidy set with the average of each variable ----
humanActivityMeans <- humanActivity %>% 
    group_by(subject, activity) %>%
    summarise_each(list(mean))

###     Step 6. Output to file "tidy_data.txt" ----
write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
###