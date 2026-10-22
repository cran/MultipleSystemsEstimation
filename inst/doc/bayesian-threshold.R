## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(MultipleSystemsEstimation)


## ----kosovo-pairwise----------------------------------------------------------
fit_bayes <- estimate_population_bayesthresh(
  Kosovo,
  maxorder = 2,
  alpha = c(0.025, 0.975),
  return_details = TRUE
)

fit_bayes$estimate
fit_bayes$uncertainty
fit_bayes$fitted_model
fit_bayes$details$threshold_statistics

## ----kosovo-threefactor-------------------------------------------------------

fit_bayes3 <- estimate_population_bayesthresh(
  Kosovo,
  maxorder = 3, threshold = 2.5, alpha = c(0.025, 0.975),
  return_details = TRUE
)

fit_bayes3$estimate
fit_bayes3$uncertainty
fit_bayes3$fitted_model
fit_bayes3$details$threshold_statistics
fit_bayes3$details$eligible_triples
fit_bayes3$details$triple_threshold_statistics
fit_bayes3$details$retained_triples

## ----uk-improper-minus-infinity-----------------------------------------------

fit_improper <- estimate_population_bayesthresh(
  UKdat_5,
  prior = "improper",
  return_details = TRUE
)

fit_improper$estimate
fit_improper$uncertainty
fit_improper$fitted_model
fit_improper$details$minus_infinity_effects

## ----kosovo-fourfactor--------------------------------------------------------
fit_bayes4 <- estimate_population_bayesthresh(
  Kosovo,
  maxorder = 4, threshold = 2.5, alpha = c(0.025, 0.975),
  return_details = TRUE
)

fit_bayes4$details$triple_status
fit_bayes4$details$quad_status
fit_bayes4$details$eligible_quads
fit_bayes4$details$quad_threshold_statistics
fit_bayes4$details$retained_quads
fit_bayes4$fitted_model
fit_bayes4$estimate
fit_bayes4$uncertainty

## ----korea-existence, error=TRUE----------------------------------------------
try({
estimate_population_bayesthresh(
  Korea,
  prior = "improper"
)
})

