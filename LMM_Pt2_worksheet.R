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


## see the names of the variables in the dataset
names(d)


#### 2. Comparing Models (Demonstration)  ####

## fit an intercept only linear model (regression)
## and store the results in an object, m1lr
m1lr <- lm(PosAff ~ 1, data = d)

## create a summary of our linear regression model
summary(m1lr)

## the intercept is the overall mean of positive affect
## we can easily verify this
mean(d$PosAff, na.rm = TRUE)

## the linear regression model does not allow any individual differences

## now we will fit a *l*inear *m*ixed *e*ffects *r*egression
## model (LMM) using the lmer() function
## again we only have an intercept, but this time we include
## the intercept as a fixed effect (which will capture the mean)
## and as a random effect (which will capture the standard deviation)
m1lmm <- lmer(PosAff ~ 1 + (1 | UserID), data = d)

## generate a summary
## NOTE: in class walk through interpretation of output
summary(m1lmm)

## this model shows the assumed normal distribution of the
## individual means of positive affect are summarized by
## M = 2.67866 and SD = 0.7930


## we can compare these values to the values we would
## obtain if we simply calculated and summarized the individual means
## we can see the values are very close
## because of some differences in the estimation, these will not always
## match exactly, but they are typically close
mean(individMeans$MeanPosAff, na.rm = TRUE)
sd(individMeans$MeanPosAff, na.rm = TRUE)

## we also can use the variance (not standard deviation)
## estimates from the random effects section to estimate
## the intraclass correlation coefficient (ICC) for positive
## affect to provide a descriptive statistic for how much
## variance in positive affect occurs between people
## relative to its total variance

## ICC for positive affect
.6289 / (.6289 + .5290)


## in this intercept only model, the fixed effects estimates
## are similar between the linear regression and the LMMs

## regression coefficients (fixed effects) from linear regression
coef(m1lr)
## fixed effects only from LMM
fixef(m1lmm)

## however, because the linear regression erroneously assumes that
## all observations are independent, the standard error is biased
## downwards resulting in biased, too narrow confidence intervals
## here we just compare the 95% confidence interval for the fixed effect
## intercept estimate, labelled "(Intercept)" from both models
## note that it is wider (appropriately) in the LMM
confint(m1lr)
confint(m1lmm, oldNames = FALSE)


#### 3. Run a LMM (You Try It)  ####

## in pairs or small groups, pick one of the other variables
## in the dataset (not positive affect) and fit an intercept only
## linear mixed model by completing the code below.

## if you need a refresher on what variables are available
## take a look at the table in the slides or look through the example
## above to see how we could find all the variable names in the dataset

## store the model results in an object called "m2lmm"
m2lmm <- lmer()


## now make a summary of the model results




## what is the intraclass correlation coefficient for this variable?



## if you try fitting an intercept only linear regression (not LMM)
## to the same variable, are the confidence intervals
## wider or narrower for the LMM or linear regression?
m2lr <- lm( )






#### 4. Diagnostics (Demonstration)  ####

## make a dataset of the residuals and expected values
## to do this, we use the
## fitted() function for expected values
## resid() function for model residuals
## NOTE: these two functions work on linear regression models too
d.residuals <- data.table(
  Yhat = fitted(m1lmm),
  Residuals = resid(m1lmm))

## check for normality of the outcome
## by examining residuals
ggplot(d.residuals, aes(Residuals)) +
  geom_histogram()

## check for normality of the outcome
## using QQ plot
ggplot(d.residuals, aes(sample = Residuals)) +
  stat_qq() + stat_qq_line()

## check for homogeneity of variance assumption
ggplot(d.residuals, aes(Yhat, Residuals)) +
  geom_point(alpha = .2)


## make a dataset of the random effects by UserID
d.random <- as.data.table(coef(m1lmm)$UserID)

## check whether the random effects are normally distributed
## note that these have mean 0
ggplot(d.random, aes(`(Intercept)`)) +
  geom_histogram()

## normality via QQ plot
ggplot(d.random, aes(sample = `(Intercept)`)) +
  stat_qq() + stat_qq_line()


#### 5. Inference (Demonstration)  ####

## fixed effects table
fetable <- coef(summary(m1lmm))
## view the table
print(fetable)

## extract the t values (b / se)
## take their absolute value (as we typically do 2 sided hypothesis tests
## calculate the p-value using the normal distribution function, pnorm()
## and multiply by 2 so its a two-tailed test
pnorm(abs(fetable[, "t value"]), lower.tail = FALSE) * 2

## confidence intervals using the Wald method are based
## on assuming a normal distribution and are very fast and easy
## but do not give any confidence intervals for the random effects
confint(m1lmm, method = "Wald")

## confidence intervals using the profile method are based
## on the change in model performance (the log likelihood)
## and are much slower, but generally a bit more precise and
## are appropriate for random effects
confint(m1lmm, method = "profile")


## we can compare models using likelihood ratio tests
## which are OK (not dissimilar from assuming normal) for fixed effects
## and are about the best that can be done for random effects
## note that you always need at least one random effect in LMMs
## so you cannot simply remove the random intercept; generally this is
## used for testing more complex random effects we will learn in future weeks
## or testing several differences at once

## setup a new model with an additional predictor, SurveyInteger
lmmalt <- lmer(PosAff ~ 1 + SurveyInteger + (1 | UserID), d)

## conduct a likelihood ratio test of these two, nested models
anova(lmmalt, m1lmm, test = "LRT")

## assuming normal distribution, test the fixed effects in
## our alternate model, lmmalt
fetablealt <- coef(summary(lmmalt))
pnorm(abs(fetablealt[, "t value"]), lower.tail = FALSE) * 2

