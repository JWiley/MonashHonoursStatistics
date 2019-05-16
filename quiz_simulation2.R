library(data.table)
library(lme4)
library(ggplot2)
library(visreg)
library(JWileymisc)


n <- 205
set.seed(903459)
gsize <- sample(16:20, size = n, replace = TRUE, prob = c(.15, .2, .3, .2, .15))
u <- rep(rnorm(n, sd = 2), gsize)
s <- rep(rnorm(n, sd = .2), gsize)
id <- rep(1:n, gsize)
mod <- rep(rbinom(n, size = 1, .2), gsize)
x <- rnorm(sum(gsize))

xb <- 2 - (2 * x) + (1 * mod) + (4 * x * mod)
zu <- u + (s * x)

y <- rnorm(sum(gsize),
           mean = xb + zu,
           sd = pmax(-(xb + zu) + 3, 1))

d <- data.table(
  ID = id,
  RT = y,
  Trial = x,
  Group = mod)

saveRDS(d, file = "psy4210_quiz_deferred.RDS", compress = "xz")
