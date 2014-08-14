library(memisc) #Library which can automate codebook generation

# Creating data.set using our tidySet
Data <- data.set(
  tidySet
)

# By default data.set create member name with 'tidySet' prefixed
# We are resetting member with tidySet's name
names(Data) = colnames(tidySet)


# Now we will set description of each member. 

# Replacing all short form except mean and std with full form
# Removing mean and std as we have to add it in fornt
mapping = data.frame(pattern = c('^f', '^t', 'Body', 'Acc', 'Gyro', 'Gravity',
                                 'Jerk', 'Mag','_mean', '_std', '_X', '_Y', '_Z'),
                     replacement = c('frequency of ', 'time of ', 'body ', 
                                     'accelerometer ', 'gyroscope ', 'gravity ', 
                                     'jerk ', 'magnitude ', '', '', 'on X-axis',
                                     'on Y-axis', 'on Z-axis'))

colNames = colnames(tidySet)      # Getting current columns names
colNames1 = colNames              # Creating one more copy 
for( x in seq_len(nrow(mapping))){
  colNames1 = gsub(pattern = mapping$pattern[x], 
                   replacement = mapping$replacement[x], x = colNames1)
}
#Attaching mean and std full form in front
colNames1[grepl(glob2rx('*_mean_*'),colNames)] = paste0('mean of ', colNames1[grepl(glob2rx('*_mean_*'),colNames)])
colNames1[grepl(glob2rx('*_std_*'),colNames)] = paste0('standard deviation of ', colNames1[grepl(glob2rx('*_std_*'),colNames)])

colNames = colNames1
rm(colNames1, mapping, x)

descp =  colNames
descp[1] = 'subject who carried out the experiment'
descp[2] = 'activity of subject'

# Setting description of all tags at a time
Data <- within(Data,{
  i = 1
  description(subject                      ) = descp[i];i <- i+1
  description(activity_desc                ) = descp[i];i <- i+1
  description(tBodyAcc_mean_X              ) = descp[i];i <- i+1
  description(tBodyAcc_mean_Y              ) = descp[i];i <- i+1
  description(tBodyAcc_mean_Z              ) = descp[i];i <- i+1
  description(tBodyAcc_std_X               ) = descp[i];i <- i+1
  description(tBodyAcc_std_Y               ) = descp[i];i <- i+1
  description(tBodyAcc_std_Z               ) = descp[i];i <- i+1
  description(tGravityAcc_mean_X           ) = descp[i];i <- i+1
  description(tGravityAcc_mean_Y           ) = descp[i];i <- i+1
  description(tGravityAcc_mean_Z           ) = descp[i];i <- i+1
  description(tGravityAcc_std_X            ) = descp[i];i <- i+1
  description(tGravityAcc_std_Y            ) = descp[i];i <- i+1
  description(tGravityAcc_std_Z            ) = descp[i];i <- i+1
  description(tBodyAccJerk_mean_X          ) = descp[i];i <- i+1
  description(tBodyAccJerk_mean_Y          ) = descp[i];i <- i+1
  description(tBodyAccJerk_mean_Z          ) = descp[i];i <- i+1
  description(tBodyAccJerk_std_X           ) = descp[i];i <- i+1
  description(tBodyAccJerk_std_Y           ) = descp[i];i <- i+1
  description(tBodyAccJerk_std_Z           ) = descp[i];i <- i+1
  description(tBodyGyro_mean_X             ) = descp[i];i <- i+1
  description(tBodyGyro_mean_Y             ) = descp[i];i <- i+1
  description(tBodyGyro_mean_Z             ) = descp[i];i <- i+1
  description(tBodyGyro_std_X              ) = descp[i];i <- i+1
  description(tBodyGyro_std_Y              ) = descp[i];i <- i+1
  description(tBodyGyro_std_Z              ) = descp[i];i <- i+1
  description(tBodyGyroJerk_mean_X         ) = descp[i];i <- i+1
  description(tBodyGyroJerk_mean_Y         ) = descp[i];i <- i+1
  description(tBodyGyroJerk_mean_Z         ) = descp[i];i <- i+1
  description(tBodyGyroJerk_std_X          ) = descp[i];i <- i+1
  description(tBodyGyroJerk_std_Y          ) = descp[i];i <- i+1
  description(tBodyGyroJerk_std_Z          ) = descp[i];i <- i+1
  description(tBodyAccMag_mean             ) = descp[i];i <- i+1
  description(tBodyAccMag_std              ) = descp[i];i <- i+1
  description(tGravityAccMag_mean          ) = descp[i];i <- i+1
  description(tGravityAccMag_std           ) = descp[i];i <- i+1
  description(tBodyAccJerkMag_mean         ) = descp[i];i <- i+1
  description(tBodyAccJerkMag_std          ) = descp[i];i <- i+1
  description(tBodyGyroMag_mean            ) = descp[i];i <- i+1
  description(tBodyGyroMag_std             ) = descp[i];i <- i+1
  description(tBodyGyroJerkMag_mean        ) = descp[i];i <- i+1
  description(tBodyGyroJerkMag_std         ) = descp[i];i <- i+1
  description(fBodyAcc_mean_X              ) = descp[i];i <- i+1
  description(fBodyAcc_mean_Y              ) = descp[i];i <- i+1
  description(fBodyAcc_mean_Z              ) = descp[i];i <- i+1
  description(fBodyAcc_std_X               ) = descp[i];i <- i+1
  description(fBodyAcc_std_Y               ) = descp[i];i <- i+1
  description(fBodyAcc_std_Z               ) = descp[i];i <- i+1
  description(fBodyAccJerk_mean_X          ) = descp[i];i <- i+1
  description(fBodyAccJerk_mean_Y          ) = descp[i];i <- i+1
  description(fBodyAccJerk_mean_Z          ) = descp[i];i <- i+1
  description(fBodyAccJerk_std_X           ) = descp[i];i <- i+1
  description(fBodyAccJerk_std_Y           ) = descp[i];i <- i+1
  description(fBodyAccJerk_std_Z           ) = descp[i];i <- i+1
  description(fBodyGyro_mean_X             ) = descp[i];i <- i+1
  description(fBodyGyro_mean_Y             ) = descp[i];i <- i+1
  description(fBodyGyro_mean_Z             ) = descp[i];i <- i+1
  description(fBodyGyro_std_X              ) = descp[i];i <- i+1
  description(fBodyGyro_std_Y              ) = descp[i];i <- i+1
  description(fBodyGyro_std_Z              ) = descp[i];i <- i+1
  description(fBodyAccMag_mean             ) = descp[i];i <- i+1
  description(fBodyAccMag_std              ) = descp[i];i <- i+1
  description(fBodyBodyAccJerkMag_mean     ) = descp[i];i <- i+1
  description(fBodyBodyAccJerkMag_std      ) = descp[i];i <- i+1
  description(fBodyBodyGyroMag_mean        ) = descp[i];i <- i+1
  description(fBodyBodyGyroMag_std         ) = descp[i];i <- i+1
  description(fBodyBodyGyroJerkMag_mean    ) = descp[i];i <- i+1
  description(fBodyBodyGyroJerkMag_std     ) = descp[i];i <- i+1
})

# Generating codebook
finalCodeBook = codebook(Data)

# Writing codebook to file txt as well as md
capture.output(finalCodeBook, file = 'CodeBook.txt')
capture.output(finalCodeBook, file = 'CodeBook.md')

rm(finalCodeBook, Data, descp, colNames)