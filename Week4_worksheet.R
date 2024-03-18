# Week 4 Worksheet - GLM 1
library(haven)
library(data.table)
library(JWileymisc)
library(ggplot2)
library(ggpubr)
library(visreg)
setwd("~/git_repos/MonashHonoursStatistics")
db <- as.data.table(read_sav("[2021] PSY4210 BL.sav")) # baseline

# First create the SE and Stress scale totals for sum totals

???
  
???
???
???
  

# Make a model called m where Stress predicts self-esteem

???

# Show the results and the confidence intervals

???

???

# For each one unit increase in Stress, self-esteem ____creases by ______ units
# A: 


# Make a nice-looking plot of the linear regression from model m. Include labels
visreg(???) +
  theme_pubr() +
  annotate(???) + 
  ggtitle(???)


# Assess the model diagnostics for m and save it as m_diag, then plot
???
plot(???)

# Q: How many outliers are there? 
# A: 

# Use modelTest() to get an effect size of stress on self-esteem. What is it?
???
???
# A: 
