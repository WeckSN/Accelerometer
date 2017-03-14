library(dplyr)


##### STEP 1 #####

# read in variables common to both data sets
#### I'm doing this here for brevity instead of in step 4

features <- read.table("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/features.txt")


# re-assemble full test data set ###

# read in main data, already name the colums appropriately using col.names
test <- read.table("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
test$subj <- as.factor(scan("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/test/subject_test.txt"))
test$activity_num <- scan("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/test/y_test.txt")


# re-assemble full train data set ###

train <- read.table("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
train$subj <- as.factor(scan("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/train/subject_train.txt"))
train$activity_num <- scan("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/train/y_train.txt")

# combine test and training data set

df <- rbind(test, train)

#rm(list=setdiff(ls(), "df"))  # remove all other files but df 


##### STEP 2 #####

df_short <- select(df, matches("mean|std|activity_num|subj"))


##### STEP 3 ####

### PLease note that I already added the column names (i.e., "descriptive activity names") in step 1. 
### I thought that was much easer than matching the names later


#### STEP 4 #####

# I'm reading in the data set containing the actual labels of the activities (WALKING etc)

activity_labels <- read.table("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset/activity_labels.txt",
                              col.names = c("activity_num", "activity_label"))


# now "merge" the data set containing the activities only as numbers with the one also containing the labels
df2 <- merge(df_short, activity_labels, by = "activity_num")
df2$activity_num <- NULL  # deleting the numerical one

df3 <- df2  %>%    # reordering colums so that subject and acticity in the beginning
    select(subj, activity_label, everything())


##### STEP 5 #####

tidy <- df3  %>% 
    group_by(subj, activity_label) %>%
    summarise_each(funs(mean))
tidy

