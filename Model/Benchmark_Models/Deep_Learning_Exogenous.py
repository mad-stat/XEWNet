#' @title Implementation of deep learning forecasting models
#' @param \code{train} is a time series object for training the model
#' @param \code{x_reg} is a covariate time series object used for training
#' @param n an \code{integer} value indicating the desired forecast horizons
#' @library required - darts 

#' BlockRNN

from darts.models import BlockRNNModel
mdl = BlockRNNModel(input_chunk_length=30, 
                             output_chunk_length=13, 
                             n_rnn_layers=2)
mdl.fit(train, past_covariates = x_reg, epochs=100, verbose=True)
mdl.predict(n)

#' NBeats

from darts.models import NBEATSModel
model_nbeats = NBEATSModel(input_chunk_length=20, output_chunk_length=13, random_state=42)
model_nbeats.fit(train, past_covariates=train_cvt, epochs=100, verbose=True)
model_nbeats.predict(n)

#'Transformers

from darts.models import TransformerModel 
my_tf_model = TransformerModel(
    input_chunk_length=15,
    output_chunk_length=13,
    batch_size=32,
    n_epochs=100,
    model_name="transformer",
    nr_epochs_val_period=10,
    d_model=16,
    nhead=8,
    num_encoder_layers=2,
    num_decoder_layers=2,
    dim_feedforward=128,
    dropout=0.1,
    activation="relu",
    random_state=42,
    save_checkpoints=True,
    force_reset=True,
)
my_tf_model.fit(series = train, past_covariates = x_reg, verbose=True)
my_tf_model.predict(n)

#' TCN

from darts.models import TCNModel
deep_tcn = TCNModel(
    input_chunk_length=20,
    output_chunk_length=13,
    kernel_size=2,
    num_filters=4,
    dilation_base=2,
    dropout=0,
    random_state=0,
    likelihood=GaussianLikelihood(),
)
deep_tcn.fit(train, past_covariates = x_reg, verbose=True)
deep_tcn.predict(n)
