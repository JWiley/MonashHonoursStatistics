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


#### 2. Calculating Between & Within Effects (Demonstration)  ####

## examine the distribution of stress in two participants
## you can see how the means seem to differ but also each participant
## has variation within them in their level of stress
ggplot(d[UserID %in% c(1, 2)], aes(STRESS, fill = UserID)) +
  geom_density()

## calculate the individual mean stress BY participant ID
d[, MeanStress := mean(STRESS, na.rm = TRUE), by = UserID]

## calculate the deviation stress scores
## by taking the difference between observed stress scores and the
## indidivudal means
## note that we do not need to specify BY participant ID because the
## individual means are already repeated on each row of the dataset
d[, DeviationStress := STRESS - MeanStress]

## now look at a few rows of the data to check what happened
d[UserID == 1, .(UserID, STRESS, MeanStress, DeviationStress)]

## look at the mean deviation stress (this should basically be 0)
## representing that it is a within only variable
## note that R may use scientific notation:
## 1.4e4 = 1, then move decimal four spots to the right = 14000
## 1.4e-4 = 1, then move decimal four spots to the left = .00014
mean(d$DeviationStress, na.rm=TRUE)


## now we can estimate LMMs

## first we only use STRESS, which combines both between & within effects
summary(lmer(PosAff ~ STRESS + (1 | UserID), data = d))

## next we use our new mean and deviation stress variables
## to separate the between and within effects of stress
summary(lmer(PosAff ~ MeanStress + DeviationStress +
               (1 | UserID), data = d))


#### 3. Calculating Between & Within Effects (You Try It) ####

## in pairs or small groups, pick one of the other variables
## in the dataset (not STRESS, not PosAff) that is repeatedly measured
## calculate individual means and deviations from the means
## then fit a model predicting positive affect, first from the overall
## score and then from the mean and deviation scores.

## if you need a refresher on what variables are available
## take a look at the table in the slides.

## calculate individual means by ID
d[,  := mean( , na.rm = TRUE), by = UserID]

## calculate the deviation scores
d[,  :=  - ]

## fit a linear mixed model using the original variable to predict positive affect
summary(lmer(PosAff ~      + (1 | UserID), data = d))


## fit a linear mixed model using the mean and deviation
## variables to predict positive affect
summary(lmer(PosAff ~      + (1 | UserID), data = d))




#### 4. Random Slopes (Demonstration)  ####

## random intercept and fixed effects only
m1a <- lmer(PosAff ~ MeanStress + DeviationStress +
              (1 | UserID),
            data = d)

## random intercept, random slope, and fixed effects
m1b <- lmer(PosAff ~ MeanStress + DeviationStress +
              (1 | UserID) + (0 + DeviationStress | UserID),
            data = d)

## correlated random intercept and random slope, and fixed effects
m1c <- lmer(PosAff ~ MeanStress + DeviationStress +
              (1 + DeviationStress | UserID),
            data = d)

## generate summaries of the models and compare
## note the standard errors in particular
summary(m1a)
summary(m1b)
summary(m1c)


## does adding the random slope improve model fit?
anova(m1a, m1b, test = "LRT")

## does allow the random intercept and slope to correlate improve model fit?
anova(m1b, m1c, test = "LRT")

## overall does the model with correlated random intercept and slope
## fit better than a random intercept only model
## simultaneously tests 2 parameters: slope variance + 1 correlation
anova(m1a, m1c, test = "LRT")




#### 5. Random Slopes (You Try It)  ####

## in pairs or small groups, use the same variable you chose
## earlier to create individual means and deviations from the means
## use these variables to complete the models below and discuss
## their interpretation amongst yourselves

## random intercept and fixed effects only
m2a <- lmer(PosAff ~    +     +
              (1 | UserID),
            data = d)

## random intercept, random slope, and fixed effects
m2b <- lmer(PosAff ~    +     +
              (1 | UserID) + (0 +  | UserID),
            data = d)

## correlated random intercept and random slope, and fixed effects
m2c <- lmer(PosAff ~      +      +
              (1 +      | UserID),
            data = d)

## generate summaries of the models and compare
## what happens to the standard errors in the fixed
## only vs fixed + random slope models?
summary(  )

## Use the anova() function to answer these questions
## for YOUR variable

## does adding the random slope improve model fit?
anova(    ,     , test = "LRT")

## does allow the random intercept and slope to correlate improve model fit?


## overall does the model with correlated random intercept and slope
## fit better than a random intercept only model?
