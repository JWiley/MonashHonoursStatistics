######## WEEK 10 (LMM Moderation) WORKSHEET ######## 

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
library(emmeans)

## load data collection exercise data (merged)
dm <- as.data.table(read_sav("[2021] PSY4210 merged.sav"))

# Review: Model fixed effects of agreeableness and daily mood 
# predicting daily self esteem, with a random intercept
???

# Controlling for ________, 
# as mood ______, self esteem on the same day _______

# Model fixed effects of between and within versions of mood 
# predicting self esteem
???
???

# Greater deviations from a person's average ____ are associated 
# with ____ in _____ on the same day

# Model fixed and random effects of mood predicting self esteem, 
# controlling for agreeableness
???

# Int_Part is a variable asking whether or not someone interacted with a current 
# or possible romantic partner

dm[, Int_Part := factor(
  Int_Part, levels = c(0,1), 
  labels = c("No int partner", "int partner"))]

dm[, relsta := factor(
  relsta, levels = c(1,2,3), 
  labels = c("single", "committed excl rel", "committed nonexcl rel"))]

# Model the interaction of Int_Part and relationship status predicting daily self esteem
m1 <- lmer(dSE ~ ??? + (1 | ID), data = dm)
summary(m1)



# Visualise this categorical x categorical interaction
visreg(???
         
         )

em <- emmeans(???
                )
emmip(???) +
  theme_pubr() +
  ylab("???")
