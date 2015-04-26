##Download the zip file containing the data and unzip the data

if(!file.exists("./CourseProject")){dir.create("./CourseProject")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile = "./CourseProject/data.zip", method = "auto")

unzip("./CourseProject/data.zip",exdir = "./CourseProject")

##Read the data into tables

#Training Data

trainingSet <- read.table("./CourseProject/UCI HAR Dataset/Train/X_train.txt", header = FALSE)
trainingLabels <- read.table("./CourseProject/UCI HAR Dataset/Train/y_train.txt", header = FALSE)
trainingSubject <- read.table("./CourseProject/UCI HAR Dataset/Train/subject_train.txt", header = FALSE)

# Test Data

testSet <- read.table("./CourseProject/UCI HAR Dataset/Test/X_test.txt", header = FALSE)
testLabels <- read.table("./CourseProject/UCI HAR Dataset/Test/y_test.txt", header = FALSE)
testSubject <- read.table("./CourseProject/UCI HAR Dataset/Test/subject_test.txt", header = FALSE)

# Feature and activity Data

features <- read.table("./CourseProject/UCI HAR Dataset/features.txt", header = FALSE)
activity <- read.table("./CourseProject/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Names the variables with descriptive names

names(trainingLabels) <- "Labels"
names(testLabels) <- "Labels"
names(trainingSubject) <- "Subject"
names(testSubject) <- "Subject"
names(testSet) <- features$V2
names(trainingSet) <- features$V2
names(activity) <- c("id","Activity")

# Combine the data into a single table

CombinedTestData <- cbind(testSubject,testLabels,testSet)
combinedTrainingData <- cbind(trainingSubject,trainingLabels,trainingSet)
combinedData <- rbind(combinedTrainingData,CombinedTestData)

# find only mean and Standard Deviation Features and subset the data

meanStdFeatures <- features[grepl("mean\\(|std\\(",features$V2),]
meanStdData <- combinedData[,c("Subject","Labels",as.character(meanStdFeatures$V2))]

# merge descriptive activity names

meanStdDataActivity <- merge(meanStdData,activity,by.x="Labels",by.y="id")

# create a data set with the average of each variable for each activity and each subject

averageResult <- ddply(meanStdDataActivity,.(Activity,Subject), function(x) colMeans(x[,3:68]))

write.table(averageResult,"AverageResult.txt",row.name = FALSE)
