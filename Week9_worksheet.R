######## WEEK 9 (LMM2) WORKSHEET ######## 

library(data.table)
library(JWileymisc)
library(extraoperators)
library(lme4)
library(lmerTest)
library(multilevelTools)
library(visreg)
library(ggplot2)
library(ggpubr)
library(haven)

## load data collection exercise data downloaded off github
## and placed in your R folder.
## merged is a a merged long dataset of baseline and daily
dm <- as.data.table(read_sav("[2021] PSY4210 merged.sav"))

# See if you can predict energy from between and
# within person stress including a random intercept and slope. Check
# diagnostics and try to solve any convergence or singularity issues you
# may run into (if you cannot solve them, try your best and detail what
# you tried). Make a conditional graph of your results.

# Here are the basic steps.

# 1. Create a between and within person stress variable
# 2. Since we know `visreg()` does not like haven labeled type
# variables, check if any of your stress variables or the `dEnergy`
# variable is haven labeled and if so, convert them to numeric.
# 3. Fit a LMM using `lmer()` with both `Bstress` and `Wstress` as fixed
# effects and a random intercept and random `Wstress` slope by ID.
# 4. Check model diagnostics and where appropriate remove extreme
# values.
# 5. Make a summary of the final model.
# 6. Use `visreg()` to make a marginal plot.


## 1. Create a between and within person stress variable

dm[, ??? := meanDeviations(???), ???] 

## 2. Since we know `visreg()` does not like haven labeled type
##    variables, check if any of your stress variables or the `energy`
##    variable is haven labeled and if so, convert them to numeric.

str(dm[, .(ID, dEnergy, ???      ) ])


## 3. Fit a LMM using `lmer()` with both `Bstress` and `Wstress` as fixed
##    effects and a random intercept and random `Wstress` slope by ID.

yourmodel <- ???(dEnergy ~  ???, ??? )

## 4. Check model diagnostics and where appropriate remove extreme
##    values (make these top and bottom 1% instead of the default).

yourdiag <- modelDiagnostics(???, ??? = ???)
plot(???, ncol = ???, nrow = ???, ask = FALSE) # sometimes this takes awhile
# Q: Which plots show the distributions of random effects?


# Look at a list of the extreme values:
yourdiag$???

# Drop all extreme values, regardless of effect type
dm.noev1 <- dm[-unique(yourdiag$extremeValues$???)]
# Q: How can you check if this new dataset has less observations?


# Bonus 1: Drop only the ID that seems to have the most extreme values
dm.noev2 <- dm[ID %nin% ???]
# Q: How many observations were dropped that time? Does that make sense?


# Bonus 2: Drop only the extreme values that are MVN outliers.
dm.noev3 <- dm[-unique(yourdiag$extremeValues[EffectType == "???"]$Index)]
# Q: What's the difference between dm.noev2 and dm.noev3? Why?


## 5. Make a summary of the final model. You choose which dataset to use.
yourmodel2 <- lmer(dEnergy ~  ???, ??? )
???(yourmodel2)

## 6. Use `visreg()` to make a marginal plot of energy on between stress.

visreg(???, xvar = "???",
       partial = FALSE, rug = FALSE,
       gg = TRUE,
       xlab = "???",
       ylab = "???",
       line = list(col = "black", size = 1)) + 
  theme_pubr()