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
library(visreg)

## load the data (note this is already an R dataset)
## so we use a new function readRDS()
## make sure that the data file is located in
## your project directory
d <- readRDS("aces_daily_sim_processed.RDS")


#### 2. Several Different Models (Demonstration) ####

## subset the data to guarantee it is the same
## only pick cases that are not missing stress and positive affect
## is.na() function return TRUE if missing FALSE if not missing
## the ! negates it, so !is.na() return TRUE if NOT missing and
## FALSE if missing. The & combines them, so we get
## TRUE only if BOTH STRESS and PosAff are not missing
## and otherwise, FALSE. Rows that are FALSE are excluded.
d2 <- d[!is.na(STRESS) & !is.na(PosAff)]

## nrow() returns the number of rows in a dataset
nrow(d)
nrow(d2)


## fixed effects models
## start with an intercept only model for comparison
## when doing model comparisons, helpful to use REML = FALSE to get a ML fit
mf.none <- lmer(PosAff ~ 1 + (1 | UserID),
                data = d2, REML = FALSE)

## update() function takes an existing model as input
## . represents everything that was there before
## so . ~ . means the outcome regressed on all the previous predictors
## then we add on top of the + poly(STRESS, 1) to add a
## one degree polynomial (which is a straight line) to the intercept
## only model, we repeat with more complex polynomials
mf.lin <- update(mf.none, . ~ . + poly(STRESS, 1))
mf.quad <- update(mf.none, . ~ . + poly(STRESS, 2))
mf.cub <- update(mf.none, . ~ . + poly(STRESS, 3))

## update intercept only model with fixed and random slopes
mr.lin <- update(mf.none, . ~ . - (1 | UserID) +
  poly(STRESS, 1) + (1 + poly(STRESS, 1) | UserID))
mr.quad <- update(mf.none, . ~ . - (1 | UserID)+
  poly(STRESS, 2) + (1 + poly(STRESS, 2) | UserID))

## Likelihood Ratio Test (LRT) only makes sense for nested models
## below are a series of comparisons that are strictly nested
## however, note that say, mr.quad and mf.cub are NOT nested
## because they each have parameters the other does not

## for fixed effects models
## AIC and BIC favour mf.quad
## LRT also indicates mf.quad is sig better than mf.lin
## but that mf.cub is not sig better than mf.quad
## this points to a quadratic (2 degree) polynomial capturing the
## association of stress with positive affect
anova(
  mf.none, mf.lin, mf.quad,  mf.cub,
  test = "LRT")

## LRT comparing a random stress slope + correlation or not
## points to random slope being a better model
anova(
  mf.lin, mr.lin,
  test = "LRT")

## LRT comparing a random linear and quad stress slope versus
## only fixed effects linear and quadratic stress slopes
## favours the random over fixed effects model
anova(
  mf.quad, mr.quad,
  test = "LRT")

## AIC and BIC can be used even with non nested models
## as long as the outcome variable and cases are the same
## which we ensured by using a dataset that excludes missing
## AIC favours mr.quad
AIC(
  mf.none, mf.lin, mf.quad, mf.cub,
  mr.lin, mr.quad)
## BIC favours mr.quad
BIC(
  mf.none, mf.lin, mf.quad, mf.cub,
  mr.lin, mr.quad)


## empirically, mr.quad is the "winning" model
## let's look at a summary
summary(mr.quad)
## note although profile confidence intervals (default)
## are more accurate, took > 8 minutes to complete on a mid 2018 laptop
confint(mr.quad, method = "Wald", oldNames = FALSE)

## visualize the fixed effects
visreg(
  fit = mr.quad,
  xvar = "STRESS",
  partial = FALSE,
  rug = FALSE)

## we know from the model comparisons that the random stress slope
## both linear and quadratic fit better
## to visualize the random effects, we will make up a dataset
## with stress values ranging from 0 to 10 by .1 (e.g., 0, 0.1, 0.2)
## and every UserID from our dataset (given the random effects mean slopes differ)
## expand.grid() makes a grid of every possible combination of values
newdata <- expand.grid(
  STRESS = seq(from = 0, to = 10, by = .1),
  UserID = d2$UserID)

## ask R to predict positive affect, using our model, mr.quad,
## the new dataset we made, and by specifying re.form = NULL
## we will get every every random effect used in the predictions
## the predictions are stored as a new variable in our dataset
newdata$PosAff <- predict(mr.quad, newdata = newdata, re.form = NULL)

## now we can plot our dataset
## stress and (predicted) positive affect, grouped by ID
## the alpha = .2 on the lines sets the transparency
## 0 = completely transparent, 1 = completely opaque
## this helps with overplotting
ggplot(newdata, aes(STRESS, PosAff, group = UserID)) +
  geom_line(alpha = .2)


## because AIC / BIC can compare non nested models, we can use
## them to decide between two or more "sets" of predictors

## suppose that one theory argues that stress is most important
## and another that sociodemographics and time of day are most important

## first make a dataset with no missingness on the variables being tested
## so that the models are fitted to exactly the same data
d3 <- d[!is.na(PosAff) & !is.na(STRESS) & !is.na(Age) & !is.na(SurveyInteger) &
        !is.na(Female) & !is.na(Age) & !is.na(BornAUS) & !is.na(SES_1) &
        !is.na(EDU)]

nrow(d)
nrow(d3)

m.stress <- lmer(PosAff ~ 1 + STRESS + (1 + STRESS | UserID), data = d3)
m.demo <- lmer(PosAff ~ 1 + SurveyInteger +
                 Female + Age + BornAUS + SES_1 + EDU +
                 (1 + SurveyInteger | UserID), data = d3)

## compare AIC and BIC
AIC(m.stress, m.demo)
BIC(m.stress, m.demo)


#### 3. Compare Models (You Try It) ####

## setup a dataset with no missing values for
## PosAff and SUPPORT

d4 <- d[!is.na( ) & !is.na( )]
d4 <- d[!is.na(PosAff) & !is.na(SUPPORT)]

nrow(d) ## should be 6927
nrow(d4) ## should be 2175 --- SUPPORT only measured in evening

## setup your intercept only model (fixed and random intercept)
## make sure to use the new dataset, d4
m2f.none <- lmer(   ,
                 data = d4, REML = FALSE)

## now add linear, quadratic, and cubic polynomials for
## social support: poly(   , 1), etc.
m2f.lin <- update(   , . ~ . +   )

## use anova() and AIC() and BIC() to compare the different
## models, which is the best?
anova(
  m2f.none,
  test = "LRT")

AIC(
  m2f.none,  )

BIC(
  m2f.none, )

## make a summary of the best model
summary(  )
confint(  , method = "Wald", oldNames = FALSE)

## visualize the fixed effects for the best model
visreg(
  fit =   ,
  xvar = "SUPPORT",
  partial = FALSE,
  rug = FALSE)
