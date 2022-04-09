######### WEEK 8 WORKSHEET - LMM 1 #########

library(data.table)
library(JWileymisc)
library(lme4)
library(lmerTest)
library(multilevelTools)
library(visreg)
library(ggplot2)
library(ggpubr)
library(haven)

## Set your working directory to the folder that has the datafiles.
## "Merged" is a a merged long dataset of both baseline and daily diary
dm <- as.data.table(read_sav("[2021] PSY4210 merged.sav"))

# Make a descriptive statistics table for the following variables:

# relsta (measured baseline only; categorical)
# openness (measured baseline; continuous)
# agreeableness (measured baseline; continuous)
# dEnergy (measured daily; continuous, create average levels)
# Int_Fam (measured daily; categorical)

dm[, c("???", "???") := meanDeviations(???), by = ???]

desc1 <- egltable(c("???", "???", "???", "???"),
                  data = dm[!duplicated(ID)], strict = FALSE)
desc2 <-   egltable(c("???"), data = dm, strict = FALSE)
setnames(desc1, c("", "M (SD)/N (%)"))
setnames(desc2, c("", "M (SD)/N (%)"))
rbind(desc1, desc2)

# Intercept only model:
dm[, dEnergy := as.numeric(dEnergy)]

# Like last week, fit a random intercept model predicting 'dEnergy'. 
## store the model results in an object called "m2lmm" 
# (hint we did this in the worksheet last week)
m2lmm <- ???(??? ~ ??? + (??? | ???), data = ???)

## now make a summary of the model results
???(m2lmm)

## look at model diagnostics here
plot(???(???), ncol = 2, nrow = 2, ask = FALSE)

###### ANSWERS BELOW WILL NOT BE GIVEN AS THEY'RE TOO SIMILAR TO LAB REPORT

## what is the intraclass correlation coefficient for this dEnergy?
???("???", id = "???", data = ???)

# Fill in the blanks:
# About ____% of the total variance in energy was between people and the 
# other ____% is within person due to ________________.


# Fit a model predicting energy from a random intercept
# and the fixed effect of daily anxiety (dANX). Include a summary and CIs.
m3lmm <- ???(??? ~ ??? + (??? | ???), data = ???)
summary(???)
confint(???, method = "profile", oldNames = FALSE)

# Fill in the blanks:

# To examine the association of ____ and ____, a linear mixed model was fit. 
# The final model included ____ energy scores from ____ people.
# The fixed effect intercept revealed that the average [95% CI] energy when 
# anxiety is 0 was ____ [____, ____]. However, there were individual 
# differences, with the standard deviation for the random intercept being 
# ____ indicating that there are individual differences in the mean energy. 
# Assuming the random intercepts follow a normal distribution, we expect most 
# people to fall within one standard deviation of the mean, which in these data 
# would be somewhere between: ____, ____. 
# Using Satterthwaite's approximation for degrees of freedom revealed that 
# anxiety ____ statistically significantly associated with energy (p ____). 
# On average across people, a one unit higher anxiety score was associated 
# with ____ __crease in energy scores



