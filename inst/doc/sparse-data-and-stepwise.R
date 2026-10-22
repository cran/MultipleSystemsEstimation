## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(MultipleSystemsEstimation)

## -----------------------------------------------------------------------------
data(Artificial_3)
Artificial_3

## -----------------------------------------------------------------------------
MultipleSystemsEstimation::check_extended_MLE(Artificial_3, "[12,13,23]")

MultipleSystemsEstimation::check_extended_MLE(Artificial_3, "[12,3]")

MultipleSystemsEstimation::check_extended_MLE(Artificial_3, "[13,23]")


## -----------------------------------------------------------------------------
fit <- estimate_population_stepwise(Korea, pthresh = 0.02, maxorder = 2)

fit$estimate
fit$fitted_model

## -----------------------------------------------------------------------------
fit <- estimate_population(
  Korea,
  method = "stepwise",
  pthresh = 0.02,
  maxorder = 2
)

## ----stepwise-higher-order----------------------------------------------------
data(Kosovo)

Kosovo_pairwise <- estimate_population_stepwise(
  Kosovo,
  pthresh = 0.02,
  maxorder = 2
)

Kosovo_unrestricted <- estimate_population_stepwise(
  Kosovo,
  pthresh = 0.02,
  maxorder = Inf
)

c(
  pairwise = Kosovo_pairwise$estimate["total"],
  unrestricted = Kosovo_unrestricted$estimate["total"]
)

c(
  pairwise = Kosovo_pairwise$fitted_model,
  unrestricted = Kosovo_unrestricted$fitted_model
)

## ----Korea_boot_1-------------------------------------------------------------
fit_boot <- estimate_population_stepwise(
  Korea,
  nboot = 100,
  pthresh = 0.02,
  maxorder = 2,
  iseed = 1234
)

fit_boot$estimate
fit_boot$uncertainty

## ----NewOrl_boot_1------------------------------------------------------------
data(NewOrl)

ncol(NewOrl) - 1
sum(NewOrl[, ncol(NewOrl)])

## -----------------------------------------------------------------------------
NewOrl_fit <- estimate_population_stepwise(
  NewOrl,
  pthresh = 0.02, 
  maxorder = 2
)

NewOrl_fit$estimate
NewOrl_fit$fitted_model

## ----NewOrl_boot2, eval = FALSE-----------------------------------------------
# NewOrl_boot <- estimate_population_stepwise(
#   NewOrl,
#   pthresh = 0.02,
#   maxorder = 2,
#   nboot = 1000
# )
# 
# NewOrl_boot$uncertainty

## ----NewOrl_boot_3, eval = FALSE----------------------------------------------
# NewOrl_main <- estimate_population_stepwise(
#   NewOrl,
#   pthresh = 0,
#   maxorder = 2,
#   nboot = 1000
# )
# 
# NewOrl_main$estimate
# NewOrl_main$uncertainty

## ----NewOrl_boot_4------------------------------------------------------------
data(NewOrl_5)

NewOrl5_fit <- estimate_population_stepwise(
  NewOrl_5,
  pthresh = 0.02,
  maxorder = 2
)

NewOrl5_fit$estimate
NewOrl5_fit$fitted_model

## ----NewOrl_boot_6------------------------------------------------------------
NewOrl5_boot <- estimate_population_stepwise(
  NewOrl_5,
  pthresh = 0.02,
  maxorder = 2, 
  nboot = 100
)

NewOrl5_boot$uncertainty

## ----Western_boot_7-----------------------------------------------------------
data(Western)

Western_fit <- estimate_population_stepwise(
  Western,
  pthresh = 0.02,
  maxorder = 2
)

Western_fit$estimate
Western_fit$fitted_model

## ----Western_boot_9-----------------------------------------------------------
Western_boot <- estimate_population_stepwise(
  Western,
  pthresh = 0.02,
  maxorder = 2, 
  nboot = 100
)

Western_boot$uncertainty

