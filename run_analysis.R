library(dplyr)

##### change your working directory to the directory where the UCI HAR Dataset is
setwd("C:/Users/Stefanie/Dropbox/Coursera/UCI HAR Dataset")

##### STEP 1 #####

# read in variables common to both data sets
#### I'm doing this here for brevity instead of in step 4

features <- read.table("features.txt")


# re-assemble full test data set ###

# read in main data, already name the colums appropriately using col.names
test <- read.table("test/X_test.txt", col.names = features$V2)
test$subj <- as.factor(scan("test/subject_test.txt"))
test$activity_num <- scan("test/y_test.txt")


# re-assemble full train data set ###

train <- read.table("train/X_train.txt", col.names = features$V2)
train$subj <- as.factor(scan("train/subject_train.txt"))
train$activity_num <- scan("train/y_train.txt")

# combine test and training data set

df <- rbind(test, train)


##### STEP 2 #####

df_short <- select(df, matches("mean|std|activity_num|subj"))


##### STEP 3 ####

### Please note that I already added the column names (i.e., "descriptive activity names") in step 1
### using col.names in the read.table function. I thought that was much easier than matching the
### names later.


#### STEP 4 #####

# I'm reading in the data set containing the actual labels of the activities (WALKING etc)

activity_labels <- read.table("activity_labels.txt",
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


### save data set so I can upload it to Github

write.table(tidy, file = "C:/Users/Stefanie/Dropbox/Coursera/Course4Assignment/tidy.txt", row.names = FALSE)

