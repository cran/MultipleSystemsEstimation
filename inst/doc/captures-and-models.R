## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(MultipleSystemsEstimation)

# Internal functions used in this vignette
encode_capture  <- getFromNamespace("encode_capture", "MultipleSystemsEstimation")
decode_capture  <- getFromNamespace("decode_capture", "MultipleSystemsEstimation")
parent_captures <- getFromNamespace("parent_captures", "MultipleSystemsEstimation")
child_captures  <- getFromNamespace("child_captures", "MultipleSystemsEstimation")
ancestors       <- getFromNamespace("ancestors", "MultipleSystemsEstimation")
descendants     <- getFromNamespace("descendants", "MultipleSystemsEstimation")

## ----encode-decode------------------------------------------------------------
encode_capture(c(1, 0, 1))
encode_capture(c(TRUE, FALSE, TRUE))
decode_capture(6, nlists = 3)
decode_capture(6, nlists = 5)

## ----parents------------------------------------------------------------------
parent_captures(6)
child_captures(6, nlists = 3)
child_captures(6, nlists = 4)

## ----ancestors----------------------------------------------------------------
ancestors(6)
descendants(6, nlists = 4)
descendants(6, nlists = 4, omitk = TRUE)

ancestors(c(6,10))
descendants(c(6,10), nlists=4)
descendants(c(4, 8), nlists = 4, omitk = TRUE)


## ----model-from-maximal-histories---------------------------------------------
maximal_histories <- c(8, 11, 17)
model_histories <- ancestors(maximal_histories)
model_histories

## ----generate-three-list-models-----------------------------------------------
models <- get_hierarchical_models(nlists = 3, maxorder = 2)
length(models)

## ----inspect-generated-models-------------------------------------------------
names(models)
models[[1]]

## ----sparse-model-counts------------------------------------------------------
captures <- c("A", "B", "C", "D", "AB", "AC", "AD", "ABC")
counts <- c(12, 8, 6, 9, 4, 3, 2, 2)

xdata <- data.frame(
  A = as.integer(grepl("A", captures)),
  B = as.integer(grepl("B", captures)),
  C = as.integer(grepl("C", captures)),
  D = as.integer(grepl("D", captures)),
  count = counts
)

all_models <- get_hierarchical_models(4, maxorder = 3)
filtered_models <- get_hierarchical_models(4, maxorder = 3,
                                           xdata = xdata)

c(all = length(all_models),
  filtered = length(filtered_models))

