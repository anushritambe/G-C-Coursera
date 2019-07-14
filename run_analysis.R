library(dplyr)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
variables <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
X_merge <- rbind(X_train, X_test)
Y_merge <- rbind(Y_train, Y_test)
Subject_merge <- rbind(Subject_train, Subject_test)
extract <- variables[grep("mean|std",variables[,2]),]
X_merge <- X_merge[,extract[,1]]
colnames(Y_merge) <- "activity"
Y_merge$activitylabel <- factor(Y_merge$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_merge[,-1]
colnames(X_merge) <- variables[extract[,1],2]
colnames(Subject_merge) <-  "subject"
total <- cbind(X_merge, activitylabel, Subject_merge)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)