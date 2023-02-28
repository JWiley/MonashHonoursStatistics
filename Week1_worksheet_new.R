#### 1. Basic R Use ####

## use R as a calculator
3 + 4 # addition

2 * 6 # multiplication

4 / 2 # division

2^3 # powers

## create a vector
c(1, 5, 4)

## assign results to an object
## note that after it is assigned, it shows up in RStudio in the "Environment"
x <- c(1, 3, 5)

## view an existing object
x

## round data (helpful for reporting)
## the first argument is the number to round
## the second argument is how many digits to use for rounding
round(1.214294254, digits = 2)

#### 2. Descriptive Statistics ####

## calculate the mean
## note that we reuse the previously assigned variable, x
mean(x)

## calculate the median
median(x)

## calculate the standard deviation
sd(x)

## minimum
min(x)

## maximum
max(x)

## if there are missing values, R will not calculate
## to see this, lets first create an object with some missing data
## we will call it "y"
## NA stands for Not Available, i.e., missing
## If we want the vector to have the numbers 1, 3, missing, then 7, 
## what would we fill in the ??? with here?
y <- c(1, 3, NA, 7)

## calculate mean on y
mean(y)

## Why didn't that work? We need to tell R
## to remove missing values first
## (na for not available; rm for remove)
## by adding an argument, na.rm = TRUE
mean(y, na.rm = TRUE)

#### 2b. You Try It ####

## find the mean of these numbers: 5, 3, 2, 9, 1
mean(c(5,3,2,9,1))
  
## find the standard deviation of the variable "y"
sd(y, na.rm = TRUE)

#### 3. Using a Dataset ####

## R has a built in dataset called "mtcars"
## this dataset has variables on about 32 different cars

## view the dataset
View(mtcars)

## one the variables in the dataset is how many
## miles per gallon of petrol each car gets
## this variable is called "mpg"
## to access the variable from within the mtcars dataset
## we use the "$" operator
## the code below accesses and prints all the observations
## from the mpg variable
mtcars$mpg

## note what happens if the case is wrong
## because a variable called "Mpg" does not exist
## R return NULL indicating no data
mtcars$Mpg

## it is also possible to round an entire set of numbers
round(mtcars$mpg, digits = 0)


#### 3b. You Try It ####
## calculate descriptive statistics (mean, standard deviation) of the 
## variable mpg
mean(mtcars$mpg)
sd(mtcars$mpg)

## How do you get a summary of a whole dataset? Use google or the ? function
summary(mtcars)

#### 4. Loading Data ####

## to start with, we will load a package for data management.
## Loading a package/library is like opening an app
## and you need to repeat this process each time you start up R
## note that if this does not work, try to install it first
## by uncommenting the install packages code

# install.packages("data.table", dependencies = TRUE)
library(data.table)

## import CSV - first insert your working directory instead of mine
setwd("C:/Users/miche/Documents/git_repos/MonashHonoursStatistics")
d <- read.csv("IntroR_sample.csv")

d <- IntroR_sample


## YOU TRY IT: get a summary of the data
summary(d)


#### 5. Logical Operators ####

## "==" : logical test if Depressed is equal to 1
d$Depressed == 1

## ">" : logical test whether zStress is greater than 0
d$zStress > 0

## "|" : logical "or"; test whether either condition is TRUE
## depressed or high stress
d$Depressed == 1 | d$zStress > 1

## "&" : logical "and"; test whether both conditions are TRUE
## depressed and low stress
d$Depressed == 1 & d$zStress < 1

## we can use square brackets, [], to subset a variable or dataset
## we can subset by number or by logical value.
## here are all the values for zStress
d$zStress

## here is just the first and third value
d$zStress[c(1, 3)]

## YOU TRY IT: What is the 10th value?
d$zStress[10] #(don't need to use c() if only one value)

## here are just the values of zStress where Depressed == 1
d$zStress[d$Depressed == 1]

## here are just the values of zStress where zStress > 1
d$zStress[d$zStress > 1]
