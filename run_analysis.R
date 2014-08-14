library(data.table)     # Library requied for code


###############################################################################
###############################################################################
##   Part 1 - Merges the training and the test sets to create one data set   ##
###############################################################################

# First we will read activity and features files
# which will be needed for mapping.
setwd('UCI HAR Dataset')                  # Set Directory
feature = fread('features.txt')           # Read features file
activity = fread('activity_labels.txt')   # Read activity labels


########################    Reading Test Directory      ########################
setwd('..')                               # Going back to parent dir
setwd('UCI HAR Dataset/test')             # Going to test dir

# Finding all files with .txt extention
testfilenames = list.files(pattern = '*.txt', recursive = TRUE)

# Extracting only name part i.e. removing prefix or postfix tags
testvariablenames = gsub(pattern = 'Inertial Signals/|_test.txt', replacement = '', testfilenames)

# Reading all files in one go and creating list of tables
test_reading = lapply(testfilenames,read.table)

# Setting Name of each table as their variable/file name
names(test_reading) = testvariablenames

# Converting all tables from data.frame to data.table
test_reading = lapply(test_reading,data.table)

# Converting all tables' column name to appropreite name
for(i in seq_len(length(test_reading))){
  if(ncol(test_reading[[i]])>1){
    setnames(test_reading[[i]], colnames(test_reading[[i]]),
             paste(testvariablenames[i],seq_len(ncol(test_reading[[i]])),sep = '_'))
  }else setnames(test_reading[[i]], colnames(test_reading[[i]]),
                 testvariablenames[i])
}

##################### Important for Part 4 #####################
# Setting Variable Names as Description given in feature file  #
X_test <- test_reading[['X']]
setnames(X_test, colnames(X_test), feature$V2)
X_test -> test_reading[['X']]

# Setting Y variable as activity 
Y_test <- test_reading[['y']]
setnames(Y_test, colnames(Y_test), 'activity')
Y_test -> test_reading[['y']]

# Removing names of list member to make sure that bulk cbind
# won't prefix of their names with actual table's column name
names(test_reading) = NULL

# Bulk cbind
test_reading = do.call('cbind', test_reading)

# Removing unnecessary variables
rm(X_test, i, testfilenames, testvariablenames, Y_test)

setwd('../..')                                # Going back to parent dir


######################  Reading Train Directory     ########################

setwd('UCI HAR Dataset/train')                # Going to train dir

# Finding all files with .txt extention
trainfilenames = list.files(pattern = '*.txt', recursive = TRUE)

# Extracting only name part i.e. removing prefix or postfix tags
trainvariablenames = gsub(pattern = 'Inertial Signals/|_train.txt', replacement = '', trainfilenames)

# Reading all files in one go and creating list of tables
train_reading = lapply(trainfilenames,read.table)

# Setting Name of each table as their variable/file name
names(train_reading) = trainvariablenames

# Converting all tables from data.frame to data.table
train_reading = lapply(train_reading,data.table)

# Converting all tables' column name to appropreite name
for(i in seq_len(length(train_reading))){
  if(ncol(train_reading[[i]])>1){
    setnames(train_reading[[i]], colnames(train_reading[[i]]),
             paste(trainvariablenames[i],seq_len(ncol(train_reading[[i]])),sep = '_'))
  }else setnames(train_reading[[i]], colnames(train_reading[[i]]),
                 trainvariablenames[i])
}

##################### Important for Part 4 #####################
# Setting Variable Names as Description given in feature file  #
X_train <- train_reading[['X']]
setnames(X_train, feature$V2)
X_train -> train_reading[['X']]

# Setting Y variable as activity 
Y_train <- train_reading[['y']]
setnames(Y_train, 'activity')
Y_train -> train_reading[['y']]

# Removing names of list member to make sure that bulk cbind
# won't prefix of their names with actual table's column name
names(train_reading) = NULL

# Bulk cbind
train_reading = do.call('cbind', train_reading)

# Removing unnecessary variables
rm(X_train, Y_train, i, trainfilenames, trainvariablenames)

setwd('../..')                                # Going back to parent dir


##############     Merging Test and train dataset     ##############
reading = rbindlist(list(test_reading, train_reading))

rm(test_reading, train_reading)   # Removing unnecessary variables
gc()                              #Calling garbage collector


###############################################################################
##   Part 1 - Completed. 'reading' is merged dataset asked in question         ##
###############################################################################
###############################################################################



###############################################################################
###############################################################################
##   Part 2 - Extracts only the measurements on the mean and standard        ##
##            deviation for each measurement.                                ##
###############################################################################

colNames = colnames(reading)          # Finding all column names of dataset

# Finding out only those names which has substring mean() or std() in it
# Here glob2rx create regular expression for grepl and grepl will 
# find out which variable name matches that pattern
colMeanStd = colNames[grepl(pattern = paste(glob2rx('*mean()*'),glob2rx('*std()*'),sep='|'), colNames)]

# Subsetting only required column (i.e. mean, std, subject, activity)
reading_req_col = reading[,c(colMeanStd, 'subject', 'activity'), with = FALSE]

rm(colNames, colMeanStd)              # Removing unnecessary variable

###############################################################################
##   Part 2 - Completed. 'reading_req_col' has required columns only.        ##
###############################################################################
###############################################################################




###############################################################################
###############################################################################
##   Part 3 - Uses descriptive activity names to name the activities         ##
##            in the data set                                                ##
###############################################################################

# Setting column names of activity table for unambiguous merge
setnames(activity, c('V1','V2'), c('activity','activity_desc'))

# Merging dataset generagted in Part-2 with activity table
reading_withActivity = merge(x = reading_req_col, y = activity, by = 'activity')

# Removing activity code coloumn
reading_withActivity[,activity := NULL]

###############################################################################
##   Part 3 - Completed. 'reading_withActivity' has required columns only.   ##
###############################################################################
###############################################################################




###############################################################################
###############################################################################
##   Part 4 - Appropriately labels the data set with descriptive             ##
##            variable names.                                                ##
###############################################################################

##  As noted in part-1 we have already set column names to features
##  so now we will do following
##  1. remove '()'
##  2. replace '-' with '_' 

colNames = colnames(reading_withActivity)   # Finding all column names of dataset

# Replacing '-' with '_'
colNames = gsub(pattern = '-', replacement = '_', colNames)

# Removing '()' 
colNames = gsub(pattern = '\\(\\)', replacement = '', colNames)

# Updating column names with new names
setnames(reading_withActivity, colnames(reading_withActivity), colNames)

rm(colNames)                            # Removing unnecessary variable

###############################################################################
##   Part 4 - Completed. Columns properly named for 'reading_withActivity'   ##
###############################################################################
###############################################################################




###############################################################################
###############################################################################
##   Part 5 - Creates a second, independent tidy data set with the           ##
##            average of each variable for each activity and each subject.   ##
###############################################################################

# Creating tidy dataset, description is given as below
tidySet = 
  reading_withActivity[, lapply(.SD, mean),   # apply mean to all column mentiond with .SDCols
                       by = list(subject,activity_desc), # Group by subject and activity_desc
                       .SDcols=1:66]        # fisrt 66 coloums are varibles

# Writing tidy dataset to tidySet.txt file
write.table(tidySet, file = 'tidySet.txt', row.names = FALSE)

###############################################################################
##   Part 5 - Completed. tidySet is required table. Saved in current dir     ##
##            with 'tidySet.txt' name.                                       ##
###############################################################################
###############################################################################

# Cleaning up memory. And calling garbage collector
rm(reading, reading_req_col, feature, activity)
gc()