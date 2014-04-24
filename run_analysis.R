library(reshape2)

# open labels file
setwd("~/My Dropbox/Coursera/Getting and Cleaning Data/Getting and Cleaning Data Project/CourseraProject1")

# get header names from features.txt
headers <- read.table("UCI HAR Dataset/features.txt")

# load test and train data from their respective files into a data frame
# set the column labels to be the headers
testData <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=headers[,2])
trainData <-read.table("UCI HAR Dataset/train/X_train.txt",col.names=headers[,2])

# we only care about the mean and std observations, so pull out the data
# from those columns
meanTestData <- testData[,grepl("mean()",headers[,2],fixed=TRUE)]
meanTrainData <- trainData[,grepl("mean()",headers[,2],fixed=TRUE)]
stdTestData <- testData[,grepl("std()",headers[,2],fixed=TRUE)]
stdTrainData <- trainData[,grepl("std()",headers[,2],fixed=TRUE)]

# load the activity type numbers
testY <- read.table("UCI HAR Dataset/test/y_test.txt",col.names=c("ActivityType"))
trainY <- read.table("UCI HAR Dataset/train/y_train.txt",col.names=c("ActivityType"))
mergedY <- rbind(testY,trainY)

# load activity labels
activLabels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)

# replace the numerical activity ID's with descriptive labels
mergedY <- activLabels[mergedY[,1],2]

# load the subject ID numbers
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names=c("Subject ID"))
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names=c("Subject ID"))
mergedSub <- rbind(testSub,trainSub)

# merged the test and train data, and add the "activity label" column
meanMergedData <- cbind(rbind(meanTestData,meanTrainData),mergedSub)
meanMergedData$Activity <- mergedY
stdMergedData <- cbind(rbind(stdTestData,stdTrainData),mergedSub)
stdMergedData$Activity <- mergedY

# "Melt" the data sets and then use dcast to aggregate them into a tidy data set
meanMelt <- melt(meanMergedData,id=c("Subject.ID","Activity"))
stdMelt <- melt(stdMergedData,id=c("Subject.ID","Activity"))

meanTidy <- dcast(meanMelt,formula = Subject.ID + Activity ~ variable, mean)
stdTidy <- dcast(stdMelt,formula = Subject.ID + Activity ~ variable, mean)

# write the tidy data sets to files
write.table(meanTidy,"mean_tidy.txt",row.names=FALSE)
write.table(stdTidy,"std_tidy.txt",row.names=FALSE)

