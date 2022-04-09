####### WEEK 7 WORKSHEET - LMM Intro  #######

# Which library do we need for the read_sav function?
library(???) 

# Which library do we need to open the daily diary as a data table?
library(???) 

# Which three libraries did we need in the readings for mixed effect models?
library(???)
library(???)
library(???)

# You will also need:
library(JWileymisc)
library(visreg)
library(ggplot2)
library(ggpubr)
library(tufte)

# Set your working directory to the folder that has the DD dataset
setwd("???")

# Load in the daily diary dataset and convert it to a data table
dd <- ???(read_sav("???")) # daily diary

# Build a random intercept model predicting 'dEnergy'. 
m  <- ???(dEnergy ~ ? + (? | ?), data = dd)
summary(m)
# Q: On average, these people had an energy score of ____
# A: ???

# Bonus: find a second way in the code to just display the answer above:
???(m)

# Try to clean the within and between level of the variable:
#  `dEnergy` in the daily dataset with missing IDs removed, 
# `dd2`. 
# First, make a between (BEnergy) and within (WEnergy) variable of dEnergy:
dd[!is.na(ID), c("???", "???") := ???(dEnergy), by = ???]
head(dd[!is.na(ID), .(???, ???, ???, ID)])

# Second, assess distribution of within energy. 
# If needed, excluded rows / IDs (make extreme value threshold 0.5%). 
plot(testDistribution(dd[!is.na(ID)]$???,
                      extremevalues = "theoretical", ev.perc = ???),
     varlab = "???")

dd2 <- dd[!is.na(ID)]
testDistribution(dd2$???,
                 extremevalues = "theoretical", ev.perc = ???)$Data[isEV == "???"]

# Show and remove the outliers based on row number ("OriginalOrder"):
dd2[c(???, ???, ???, ???, ???, ???), .(dEnergy, BEnergy, WEnergy, SurveyDay, ID)]
dd.noev <- dd2[-c(???, ???, ???, ???, ???, ???)]

plot(testDistribution(???$???,
                      extremevalues = "theoretical", ev.perc = ???), 
     varlab = "???")

# Now recreate between and within levels of energy on the dataset 
# without extreme within values.
???[, c("???", "???") := ???(dEnergy), by = ???]

# Make a dataset with only one row of data per person to clean the between level
dd.b <- ???[!duplicated(ID)]

# Examine the distribution of the between level and remove any outliers/IDs
plot(testDistribution(dd.b$???,
                      extremevalues = "theoretical", ev.perc = ???),
     varlab = "???")

testDistribution(dd.b$???,
                 extremevalues = "theoretical", ev.perc = ???)$Data[isEV == "???"]
dd.b[c(???), .(dEnergy, BEnergy, WEnergy, SurveyDay, ID)]
dd.b.noev <- ???[-c(???)]
plot(testDistribution(???$???,
                      extremevalues = "theoretical", ev.perc = ???),
     varlab = "???")