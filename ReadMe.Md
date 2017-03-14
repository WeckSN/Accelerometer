## Step 1

As a first step I read all the features (tBodyAcc-mean()-X, ...) as a data frame. I know that the second column (V2) of this data frame are the descriptive names of the features, and that those will be the column names for the big data set.

Then, I re-assemble the train and test data set in the following way, here illustrated for test:

* Read the bulk of the data ("X_test.txt"), but already use the features *labels* from the very first step above as the column names (second column of "features.txt").
* Read in the corresponding subjects ("subject_test.txt"") as a vector (using scan) and turn it into a factor. Attach this vector directly as a column to the test data set.
* Do the same with the numerical values of the activities ("y_test.txt")

Once this is done for both train and test I rbind them together. That is, I just add all rows of train to test, since the columns (and their names!) are the same.


## STEP 2

I select only those columns that contain the string "mean" or "std", but I also select "activity_num" and "subj" because I need those for my groupings later.

## STEP 3
I already performed this step during step 1, when I used the features labels (column two of the feature.txt data frame) as the col.names for the train and test data frames.

## STEP 4

First, read in the features as a separate data frame. I know that the first column has the numbers (1-6), and the second one the corresponding labels (WALKING, WALKING_UP etc.)

Next, I "merge" my main data frame with this features data frame *by* the variable activity_num. What happens here is that every time there is a 3 (for example) in df_short, this merging step will add a column with the corresponding label (so for 3 that's WALKING_DOWNSTAIRS).

Then I delete the activity_num because we don't need it anymore now that we have the labels.

Lastly, I move the subject and activity_label variables to column 1 and 2 for better readability.

## STEP 5 
I'm using a dplyr chain to

1. group the data set by subject and activity
2. summarize each remaining variable by their mean

Lastly, I print the tidy data set for a sanity check.

## STEP 6

As the very last step I save the newly created, tidy data set as a txt file.

