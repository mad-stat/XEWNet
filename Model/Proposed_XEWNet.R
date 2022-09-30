#' @title Ensemble Wavelet Neural Network with Exogenous Variables for Time Series Forecasting (XEWNet)

#' A wavelet based auto-regressive neural network architecture for forecasting  
#' non-stationary, non-linear, and long-term dependent time series with exogenous 
#' variables.

#' Maximal overlap discrete wavelet transform (MODWT)-based additive decomposition is applied 
#' to the time series \code{y} using pyramid algorithm (specified by \code{FastFlag}) and 
#' \code{boundary} condition to decompose the series into \code{Waveletlevels} levels. 
#' A feed-forward neural network architecture is fitted to each of the \code{Waveletlevels}
#' decomposed series with \code{MaxARParam} lagged observations and covaraite, \code{x} as input. 
#' The networks are chosen to have a single hidden layer with \code{size} nodes. 
#' A total of \code{repeats} networks are fitted at random starting point to obtain stable results.
#' The model generates one-step ahead forecast, multi-step ahead forecast is computed recuursively 

#' @param y A processed target time series object that contains data to be analyzed, for training.
#' @param xreg_tr Exogeneous time series object for training.
#' @param Waveletlevels A predefined \code{integer} specifying the level of wavelet decomposition. 
#' Option: floor(log (base e) length(train_set)) (default).
#' @param boundary A string indicating the boundary condition of wavelet decomposition.
#' Options: "periodic"-generates wavelet decomposed series of same length as that of \code{y} (default),
#' "reflection"-generates wavelet decomposed series twice the length of \code{y}.  
#' @param FastFlag A logical indicator denoting the application of pyramid algorithm.
#' Options. "TRUE" (default), "FALSE".
#' @param MaxARParam An \code{integer} indicating the maximum number of lagged observations modeled in 
#' the XEWNet architecture.  
#' @param size An \code{integer} denoting the number of hidden nodes in the single hidden layer.
#' Default: \code{size} = \code{MaxARParam}/2+1, to ensure stable learning.
#' @param repeats An \code{integer} representing the number of repetations of the neural network.
#' Default: 500.
#' @param: NForecast Length of the forecast horizon, an \code{integer} value.
#' @param: NVal An \code{integer} denoting the size of the validation set used for hyper-parameter tuning.
#' @return Returns an object of class "\code{ts}" representing the forecast of \code{NForecast} horizon.

@export

WaveletFitting <- function(ts,Wvlevels,bndry,FFlag)
{
  mraout <- wavelets::modwt(ts, filter='haar', n.levels=Wvlevels,boundary=bndry, fast=FFlag)
  WaveletSeries <- cbind(do.call(cbind,mraout@W),mraout@V[[Wvlevels]])
  return(list(WaveletSeries=WaveletSeries,WVSeries=mraout))
}

XEWNet_Fitting<- function(ts,MaxARParam,NForecast, xreg_tr)
  
{
  WS <- WaveletFitting(ts=ts,Wvlevels=Waveletlevelsfloor(log(length(ts))),bndry="periodic",FFlag= TRUE)$WaveletSeries
  AllWaveletForecast <- NULL;AllWaveletPrediction <- NULL
  
  for(WVLevel in 1:ncol(WS))
  {
    ts <- NULL
    ts <- WS[,WVLevel]
    XEW_Fit <- forecast::nnetar(y=as.ts(ts), xreg = xreg_tr, p = MaxARParam, repeats = 500)
    XEW_Predict <- XEW_Fit$fitted
    XEW_Forecast <- forecast::forecast(XEW_Fit, xreg = xreg_tr[1:NForecast], h=NForecast)
    AllWaveletPrediction <- cbind(AllWaveletPrediction,XEW_Predict)
    AllWaveletForecast <- cbind(AllWaveletForecast,as.matrix(XEW_Forecast$mean)) 
  }
  Finalforecast <- rowSums(AllWaveletForecast,na.rm = T)
  FinalPrediction <- rowSums(AllWaveletPrediction,na.rm = T)
  return(list(Finalforecast=Finalforecast,FinalPrediction=FinalPrediction))
}

#' Implementation example
#' Fit XEWNet model to the given time series *y_data* with 5 lagged observations
#' and *x_data* as covariate to generate forecast of next 3 time points
#' XEWNet_Fitting(y_data, MaxARParam = 5, NForecast = 3, xreg_tr = x_data)

#' ewnet(data, MaxARParam = 5, NForecast = 3) 
