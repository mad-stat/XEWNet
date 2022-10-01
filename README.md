# An ensemble neural network approach to forecast dengue outbreak based on climatic condition (XEWNet)

In this study, we propose an ensemble MODWT-based auto-regressive neural network architecture to model the depeendency of dengue outbreak on climatic factor. This stable learning framework outperforms state-of-the-art models by generating most accurate short-term and long-term dengue forecasts. Our study considers three publicly available real-world dengue incidence and rainfall datatsets from the tropical and sub-tropical regions namely - San Juan[1], Iquitos[1], and Ahmedabad[2].

Usage of the repository for the paper "An ensemble neural network approach to forecast dengue outbreak based on climatic condition".

The training phase of the proposed XEWNet model initially decomposes the time-indexed dengue incidence series into its corresponding *details* and *smooth* coefficients by utlizing a MODWT-based multi-resolution analysis. Followed by the decomposition, each of the details and smooth series are modelled with rainfall data as covariate using individual auto-regressive neural network architecture in an ensemble framework. In the subsequent step, the neural network generates multi-step ahead forecasts iteratively and aggregates the corresponding forecasts to generate the final output. Graphical representation of the proposed XEWNet model is provided below:
![Model_Img_mod](https://github.com/mad-stat/XEWNet/blob/main/Model/XEWNet_Model.png)

In this repository, we present application of the proposed XEWNet model with three dengue datasets. These datasets are collected from varied open-source platforms and published manuscripts. The ".csv" files of these datasets available in [Source](https://github.com/mad-stat/XEWNet/tree/main/Dataset) contains dengue incidence and meterological data reported on a weekly basis in different regions. 
  
The [XEWNet](https://github.com/mad-stat/XEWNet/blob/main/Model/Proposed_XEWNet.R) file contains the source code and the implemntation of the proposed XEWNet model. The proposed framework comprises of two hyper-parameters $(p,k)$, where $p$ denotes the number of lagged input observations and $k$ indicates the number of nodes in the hidden layer of the proposed XEWNet model. The hyper-parameter $p$ is tuned by minimising the Akakie information criterion (AIC). The choice of the hyper-parameter $k$ is made as $k = \frac{(p+1)}{2}$ to ensure the stable learning architecture.

Reults obtained in the paper for all these dengue datasets can directly be computed along with the graphs and figures using the implementation files and datasets given in this repository for replicability and sake of reproducibility of our paper.

## References
* <a id="1">[1]</a> Chakraborty, Tanujit, Swarup Chattopadhyay, and Indrajit Ghosh. "Forecasting dengue epidemics using a hybrid methodology." Physica A: Statistical Mechanics and its Applications 527 (2019): 121266.
* <a id="2">[2]</a> Enduri, Murali Krishna, and Shivakumar Jolad. "Estimation of reproduction number and non stationary spectral analysis of dengue epidemic." Mathematical Biosciences 288 (2017): 140-148.
