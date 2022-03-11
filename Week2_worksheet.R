library(data.table)
library(reshape2)

library(extraoperators)

### 1. Vectors ###

## First let's remember how we create vectors
## Assign a vector with the numbers 8, 3, 5, and 6 to an object called v
???

## view my_vector
v

## How would you add 2 to every element of v?
??? 

### 2. Loading datasets ###

## Let's load the aces_daily dataset, which is built into a package. 
## Try loading aces_daily now.

## Hint: What do we need to do first before accessing it?
???
## Hint 2: load it, then change it to a data table
???
???


### 3. Subsetting and Operators ###

## Try making a new dataset from aces_daily that only includes
## observations from people who were born in Australia
d_aus <- ???
 

## Now make a new dataset of observations that are only "medium" amounts
## (i.e., not too high or not too low) of STRESS. You get to decide what 
## counts as "medium".
d_medstress <-???
 

## select only low stress (STRESS less than 2) observations from people
## who were born in Australia
d_aus_lowstress <- ???
 

## Make your own subset of observations based on any rules,
## using an operator you haven't tried yet
???

## Try a big one - Subsetting
  # Remember that we use ! and is.na for not missing
  # Remember that we can create a new column called count and assign it a sample size
  # Remember that we can chain operations
  
## Select observations where:
  
#  - positive affect, in the dataset, called `PosAff` is not missing
#  - participants who have **at least 20** non missing positive affect (any value)
#  - where positive affect scores are greater than or equal to 3

#  You should end up with 2,455 observations.

d3 <- ???
d3[, .(UserID, PosAff)] 

### 4. Dates ###

## Now you try to convert the following character strings into date class
## objects in `R` by filling in the correct template in quotes for the
## `format = ` argument. If you do it incorrectly, you will get errors or
## `NA` indicating the text could not be converted to a date using the
## template you supplied. 


y1 <- c("5/28/2018", "6/30/2019")
??? ## you complete

y2 <- c("28 01 2018", "15 06 2019")
dy2 <- ??? ## you complete
dy2 ## show results

y3 <- c("28-1-18", "15-6-19")
??? ## you complete

## how many days are there between 
## 28 January 2018 and 15 June 2019?
## use the object dy2 to complete like 
## we did above
???

## Subset Dates
## try to create a dataset that excludes any weekend days.

## If you have forgotten what the weekdays() function does,
## try > ?weekdays in the console
## Hint: You may need to review your list of operators
d4 <- ???

## Check: there should now be no surveys on weekend days
table(weekdays(d4$SurveyDay))

### 5. Factors ###

## Now try using factors for dummy coding. In aces_daily,
## there is a variable, SurveyInteger. 1 = morning, 2 = afternoon,
## 3 = evening. Make it a factor and then create a frequency table 
## using `table()`.

## Hint: Use the := operator to create a new column called "SurveyIntegerF"

???
 
 
 

table(d$SurveyIntegerF)


### 6. Merging ###
## Here are two datasets shown as tables.

ds1 <- data.table(
  ID = c("A1", "B2", "C3"),
  Stress = c(4, 5, 6))
ds1

ds2 <- data.table(
  ID = c("A1", "B2", "D4", "E5"),
  Steps = c(9524, 15303, 7432, 4035))
ds2

# Before you try joining those datasets, try to answer these
# questions, which are similar to what might be on the exam. 
# For these questions, `ds1` is the "left"
# dataset and `ds2` is the "right" dataset and you are joining by ID.

# Q: How many rows would occur in a **natural join** of `ds1` and
# `ds2`? How many missing values total across all
# variables?
  
# A: 
# 
# 
# 
# 
# 

# Q: How many rows would occur in a **full outer join** of `ds1` and
# `ds2`? How many missing values total across all
# variables?

# A: 
# 
# 
# 
# 
# 
  
#  Q: How many rows would occur in a **left outer join** of `ds1` and
# `ds2`? How many missing values total across all variables?

# A: 
  
#  Q: How many rows would occur in a **right outer join** of `ds1` and
# `ds2`? How many missing values total across all variables?
  
# A: 


## using the datasets ds1 and ds2, do a natural join
???
 
 
 
 

## using the datasets ds1 and ds2, do a full outer join
???
  
  
  
  

## using the datasets ds1 and ds2, do a left outer join
???
  
  
  
  

## using the datasets ds1 and ds2, do a right outer join
???
  
  
  
  

### 7. Duplicates ###

## Using aces_daily:
  
## Count how many unique IDs there are
length(???)

## Create a frequency table of the number of times `UserID` is
## duplicated.
table(???)

## Check if there are duplicates if you use both `UserID` and
## `SurveyDay` to create a combined ID.
## Hint: Use subsetting and the c() function
???

## Check if there are duplicates if you use `UserID` and `SurveyDay`
## and `SurveyInteger`.
???

### 8. Reshape ###

## Using this dataset, you try reshaping a WIDE dataset into a LONG format.

dwtry <- data.table(
  Name = c("Jane", "John"), 
  SLEEP1 = c(2, 1),
  SLEEP2 = c(4, 5),
  Dep1 = c(4, 5),
  Dep2 = c(3, 2),
  Dep3 = c(5, 5))

# Hint: How many time points do we have for each variable?

dwtry[???]

dltry <- ???
 
 
 
 
 
 
 
 
 

print(dltry)

## Now reshape `dltry` from LONG back to WIDE.

???
 
 
 
 
 
 


### 9. Merging by Multiple IDs ###

## Let's say that one participant had technical problems with the surveys
## from the daily data we have worked with and so filled out the last few
## on paper and pencil. Now we want to merge this data into our master
## daily dataset, `d` (i.e., aces_daily), using a *full outer join*. 
## The resulting dataset, `d6` should have 6,602 rows.

pencil <- data.table(
  UserID = 1L,
  SurveyDay = as.Date("2017-3-08"),
  SurveyIntegerF = as.factor(c("Morning", "Afternoon", "Evening")),
  STRESS = c(1, 3, 1))


## Now merge into a new object called d6
d6 <- ???
 
 

## How many of you ended up with two STRESS (.x and .y) variables in d6?
## This happens when two data tables share a variable that isn't dealt with
## How can you fix this?
d6 <- ???
 
 
