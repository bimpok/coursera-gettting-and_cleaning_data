#Following steps describes the operation performed inside run_Analysis.R scritp.

The run_analysis.R script performs the following:

1. It reads X, Y and Subject training and test data sets as shown below:

For X sets:
Training: Xtrnset
Test: Xtstset

For T sets:
Training: Ytrnset
Test: Ytstset

For Subject sets:
Training: Subjtrnset
Test: Subjtstset

In addition, Activities labels and features data sets are extracted to acctlabels and feat data sets respectively.

2. It then merge the respective data sets into one data set:

XSet, for x sets
YSet, for y sets
SubjSets, for Subject sets

3. Then the column index for required data (mean and standard deviation) are saved in a variable index_for_mean_or_sd.
4. XSet is then trimmed to only contain columns having mean and standard devitation data using the indexes extracted above.
5. XSet columns are then renamed using the the names in the feat data frame for the indexes on the index_for_mean_or_sd list.
6. YSet values are set with the corresponding name in the 2nd column of actlbls data frame matching the value with its first column. The resultant is a single column data frame and the column is then renamed to "activity".
7. SubjSet column name reanamed to "Subject".
8. Next inside a for each loop, for each subject area and each activity, a new data frame is appended with the average of each measurement activity and subject.
9. The resulting data set is a tidy data set with the average of each variable and each subject area and is saved in a text file names "final_data_set.txt".
