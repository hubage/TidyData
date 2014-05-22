library(reshape2)
## assumption is file is unzipped and working directory has the folders test and train

#Read in data from each file and combine into one big dataset
test_x <-read.table("./test/X_test.txt",sep="")
test_y<-read.table("./test/Y_test.txt",sep="")
subject_test <- read.table("./test/subject_test.txt",sep="")
train_x <-read.table("./train/X_train.txt",sep="")
train_y<-read.table("./train/Y_train.txt",sep="")
subject_train <- read.table("./train/subject_train.txt",sep="")
test_train <-rbind(cbind(test_x,test_y,subject_test),cbind(train_x,train_y,subject_train))


#read in the column names
features <- read.table("./features.txt",sep="")

#clean up column names, remove puncuations
features[,2] <- tolower(gsub("-|,|\\(|\\)", "", as.matrix(features[,2])))

#identify which columns to keep by finding only those that contain mean or std
coltokeep <-c(grepl(paste(c("mean","std"), collapse='|'), features[,2]),TRUE,TRUE)

small_test_train<-subset(test_train,select = coltokeep)
names<-c(as.character(features[,2]),"Activity","Subject")
colnames(small_test_train)<-c(names[coltokeep])


#Add activity names to dataset by merging on Activities column and get rid of activity number
activities <- read.table("./activity_labels.txt",sep="")
small_test_train<-merge(small_test_train,activities,by.x = "Activity",by.y="V1")
small_test_train[,1]<-NULL
colnames(small_test_train)[length(small_test_train)]<-"Activity"

#Write table to file
melted <- melt(small_test_train, id.vars = c("Subject", "Activity"))
finaldata<-dcast(Subject + Activity ~ variable, data = melted, fun = mean)
write.table(finaldata,"TidyData.txt",sep="\t",col.names = TRUE, row.names = FALSE)

