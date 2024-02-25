#!/usr/bin/env Rscript
library(mikropml)
library(tidyverse)
args <- commandArgs(trailingOnly = TRUE)
output_file <- args[1]
seed <- as.numeric(str_replace(output_file, ".*_(\\d*)\\.Rds", "\\1"))
feature_script <- args[2]
source(feature_script)
ML_table <- read_tsv("./raw_data/Table_genus_0_30cm.txt")
ML_table_preprocessed <- preprocess_data(ML_table,outcome_colname = "biosphare")
Ready_for_run <- ML_table_preprocessed$dat_transformed
model <- run_ml(Ready_for_run,
                method="xgbTree",
                outcome_colname = "biosphare",
                kfold = 5,
                cv_times = 100,
                training_frac = 0.8,
                hyperparameters = hyperparameters,
                seed = seed)

saveRDS(model, file=output_file)