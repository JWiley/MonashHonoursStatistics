##### WEEK 11 WORKSHEET #####
# Compare across several models to select the best model.

library(data.table)
library(JWileymisc)
library(extraoperators)
library(lme4)
library(lmerTest)
library(multilevelTools)
library(haven)
setwd(???)
dm <- ???

# Build a linear (m1) and quadratic (m2) model predicting daily stress from daily 
# loneliness, as well as one alternative model (malt) predicting daily stress from 
# daily self-esteem, all with random intercepts

dm[, dStress := as.numeric(dStress)]
dm[, dLoneliness := as.numeric(dLoneliness)]
dm[, dSE := as.numeric(dSE)]
dm <- dm[!is.na(dLoneliness)] # the poly() function does not work with missing data :(

m1 <- lmer(??? ~ poly(???, ???) + (???), data = ???, REML = ???)
m2 <- lmer(??? ~ poly(???, ???) + (???), data = ???, REML = ???)
malt <- lmer(??? ~ ??? + (???), data = ???, REML = ???)

# Check the number of observations across all models are the same
???(m1)
???(m2)
???(malt)

# What to do if nobs is different??
???


  
  
  
  
  

# Use LRTs for nested models. Are they different?
???(???, ???, test = "???")

# Use AIC and BIC for all. Which model would you choose?
AIC(???, ???, ???)
BIC(???, ???, ???)
