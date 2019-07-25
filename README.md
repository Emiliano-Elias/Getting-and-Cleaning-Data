# Coursera *Getting* and *Cleaning* Data Project

*Getting* and *Cleaning* Data Project aims to save, work, clean and prepare a tidy data collected from the accelerometers from the Samsung Galaxy S smartphone.


To archive this goal, this repository contains the following files:
- `README.md`, this file, which provides an overview of the data set and how it was created.
- `tidy_data.txt`, which contains the data set.
- `CodeBook.md`, which describes the contents of the data set.
- `run_analysis.R`, the R script that was used to create the data set.


## Work
The R script `run_analysis.R` performs the following steps: 
- Download and unzip source data if it doesn't exist.
- Read the data.
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


The `tidy_data.txt` in this repository was created by running the `run_analysis.R` script using R version 3.6.0 (2019-04-26) on Windows 10.0.17134 64-bits version.