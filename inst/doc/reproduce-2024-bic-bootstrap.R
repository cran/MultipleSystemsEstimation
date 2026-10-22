## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

# FALSE: build the document without running the calculations.
run_examples <- FALSE

# TRUE: use reduced calculations to check that the code runs.
# FALSE: use the full computational settings.
quick_check <- TRUE

nboot <- if (quick_check) 10L else 1000L
ntop_finite <- if (quick_check) 2L else 60L
ntop_unrestricted <- if (quick_check) 2L else Inf

## ----reproduction-setup, eval=run_examples------------------------------------
# library(MultipleSystemsEstimation)
# 
# vary_ntop_bca <- getFromNamespace("vary_ntop_bca", "MultipleSystemsEstimation")
# downhill_fit <- getFromNamespace("downhill_fit", "MultipleSystemsEstimation")
# downhill_bootstrapcal <- getFromNamespace("downhill_bootstrapcal", "MultipleSystemsEstimation")
# downhill_jackknifecal <- getFromNamespace("downhill_jackknifecal", "MultipleSystemsEstimation")
# assemble_bic <- getFromNamespace("assemble_bic", "MultipleSystemsEstimation")
# bootstrapcal <- getFromNamespace("bootstrapcal", "MultipleSystemsEstimation")
# degree2_order <- getFromNamespace(".degree2_order", "MultipleSystemsEstimation")
# bcaconfvalues <- getFromNamespace("bcaconfvalues", "MultipleSystemsEstimation")
# 
# # Load all datasets used in the calculations.
# data(Kosovo)
# data(Korea)
# data(UKdat_5)
# data(NewOrl_5)
# 
# # Check that the corrected New Orleans data are being used.
# if (sum(NewOrl_5[, ncol(NewOrl_5)]) != 185) {
#   stop("This vignette requires the corrected 185-case New Orleans data.")
# }
# 
# # This check applies to the complete candidate space, before any ntop restriction.
# checked_assemble <- function(zdat, maxorder, expected_models = NULL) {
#   z <- assemble_bic(zdat, maxorder = maxorder)
#   if (!isTRUE(z$enumeration_maxorder == z$requested_maxorder)) {
#     stop("Enumeration order was reduced: requested ", z$requested_maxorder,
#          "; actual ", z$enumeration_maxorder,
#          ". Increase maxmodel before treating this search as exhaustive.")
#   }
#   if (!nrow(z$res)) stop("No candidate model has a valid original-data fit.")
#   if (!is.null(expected_models) && nrow(z$res) != expected_models) {
#     stop("Expected ", expected_models, " valid models, but found ", nrow(z$res),
#          ". Check the package version and data before comparing with the paper.")
#   }
#   z
# }
# 
# # Check the requested searches and the published Kosovo and Korea model counts.
# model_spaces <- list(
#   Kosovo = list(data = Kosovo, order = ncol(Kosovo) - 2, expected = 113L),
#   Korea = list(data = Korea, order = 2, expected = 6L),
#   UK2 = list(data = UKdat_5, order = 2, expected = NULL),
#   UK4 = list(data = UKdat_5, order = 4, expected = NULL),
#   NewOrleans2 = list(data = NewOrl_5, order = 2, expected = NULL),
#   NewOrleans4 = list(data = NewOrl_5, order = 4, expected = NULL)
# )
# for (spec in model_spaces) {
#   invisible(checked_assemble(spec$data, spec$order, spec$expected))
# }
# rm(model_spaces, spec)

## ----table2-calculation, eval=run_examples------------------------------------
# data(Kosovo)
# 
# kos <- vary_ntop_bca(
#   Kosovo,
#   maxorder = ncol(Kosovo) - 2,
#   ntopmax = ntop_unrestricted,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )

## ----table2-extract, eval=run_examples----------------------------------------
# kos$inference[kos$inference$ntop %in% c(1, 5, 10, max(kos$inference$ntop)), ]

## ----table3-calculation, eval=run_examples------------------------------------
# data(Korea)
# 
# kor <- vary_ntop_bca(
#   Korea,
#   maxorder = 2,
#   ntopmax = ntop_unrestricted,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )
# 

## ----table3-extract, eval=run_examples----------------------------------------
# kor$inference[
#   kor$inference$ntop %in% c(1, 2, max(kor$inference$ntop)),
#   ,
#   drop = FALSE
# ]

## ----fig1-calc, eval=run_examples---------------------------------------------
# data(UKdat_5)
# 
# uk2 <- vary_ntop_bca(
#   UKdat_5,
#   maxorder = 2,
#   ntopmax = ntop_finite,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )
# 
# uk4 <- vary_ntop_bca(
#   UKdat_5,
#   maxorder = 4,
#   ntopmax = ntop_finite,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )

## ----fig2-calc, eval=run_examples---------------------------------------------
# data(NewOrl_5)
# 
# no2 <- vary_ntop_bca(
#   NewOrl_5,
#   maxorder = 2,
#   ntopmax = ntop_finite,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )
# 
# no4 <- vary_ntop_bca(
#   NewOrl_5,
#   maxorder = 4,
#   ntopmax = ntop_finite,
#   degree = 1,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.1, 0.9, 0.975)
# )

## ----table4-calc, eval=run_examples-------------------------------------------
# bootstrap_optimal_ranks <- function(zdat, maxorder, nboot = 1000, iseed = 1234) {
#   # Exercise the exhaustive-search code on a small dataset in quick mode.
#   if (quick_check) {
#     zdat <- Korea
#     maxorder <- 2
#   }
#   z <- checked_assemble(
#     zdat, maxorder = maxorder
#   )
# 
#   z <- bootstrapcal(
#     z, nboot = nboot, iseed = iseed
#   )
# 
#   original_order <- order(z$res[, "BIC"])
# 
#   vapply(seq_len(nboot), function(b) {
#     v <- z$bootbic[, b]
#     ok <- which(is.finite(v))
#     if (!length(ok)) return(NA_integer_)
# 
#     best <- ok[which.min(v[ok])]
#     match(best, original_order)
#   }, integer(1))
# }
# 
# rank_counts <- function(r, ntop = c(1, 5, 10, 50, 100)) {
#   vapply(
#     ntop,
#     function(k) sum(r <= k, na.rm = TRUE),
#     integer(1)
#   )
# }
# 
# ranks4 <- list(
#   Kosovo = bootstrap_optimal_ranks(
#     Kosovo, maxorder = ncol(Kosovo) - 2, nboot = nboot
#   ),
#   UK2 = bootstrap_optimal_ranks(UKdat_5, maxorder = 2, nboot = nboot),
#   UK4 = bootstrap_optimal_ranks(UKdat_5, maxorder = 4, nboot = nboot),
#   NewOrleans2 = bootstrap_optimal_ranks(NewOrl_5, maxorder = 2, nboot = nboot),
#   NewOrleans4 = bootstrap_optimal_ranks(NewOrl_5, maxorder = 4, nboot = nboot)
# )
# 
# sapply(ranks4, rank_counts)
# 
# # Counts above exclude failed replications; disclose their denominator.
# rank_diagnostics4 <- t(vapply(ranks4, function(r) {
#   c(attempted = length(r), usable = sum(is.finite(r)),
#     failed = sum(!is.finite(r)))
# }, numeric(3)))
# rank_diagnostics4

## ----table5-kosovo, eval=run_examples-----------------------------------------
# kos_d2 <- vary_ntop_bca(
#   Kosovo,
#   maxorder = ncol(Kosovo) - 2,
#   ntopmax = ntop_unrestricted,
#   degree = 2,
#   nboot = nboot,
#   iseed = 1234,
#   alpha = c(0.025, 0.975)
# )
# 
# kos$inference[kos$inference$ntop %in% c(1, 5, 10, max(kos$inference$ntop)), ]
# kos_d2$inference[kos_d2$inference$ntop %in% c(1, 5, 10, max(kos_d2$inference$ntop)), ]

## ----fig3-reproduction-code, eval=run_examples--------------------------------
# uk_d1 <- vary_ntop_bca(
#   UKdat_5, maxorder = 4, ntopmax = ntop_unrestricted,
#   degree = 1, nboot = nboot, iseed = 1234,
#   alpha = c(0.025, 0.975)
# )
# 
# uk_d2 <- vary_ntop_bca(
#   UKdat_5, maxorder = 4, ntopmax = ntop_unrestricted,
#   degree = 2, nboot = nboot, iseed = 1234,
#   alpha = c(0.025, 0.975)
# )
# 
# no_d1 <- vary_ntop_bca(
#   NewOrl_5, maxorder = 4, ntopmax = ntop_unrestricted,
#   degree = 1, nboot = nboot, iseed = 1234,
#   alpha = c(0.025, 0.975)
# )
# 
# no_d2 <- vary_ntop_bca(
#   NewOrl_5, maxorder = 4, ntopmax = ntop_unrestricted,
#   degree = 2, nboot = nboot, iseed = 1234,
#   alpha = c(0.025, 0.975)
# )

## ----fig4-calc, eval=run_examples---------------------------------------------
# bootstrap_rank_pair <- function(zdat, maxorder,
#                                 nboot = 1000, iseed = 1234) {
#   # Exercise the exhaustive-search code on a small dataset in quick mode.
#   if (quick_check) {
#     zdat <- Korea
#     maxorder <- 2
#   }
#   z <- checked_assemble(
#     zdat, maxorder = maxorder
#   )
# 
#   z <- bootstrapcal(
#     z, nboot = nboot, iseed = iseed
#   )
# 
#   r1_order <- order(z$res[, "BIC"])
# 
#   r2_order <- degree2_order(
#     rownames(z$res),
#     nlists = ncol(z$xdata) - 1,
#     maxorder = z$maxorder
#   )
# 
#   r1 <- rep(NA_integer_, nboot)
#   r2 <- rep(NA_integer_, nboot)
# 
#   for (b in seq_len(nboot)) {
#     v <- z$bootbic[, b]
#     ok <- which(is.finite(v))
#     if (!length(ok)) next
# 
#     best <- ok[which.min(v[ok])]
#     r1[b] <- match(best, r1_order)
#     r2[b] <- match(best, r2_order)
#   }
# 
#   usable <- is.finite(r1) & is.finite(r2)
#   keep <- usable & r1 > 1
# 
#   pairs <- data.frame(
#     ordinary = r1[keep],
#     degree2 = r2[keep]
#   )
#   attr(pairs, "replication_counts") <- c(
#     attempted = nboot, usable = sum(usable), failed = sum(!usable),
#     rank_one_omitted = sum(usable & r1 == 1), retained_pairs = sum(keep)
#   )
#   pairs
# }
# 
# kos_rank <- bootstrap_rank_pair(
#   Kosovo,
#   maxorder = ncol(Kosovo) - 2, nboot = nboot
# )
# 
# no2_rank <- bootstrap_rank_pair(NewOrl_5, maxorder = 2, nboot = nboot)
# no4_rank <- bootstrap_rank_pair(NewOrl_5, maxorder = 4, nboot = nboot)
# uk2_rank <- bootstrap_rank_pair(UKdat_5, maxorder = 2, nboot = nboot)
# uk4_rank <- bootstrap_rank_pair(UKdat_5, maxorder = 4, nboot = nboot)
# 
# rank_sets <- list(
#   Kos = kos_rank,
#   NO2 = no2_rank,
#   NO4 = no4_rank,
#   UK2 = uk2_rank,
#   UK4 = uk4_rank
# )
# 
# # Numerical rank pairs underlying Figure 4.
# rank_sets
# rank_diagnostics_fig4 <- t(vapply(rank_sets, function(x) {
#   attr(x, "replication_counts")
# }, numeric(5)))
# rank_diagnostics_fig4

## ----table6-korea, eval=run_examples------------------------------------------
# downhill_korea <- list(
#   estimate = downhill_fit(
#     counts = Korea[, ncol(Korea)],
#     desmat = Korea[, -ncol(Korea), drop = FALSE],
#     maxorder = 2
#   ),
#   bootreps = downhill_bootstrapcal(
#     Korea,
#     nboot = nboot,
#     iseed = 1234,
#     maxorder = 2
#   ),
#   ahat = downhill_jackknifecal(
#     Korea,
#     maxorder = 2
#   )
# )
# 
# c(
#   estimate = downhill_korea$estimate,
#   acceleration = downhill_korea$ahat
# )
# 
# usable <- is.finite(downhill_korea$bootreps)
# downhill_korea$replication_counts <- c(
#   attempted = length(usable), usable = sum(usable), failed = sum(!usable)
# )
# downhill_korea$replication_counts
# 
# downhill_korea$confidence_limits <- NULL
# if (quick_check) {
#   message("Korea BCa limits omitted: ten replications are insufficient for meaningful tail estimates.")
# } else if (!all(usable) || !is.finite(downhill_korea$estimate) ||
#            !is.finite(downhill_korea$ahat)) {
#   warning("Korea BCa limits omitted: investigate failed fits or unavailable acceleration.")
# } else {
#   # Extreme bias correction can make BCa probabilities undefined.
#   p_below <- mean(downhill_korea$bootreps < downhill_korea$estimate)
#   if (p_below == 0 || p_below == 1) {
#     warning("Korea BCa limits omitted: all bootstrap estimates lie on one side of the point estimate.")
#   } else {
#     downhill_korea$confidence_limits <- bcaconfvalues(
#       bootreps = downhill_korea$bootreps,
#       popest = downhill_korea$estimate,
#       ahat = downhill_korea$ahat,
#       alpha = c(0.025, 0.975)
#     )
#     downhill_korea$confidence_limits
#   }
# }

