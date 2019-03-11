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


## to visualize the multiple assessments per person
## and the variation in means we will focus
## one one variable, positive affect (PosAff) for just
## four individuals (IDs 1, 2, 6, and 9)

## first we subset the data to only rows
## where UserID is in IDs 1, 2, 6 or 9
## now that we use quotes around the IDs
## because they are not stored as numbers but
## as discrete categorical values (i.e., IDs are not
## really a continuous "number", they represent discrete people).
justfour <- d[UserID %in% c("1", "2", "6", "9")]

## now we can plot it
## (do not worry about understanding graphing, we will learn that later)
## Note the warnings about non-finite values are because of some
## missing data, you can ignore these safely, if you expect
## some missing data (we do)
ggplot(justfour, aes(UserID, PosAff)) +
  geom_jitter() +
  stat_summary(fun.data = mean_cl_normal,
               colour = "blue", size = 1)



## to visualize the differences in individual means
## we first make a new dataset where we
## calculate the mean positive affect *by* UserID
individMeans <- d[, .(MeanPosAff = mean(PosAff, na.rm = TRUE)),
                  by = UserID]

## view the first few rows of this new individual mean dataset
head(individMeans)

## now plot a histogram of the individual means
ggplot(individMeans, aes(MeanPosAff)) +
  geom_histogram()



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






#### 4. Diagnostics and Examining a LMM (Demonstration)  ####

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
