#### 1. Setup (You Try It) ####

## to start with, we will load a package for data management
## and load a package for fitting Linear Mixed effects Models (LMMs)

## recall that loading a package is like opening an app
## and you need to repeat this process each time you start up R
## if everything installed successfully already
## this code should work and return no errors
## if this does not work, try to install it first
## by uncommenting the install packages code

# install.packages("data.table", dependencies = TRUE)
# install.packages("lme4", dependencies = TRUE)
# install.packages("ggplot2", dependencies = TRUE)
# install.packages("visreg", dependencies = TRUE)
library(data.table)
library(lme4)
library(ggplot2)
## new package, makes interaction graphs easy
## if not installed, uncomment and run the install packages for visreg above
library(visreg)

## load the data (note this is already an R dataset)
## so we use a new function readRDS()
## make sure that the data file is located in
## your project directory
d <- readRDS("aces_daily_sim_processed.RDS")

## see the dimenions of the data (rows   columns)
## should be: 6927   56
dim(d)

## see the names of the variables in the dataset
names(d)


#### 1. Interpreting LMMs (Demonstration) ####

## basic LMM with random intercept and slope (correlated)
m.random <- lmer(PosAff ~ STRESS + (1 + STRESS | UserID), data = d)
summary(m.random)

confint(m.random) ## profile confidence intervals slow here
confint(m.random, method = "Wald") ## Wald faster if CIs for random effects not needed

## ## Sample Write up

## A total of 6,399 observations from 191 unique people were included
## in the analyses. Overall, when people were not experiencing stress, the model
## estimated their positive affect as b [95% CI] = 3.04 [2.93, 3.16].
## However, the random effects revealed substantial differences between
## individual (Random Effect SD = 0.81) such that although the average was 3.04, most people
## fell between 2.23 and 3.86 (i.e., 3.044085 +/- .81104).
## Examining the association of stress with positive affect, on average
## a one unit higher perceived stress score was associated with
## a -0.16 [-0.17, -0.15] difference in positive affect. Again, there were
## differences between individuals (Random effect SD = 0.08) with most people estimated
## to have an association between -0.24 and -0.08 (i.e., -0.160623 +/- 0.07855).
## The random intercept and stress slope were correlated at -0.64 indicating that
## people who had an above average intercept also tended to have a more negative
## association between stress and positive affect. This may indicate that people who are
## generally happier are more sensitive to the effects of stress on mood or
## conversely that people who are generally unhappy simply have less room to worsen
## in response to stress (a floor effect).

## we can check some of the ranges of random effects
## to get random effects with the fixed effects already added (i.e., NOT deviations)
## use coef() instead of ranef()
m.blups <- coef(m.random)$UserID
View(m.blups)

## summarise BLUPs for the random intercept
summary(m.blups[["(Intercept)"]])

## summarise BLUPs for the random slope
summary(m.blups[["STRESS"]])

## if we wanted, instead of using mean +/- SD to give a range of the estimates for
## the random intercept and slope, we could use the 25th and 75th percentiles
## (i.e., 1st and 3rd quartiles of the BLUPs)

## we also can visualise the correlation between the BLUPs for
## the random intercept and slope
ggplot(m.blups, aes(`(Intercept)`, STRESS)) +
  geom_point()

## looking at this we see one person actually has a positive slope
## suggesting that for higher stress they actually have higher positive affect
## that BLUP also appears to be a bit of an outlier.
## its worth investigating such cases a bit to try to understand why
## first, find the case -- #123
subset(m.blups, STRESS > 0)

## now lets investigate the raw data
## use d[UserID == 123] to subset data to only rows where UserID == 123
## make a scatter plot of stress and pos affect for this person
## and no clear signs of outliers or other issues and there
## is a positive association, so may not worry about it, although unusual
ggplot(d[UserID == 123], aes(STRESS, PosAff)) +
  geom_point()


#### 2. Interactions in Linear Regression (Activity) ####

## remember the graphs in this section need the visreg package
## install / load if not already (top of this script)

## main effects multiple regression
m.main <- lm(hp ~ mpg + vs, data = mtcars)
summary(m.main)

## interaction model with an interaction (moderation)
## of mpg and vs
m.int <- lm(hp ~ mpg * vs, data = mtcars)
summary(m.int)

## Visualize results
## main effects only
## different intercepts, same slope (parallel lines)
visreg(
  fit = m.main,
  xvar = "mpg",
  by = "vs",
  overlay = TRUE)

## interaction results
## different intercept, different slopes
visreg(
  fit = m.int,
  xvar = "mpg",
  by = "vs",
  overlay = TRUE)


#### 3. Interactions in LMMs (Demonstration) ####


lmm.main <- lmer(PosAff ~ STRESS + Female +
                   (1 | UserID),
                   data = d)

lmm.int1 <- lmer(PosAff ~ STRESS * Female +
                   (1 | UserID),
                   data = d)

lmm.int2 <- lmer(PosAff ~ STRESS * Female +
                   (1 + STRESS | UserID),
                   data = d)


## note the warning mssages --- this model failed to converge
## do not trust the results, there are a few approaches that might
## let such a model be estimated, but those are beyond this class
## generally, the easiest approach is to simplify
## here, we would use the simpler model, lmm.int2
lmm.int3 <- lmer(PosAff ~ STRESS * Female +
                   (1 + STRESS + STRESS:Female | UserID),
                   data = d)


## summaries of the models
summary(lmm.main)
summary(lmm.int1)

## test whether adding the random stress slope helps
anova(lmm.int1, lmm.int2, test = "LRT")

summary(lmm.int2)

## rounded coefficient table
## note that although coef() on a model gives the individual estimates
## calling coef() after summary() just gives fixed effects table
## which we can round
round(coef(summary(lmm.int2)), 2)

## confidence intervals (also rounded to 2 decimal points)
round(confint(lmm.int2, method = "Wald",
              oldNames = FALSE), 2)


## calculate and graph the simple slopes of stress
## at different levels of female
visreg(
 fit = lmm.int2,
 xvar = "STRESS",
 by = "Female",
 overlay = TRUE)

## calculate and graph the mean difference between women and men
## at different levels of stress, specifically, using breaks, we
## ask for simple slope of female at stress of 0, 5, and 10
## partial = FALSE removes the residual data points
visreg(
 fit = lmm.int2,
 xvar = "Female",
 by = "STRESS",
 breaks = c(0, 5, 10),
 partial = FALSE,
 overlay = TRUE)
