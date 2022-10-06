#' @title Implementation of different forecasting models with exogenous variables from literature
#' @param \code{train} is a time series object for training the model
#' @param \code{x_reg} is a covariate time series object having causal
#' relationship with \code{train}.
#' @param n an \code{integer} value indicating the desired forecast horizons
#' @library required - forecast, Metrics

#' Evaluation Matrix
performance = data.frame()
model_summary = function(test, output, model){
  SMAPE = smape(as.vector(test),output)*100
  MAE = mae(as.vector(test),output)
  MASE = mase(as.vector(test),output)
  RMSE = rmse(as.vector(test),output)
  Evaluation = data.frame(Model = model, SMAPE = SMAPE, MAE = MAE, MASE = MASE, RMSE = RMSE)
  return(Evaluation)
}


#' ARIMAX
fitARIMAX = auto.arima(train, xreg = x_reg) 
predARIMAX = forecast::forecast(fitARIMAX,h=n, xreg = x_reg[1:n])
ARIMAX_summary = model_summary(test, predARIMAX$mean, model = "ARIMA")
performance = rbind(performance, ARIMAX_summary)

#' ETSX  
fitETSX = ets(train, xreg = x_reg)
predETSX = forecast::forecast(fitETSX, h=n, xreg = x_reg[1:n])
ETSX_summary = model_summary(test, predETSX$mean, model = "ETSX")
performance = rbind(performance, ETSX_summary)

#' ARNNX
fit_ARNNX = nnetar(train, xreg = x_reg)
predARNNX=forecast::forecast(fit_ARNNX, h= n, xreg = x_reg[1:n])
ARNNX_summary = model_summary(test, predARNN$mean, model = "ARNNX")
performance = rbind(performance, ARNNX_summary)
