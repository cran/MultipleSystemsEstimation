## ----setup, include=FALSE-----------------------------------------------------
library(MultipleSystemsEstimation)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----bic-example--------------------------------------------------------------
data(Korea)

bic_fit <- estimate_population_bic(
  Korea, maxorder = 2, return_details = TRUE
)

bic_fit$estimate
bic_fit$fitted_model

## ----inspect-bic-fit----------------------------------------------------------
head(bic_fit$details$bic_results)

## ----bootstrap-example--------------------------------------------------------
bic_boot <- estimate_population_bic(
  Korea,
  maxorder = 2,
  nboot = 10,
  iseed = 1234
)

bic_boot$estimate
bic_boot$uncertainty

## ----full-bootstrap-call, eval=FALSE------------------------------------------
# bic_full <- estimate_population_bic(
#   Korea,
#   maxorder = 2,
#   ntopmodels = Inf,
#   nboot = 1000,
#   alpha = c(0.025, 0.975),
#   iseed = 1234,
#   return_details = TRUE
# )
# 
# bic_full$uncertainty

