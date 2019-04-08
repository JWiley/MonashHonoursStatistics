library(data.table)
library(lme4)
library(ggplot2)
library(visreg)
library(JWileymisc)


n <- 205
set.seed(12345)
gsize <- sample(16:20, size = n, replace = TRUE, prob = c(.15, .2, .3, .2, .15))
u <- rep(rnorm(n, sd = 2), gsize)
s <- rep(rnorm(n, sd = .2), gsize)
id <- rep(1:n, gsize)
mod <- rep(rbinom(n, size = 1, .2), gsize)

xb <- 3 + (1 * x) + (2 * mod) - (4 * x * mod)
zu <- u + (s * x)

x <- rnorm(sum(gsize))
y <- rnorm(sum(gsize),
           mean = xb + zu,
           sd = pmax(xb + zu, 1))

d <- data.table(
  ID = id,
  RT = y,
  Trial = x,
  Group = mod)

saveRDS(d, file = "psy4210_quiz.RDS", compress = "xz")
