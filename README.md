TidyData
========

This script assumes the source file is unzipped and the working directory has the folders test and train in it

1. Read in data from each file and combine into one big dataset
2. read in the column names
3. Make the column names more readable by setting to lower case and removing these characters: -,()
4. identify which columns to keep by finding only those that contain mean or std
5. Subset and keep only the columns identified in number 4 plus "Activity" and "Subject"
6. Add activity names to dataset by merging on Activities column and get rid of activity number
7. Melt dataset to get the means of each column based on subject
8. Write table to TidyData.txt as a tab delimited file

