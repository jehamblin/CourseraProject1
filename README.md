CourseraProject1
================

Project for "Getting and Cleaning Data" Coursera course.

Script Description
------------------

The R script run_analysis.R combines the "test" and "train" data
sets and creates a tidy data summarizing the values they contain.

1. First, the script loads the "features.txt" file that contains
the labels for the 500+ measurements contained in each line of 
the data files.

2. Next, the script reads the test and train raw data files,
and selects only those columns corresponding to mean or standard
deviation measurements.

3. Then, the script reads the activity type numbers (each taking
on a value from 1-6) for each row of the tables constructed in 
step 2.  These numbers are then replaced by the descriptive labels
found in "activity_labels.txt"

4. Similarly to step 3, the Subject ID numbers are read and
merged into a single vector.

5. This step merges all of the data together: the test/train data
are merged, and two new columns are added, one for the activity
and one for the subject ID.

6. Next, the melt and dcast commands are used to reformat and
summarize the data.  There are 30 subject ID's and 6 activities,
so each of the two data sets (one for mean, one for standard 
deviation) has 180 rows.

7. Finally, these tidy data sets are written to two separate 
files.
