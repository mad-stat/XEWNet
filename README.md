# An ensemble neural network approach to forecast dengue outbreak based on climatic condition (XEWNet)

In this study, we propose an ensemble MODWT-based auto-regressive neural network architecture to model the depeendency of dengue outbreak on climatic factor. This stable learning framework outperforms state-of-the-art models by generating most accurate short-term and long-term dengue forecasts. Our study considers three publicly available real-world dengue incidence and rainfall datatsets from the tropical and sub-tropical regions namely - San Juan, Iquitos, and Ahmedabad.

Usage of the repository for the paper "An ensemble neural network approach to forecast dengue outbreak based on climatic condition".

The training phase of the proposed XEWNet model initially decomposes the time-indexed dengue incidence series into its corresponding *details* and *smooth* coefficients by utlizing a MODWT-based multi-resolution analysis. Followed by the decomposition, each of the details and smooth series are modelled with rainfall data as covariate using individual auto-regressive neural network architecture in an ensemble framework. In the subsequent step, the neural network generates multi-step ahead forecasts iteratively and aggregates the corresponding forecasts to generate the final output. Graphical representation of the proposed XEWNet model is provided below:
![Model_Img_mod](https://github.com/mad-stat/XEWNet/blob/main/Model/XEWNet_Model.png)

