####### WEEK 6 WORKSHEET - missing data #######

library(data.table)
library(JWileymisc)
library(mice)
library(VIM)
library(ggplot2)

# Load in the daily diary dataset (multiple surveys per person)
dd <- as.data.table(???("???"))

# When you have lots of variables, it's hard to get the pattern plots
# to look useful. 

# Make a subset of dd called dd_sub that has these variables: 
# SurveyDay, dSE, dMood, dStress, dEnergy, dLoneliness
??? <- ???[, .(???)]

# Now use the aggr() function on the subset to look at missing data patterns
# Hint: if the proportions are not showing up on the right hand side, 
# add this argument: 'cex.numbers = .8'. If variable labels don't show up,
# add: 'cex.axis = .8'

aggr(???)

# Which variables don't have any missing data? 

# A: 

# What percentage of the observations aren't missing any data?

# A:  

# Make a marginplot comparing missingness of dLoneliness to the values of dMood
???

# Does there seem to be much association?
# A: 

# To do MI, we have to make sure the class of all the variables are correct.
# Because they were imported from SPSS, they're all wrong. How do we change them?
???

### FROM HERE ONWARDS, ANSWERS WILL NOT BE UPLOADED, AS THEY ARE TOO SIMILAR 
### TO YOUR LAB REPORTS. I WILL HELP YOU IN CLASS BUT I CAN'T GIVE THE ANSWERS

# Multiply impute the dataset with 5 MI datasets and 30 iterations.
# Bonus: Make me get the same results if you were to give me the seed 666
mi.ddsub <- mice(
  ???)

## plot convergence diagnostics for dLoneliness
plot(???)

# use the with() and pool() functions to run a linear regression where 
# loneliness predicts mood
???
???

# For every one unit change in daily loneliness, 
# mood ___creased by ____ units, p _____

#A: 