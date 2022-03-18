#### Week 3 Worksheet ####

library(tufte)
library(haven)
library(data.table)
library(JWileymisc)
library(psych)
library(ggplot2)
library(ggpubr)
library(ggthemes)
library(scales)
library(ggExtra)
# Remember to set your working directory to the folder that these datasets are in
setwd("~/git_repos/MonashHonoursStatistics")
db <- as.data.table(read_sav("[2021] PSY4210 BL.sav")) # baseline
dd <- as.data.table(read_sav("[2021] PSY4210 DD.sav")) # daily

#### 1. Scoring and Reliability ####

# Score some other scales in the baseline questionnaire! 
#
# Four items from the Sternberger's Trait Anxiety scale (STAI; items STAI1-STAI4)
# were used in to measure anxiety levels. The short-form of the UCLA Loneliness 
# Scale (ULS-8; items ULS1-ULS8) was used to capture loneliness. 
# The Lifespan Self-Esteem Scale (items LSE1-LSE4) was used to measure self-esteem or how one 
# feels about themselves. The 10-item version of the Big Five inventory was used
# to capture openness, conscientiousness, extraversion, agreeableness and 
# neuroticism (e.g. BFI_E1r needs to be reverse-coded and then added to or 
# averaged with BFI_E2 to form the Extraversion score).

# Calculate Cronbach's alpha measure of internal consistency reliability
# for the self-esteem score (LSE items)
psych::alpha(as.data.frame(db[, .(LSE1, LSE2, LSE3, LSE4)]), check.keys = TRUE)

## Create a variable for self-esteem and name it SE, and others if you like! 
db[, SE := rowMeans(.SD, na.rm = TRUE),
   .SDcols = c("LSE1", "LSE2", "LSE3", "LSE4")]
  
  
  
#### 2. Basic ggplot2 graphs ####

# Remember how we make a density plot graph for just one variable, 
# say, SE from our db dataset (we just created it)
???
  

# Remember that we have to tell R that certain variables are factors
# Do that now for the variable "relsta" (relationship status).
# Hint: If you aren't sure what the levels and labels are, try str(db$relsta) first
  db[, relsta := factor(
    relsta, levels = c(1,2,3), 
    labels = c("single", "in a committed exclusive relationship", "in a committed nonexclusive relationship"))]
  
  

# Now plot SE by relationship status (hint: remove NAs from relsta)
ggplot(db[!is.na(relsta)], aes(SE, colour = relsta)) +
  geom_density()
  

## Next, let's try to see how self-esteem varies by Stress categories

## First, do you remember how to reverse scores PSS items?
db [, PSS2 := 6- PSS2r]
db [, PSS3 := 6- PSS3r] 

## Do you remember how to create a Stress total?
db[, Stress := rowMeans(.SD, na.rm = TRUE) * 4,
   .SDcols = c("PSS1", "PSS2", "PSS3", "PSS4")]
  

## Finally, remind us how to create high vs. low stress categories (called StrCat) 
## (but unlike the reading, do this on Stress total, not StressAVG)
## Hint: what number should you put instead of 3? How did I get 3 when I did 
## the code for StressAVG?
mean(db$Stress)
db[Stress < 10, StrCat := "low"]
db[Stress >= 10, StrCat := "high"]
db[, StrCat := factor(StrCat, levels = c("low", "high"))]

## It's always good to check you did a categorization correctly:
table(db$StrCat)

## Now that we have all that, create a density plot showing SE by Stress Category
???
  

## use `testDistribution()` to examine whether self esteem follows a
## normal distribution and whether it has any extreme values.
  plot(testDistribution(db$SE,
                        extremevalues = "theoretical", ev.perc = .005))

## Make a histogram for the variable: `extraversion`.
???
???
  

???
  

## Make a dotplot for: `openness` *separated* (e.g., by colour and/or fill)
## by `sex`:
???
???
  

???
  

  

#### 3. Bivariate graphs ####

# Make a scatter plot (points) for `extraversion` and
# `conscientiousness` in the baseline data, `db`. Use the
# good visualization principles we have learned. Make your own
# decisions to make the scatter plot most useful to read.
???
???
  

???
  
  
  
  
  
   


## Check what the correlation between Self-Esteem and Neuroticism is
???
???
  

cor.test(???)

## Make a scatterplot showing the association between Self-Esteem and Neuroticism
## Include a linear regression line and print the statistics
## Hint 1: neuroticism has some missing values that cause trouble
## Hint 2: play around with the x, y, hjust and vjust arguments in annotate()
cool_plot <- ggplot(???) +
  geom_point() +
  stat_smooth(???) + 
  scale_x_continuous(breaks = as.numeric(quantile(db$neuroticism, na.rm = TRUE))) + 
  scale_y_continuous(breaks = as.numeric(quantile(db$SE))) +   
  theme_pubr() +   
  theme(axis.line = element_blank()) +
  geom_rangeframe() +
  xlab(???) +
  ylab(???) +
  annotate(???,
           label = ???,
           size = ???, hjust = ???, vjust = ???)

## Bonus: Include histograms of Self-Esteem and Neuroticism
ggMarginal(???)

## Epic Bonus:
## Now find a way to show the same scatterplot above, but represent 
## differences by sex
## Hint: First find a way to get the stats separately by sex
cor.test(???)
cor.test(???)

cool_plot2 <- ???
  
  
  
  
  
  
  
  
  
  
