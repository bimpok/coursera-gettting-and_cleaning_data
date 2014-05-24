#Assignment for Week 3
#Current WD: C:\testR\data\gcdweek3\UCI HAR Dataset

#Extract and merge the data

#X sets
Xtrnset <- read.table("train//X_train.txt")
Xtstset <- read.table("test//X_test.txt")

#X sets
Ytrnset <- read.table("train//y_train.txt")
Ytstset <- read.table("test//y_test.txt")

#Subject sets
Subtrnset <- read.table("train//subject_train.txt")
Subtstset <- read.table("test//subject_test.txt")

#Activity labels
actlbls <- read.table("activity_labels.txt")
feat <- read.table("features.txt")

#Merge X sets
XSet<-rbind(Xtrnset,Xtstset)
YSet<-rbind(Ytrnset,Ytstset)
SubjSet<-rbind(Subtrnset,Subtstset)

#Extract only measurement on mean and standard deviation

index_for_mean_or_sd <- grep("-mean\\(\\)|-std\\(\\)", feat[, 2])
XSet <- XSet[, index_for_mean_or_sd]
names(XSet) <- tolower(gsub("\\(|\\)", "", feat[index_for_mean_or_sd,2]))

#Using descriptive activity names from activity_lables.txt dataset

actlbls[, 2] = gsub("_", "", tolower(as.character(actlbls[, 2])))
YSet[,1] = actlbls[YSet[,1], 2]
names(YSet) <- "activity"

#Labelling data sets with descriptive activity names

names(SubjSet) <- "subject"
cleaned_data_set <- cbind(SubjSet, YSet, XSet)


#Creating 2nd independent data set with the average of each variable for each activity and subject

Unique_SubjSet <- unique(SubjSet) [,1]
total_Subjects <- length(unique(SubjSet)[,1])
total_Activities <- length(actlbls[,1])
numCols <- dim(cleaned_data_set)[2]
result1 <- cleaned_data_set[1:(total_Subjects*total_Activities),]

row <- 1

for (s in 1:total_Subjects) {
  for (a in 1: total_Activities) {
    result[row,1] <- Unique_SubjSet[s]
    result[row,2] <- actlbls[a,2]
    tmp <- cleaned_data_set[cleaned_data_set$subject==s 
                & cleaned_data_set$activity==actlbls[a, 2], ]
    result[row,3:numCols] <- colMeans(tmp[,3:numCols])
    row <- row + 1
  }
}

write.table(result, "final_data_set.txt")


