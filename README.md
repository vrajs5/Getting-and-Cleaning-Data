### Getting and Cleaning Data - Project Assignment
#### Author: Vishnu Chevli
- - - 

### Steps to reproduce tidy dataset
 1. Keep 'run_analysis.R' and 'UCI HAR Dataset' - folder in same location. 
    If you don't have 'UCI HAR Dataset' folder download zip file from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Unzip the file to same location where 'run_analysis.R' file is present.
 2. Run source('run_analysis.R')
 3. Output file is 'tidySet.txt' in same folder as R script

** Input to script ** - Folder "UCI HAR Dataset" with all files provided for assigment.  

** Output of script ** - "tidySet.txt"" file

- - - 

- - - 

### Regarding code book
 1. I have already uploaded CodeBook in 3 different format (CodeBook.md, CodeBook.txt & CodeBook.html) Use one which is convenient to you.
 2. I have also created a R script to generate codebook from my tidy dataset. Script name is **'CodeBook-Generation.R'**
 3. Run this file using source('CodeBook-Generation.R') after 'run_analysis.R'. It will use in-memory object tidySet to create code book.