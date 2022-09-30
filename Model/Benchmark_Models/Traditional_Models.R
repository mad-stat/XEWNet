#' @title Implementation of different forecasting models with exogenous variables from literature
#' @param \code{train} is a time series object for training the model
#' @param \code{x_reg} is a covariate time series object having causal
#' relationship with \code{train}.
#' @param n an \code{integer} value indicating the desired forecast horizons
#' @library required - forecast
