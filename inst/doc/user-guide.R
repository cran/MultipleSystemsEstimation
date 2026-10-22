## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(MultipleSystemsEstimation)

## ----korea-data---------------------------------------------------------------
data(Korea)
Korea

## ----auto-fit-----------------------------------------------------------------
fit <- estimate_population(Korea)
fit$estimate
fit$method

## ----bic-point----------------------------------------------------------------
fit_bic <- estimate_population_bic(Korea)

fit_bic$estimate
fit_bic$fitted_model

## ----bic-results--------------------------------------------------------------
fit_bic <- estimate_population_bic(Korea, return_details = TRUE)

fit_bic$details$bic_results$res

## ----bic-bootstrap------------------------------------------------------------
fit_bic_boot <- estimate_population_bic(Korea,nboot = 100)

fit_bic_boot$uncertainty

## ----bic-ntop-----------------------------------------------------------------
fit_bic_5 <- estimate_population_bic( Korea,
  nboot = 100,
  ntopmodels = 5
)

fit_bic_5$uncertainty

## ----stepwise-point-----------------------------------------------------------
data(Kosovo)

fit_pairwise <- estimate_population_stepwise(
  Kosovo,
  maxorder = 2
)

fit_pairwise$estimate
fit_pairwise$fitted_model

## ----stepwise-higher-order----------------------------------------------------
fit_step_unrestricted <- estimate_population_stepwise(
  Kosovo,
  maxorder = Inf
)

c(
  pairwise = fit_pairwise$estimate["total"],
  unrestricted = fit_step_unrestricted$estimate["total"]
)

c(
  pairwise = fit_pairwise$fitted_model,
  unrestricted = fit_step_unrestricted$fitted_model
)

## ----stepwise-bootstrap-------------------------------------------------------
fit_step_boot <- estimate_population_stepwise(
  Kosovo,
  maxorder = Inf,
  nboot = 100)

fit_step_boot$uncertainty

## ----fixed-point--------------------------------------------------------------
fit_fixed <- estimate_population(
  Korea,
  method = "fixed",
  model = "[12,23]"
)

fit_fixed$estimate
fit_fixed$fitted_model

## ----fixed-bootstrap----------------------------------------------------------
fit_fixed_boot <- estimate_population(
  Korea,
  method = "fixed",
  model = "[12,23]",
  nboot = 100,
  return_details = TRUE
)

fit_fixed_boot$uncertainty
fit_fixed_boot$details$bootstrap_failed

## ----bayesthresh-point--------------------------------------------------------
fit_bayes <- estimate_population_bayesthresh(
  Kosovo, maxorder = 3
)

fit_bayes$estimate
fit_bayes$fitted_model
fit_bayes$uncertainty

## ----names-result-------------------------------------------------------------
names(fit_bic)

