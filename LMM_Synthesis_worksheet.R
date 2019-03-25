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
library(data.table)
library(lme4)
library(ggplot2)

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

#### 2. Individual, Random, Fixed Effects (Demonstration) ####

## individual
## fit a linear regression of PosAff on STRESS and have R
## save the intercept and slope and do this BY UserID
m.individual <- d[, as.list(coef(lm(PosAff ~ STRESS))), by = UserID]

## histogram of individual slopes
## note a couple of extremes
ggplot(m.individual, aes(STRESS)) + geom_histogram()

## random (LMM)
m.random <- lmer(PosAff ~ STRESS + (1 + STRESS | UserID), data = d)

## get Best Linear Unbiased Predictions (BLUPs) for the individual effects
## from the random effect model (i.e., the LMM estimates of individual effects)
m.ind.random <- ranef(m.random)$UserID

## histogram of BLUPs for the slopes
## note that these are deviations from the fixed effects (the means)
## so mean = 0
ggplot(m.ind.random, aes(STRESS)) + geom_histogram()

## summarise the model
summary(m.random)

## to make it more comparable to individual estimates, add the fixed effects
ggplot(m.ind.random, aes(STRESS - .160623)) + geom_histogram()


## fixed
m.fixed <- lm(PosAff ~ STRESS, data = d)
summary(m.fixed)


## histogram of individual slopes
## with means from different approaches
ggplot(m.individual, aes(STRESS)) + geom_histogram() +
  geom_vline(xintercept = mean(m.individual$STRESS), colour = "black", size = 1) +
  geom_vline(xintercept = -.160623, colour = "blue", size = 1) +
  geom_vline(xintercept = -.183232, colour = "yellow", size = 1)



## examine descriptive statistics from the individual regressions
mean(m.individual[["(Intercept)"]])
sd(m.individual[["(Intercept)"]])

mean(m.individual[["STRESS"]])
sd(m.individual[["STRESS"]])

cor(m.individual[["(Intercept)"]], m.individual[["STRESS"]])

## compare above with the summary from LMM
summary(m.random)



#### 3. Interpreting LMMs (Demonstration) ####

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
