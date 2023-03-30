####### WEEK 5 WORKSHEET - GLM 2 #######

library(haven)
library(data.table)
library(JWileymisc)
library(ggplot2)
library(ggpubr)
library(visreg)
library(survey)

dcount <- fread("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv")

### 1. Poisson ### 

# Fit a poisson regression predicting the number of awards, 
# `num_awards` from `prog` in the `dcount` data. Try to 
# interpret the results using IRRs and make a graph. 

# Note: "There is no association between prog and num_awards so
# do not be surprised if the graphs etc are not that interesting.")

## Plot the distribution of the outcome num_awards:
plot(???(dcount$???, distr = "???"))

## fit poisson regression num_awards on prog:
m <- ???(??? ~ ???, data = ???, family = ???n())

## Show the results:
???

## calculate IRRs and confidence intervals on the IRR scale:
exp(???(m))
exp(???(m))

## graph and visualize the (very exciting) results.
# First in linear space (predicted log number of awards):
visreg(???, xvar = "???", partial = FALSE, rug = FALSE, gg = TRUE) +
  ylab("???") +
  theme_pubr()
# then for predicted number of awards
visreg(???, xvar = "???", ???,
       partial = FALSE, rug = FALSE, gg = TRUE) +
  ylab("???") +
  theme_pubr()

## Pretend the result was significant. How would you write
# up the interpretation of the results? Say that 'prog'
# is just something like 'their progress in the class' (I
# actually have no idea)

# First write it up for log awards:

# A poisson regression predicting the number of awards each student
# received based on their progress in the class showed that students
# who had ____ progress were expected to have ____log awards, p = ____. 
# Each one unit higher of progress was associated with ____ lower log
# awards, p = ____

# Now write it up for the more interpret-able IRRs:

# A poisson regression predicting the number of awards each student 
# received based on their progress in the class showed that students 
# who had a 0 progress were expected to have ?? awards, 
# [95% CI ____]. Each one unit higher progress was associated 
# with having ____ times the number of awards, [95% CI ____], 
# p = ____. 

### 2. Binary logistic ### 

# Run the below code to make a new variable in dcount called 'unicorn'
# which fills it in with binary values to say whether or not someone
# is a unicorn. Note: this will be different for everyone
set.seed(666)
dcount$unicorn <- sample(0:1, size = nrow(dcount), replace = TRUE)

# Now use math scores to predict if someone is a unicorn.
mlog <- ???(??? ~ ???, data = ???, family = ???())
summary(???)
???(coef(mlog))
???(confint(mlog))

# Pretend your result is significant. How would you write it
# up (in odds)?

# Odds:
# For each ____ on math, participants have ____ times
# the ____ of ____ (p = ____)

# Visualise the probability of being a unicorn by math score
# (Note: this might not look very curvy in your data and
# that's ok):
visreg(???, xvar = "???", ???,
       partial = FALSE, rug = FALSE, gg = TRUE) +
  ylab("???") +
  theme_pubr()

# Calculate the average marginal effect for a one higher 
# math score predicting the probability of being a
# unicorn:

## pick h value for difference, store that in variable h
???

## make the original dataset
originaldata <- dcount[, .(math)]

## make the increased math dataset (math + h)
increaseddata <- dcount[, .(math = ???)]

## calculate original predicted probabilities
originaldata$Prob <- predict(???, newdata = ???,
                             type = "???")

## calculate increased predicted probabilities
increaseddata$Prob <- ???

## calculate the difference in probabilities per unit
diffprob <- ???

## calculate the average marginal effect
mean(???)
