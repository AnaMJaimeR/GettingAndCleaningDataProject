                                      GETTING AND CLEANING DATA COURSE PROJECT
                                               Ana María Jaime Rivera

The main objective of this project is to demonstrate my ability to
collect, work with, and clean a data set. In order to do this, I have
prepared a final independent tidy data set, which can be use in the
future for later analysis. This database has been reshaped in order to
meet the tidy format requirements:

-   Each variable forms a column
-   Each observation forms a row
-   Each table stores data with the same kind of observations

The data I work with represent data collected from the accelerometers
from the Samsung Galaxy S smartphone. The original dataset used here,
and further information about it can be found in:

"<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>"

This repository 'GettingAndCleaningDataProject' contains 3 main files
---------------------------------------------------------------------

-   CodeBook.md
-   run\_analysis.R
-   ind\_tidy\_data.txt

### 1. 'CodeBook.md'

This .md file contains a comprenhensive description of the data,
variables, variables names, units and transformation process for both,
the 'tidy\_data' and the 'ind\_tidy\_data' sets. It is specially useful
in order to understand the structure of variable names and the logic of
the transformation process.

Note that it does not contain explicit parts of the code, just the main
results. Therefore, for anyone interested in understanding the code in
detail the 'run\_analysis.R' file is the perfect complement. Both files
should be used simultaneosuly in order to fully understand both, the new
database structure and the R coding used to get there.

### 2. 'run\_analysis.R'

This R Script contains the code used in order to create the final
'ind\_tidy\_data' set. It does the following transformations to the
original datasets:

-   Merges the training and test sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation
    for each measurement.
-   Uses descriptive activity names to name the activities in the
    data set.
-   Appropriately labels the data set with descriptive variable names.

--Result: 'tidy\_data'--

-   From the resulting database, creates a second, independent tidy data
    set with the average of each variable for each activity and
    each subject.

--Result: 'ind\_tidy\_data'--

The code comments each step of the transformation process in detail. It
is easily reproducible after adjusting the working directory.

For further information on the data structure and final notes please go
to the 'CodeBook.md' file.

### 3. 'ind\_tidy\_data.txt'

This .txt file contains the final independent tidy dataset obtained
after running the code contained in the 'run\_analysis.R' file.
Specifically, the base contains 180 obs. (30 subjects, each one
performing 6 different activities) of 68 variables (subject, activity
and 66 measurement variables). In this way, the final tidy data
summarizes the average of each measurement variable by each activity and
subject.
