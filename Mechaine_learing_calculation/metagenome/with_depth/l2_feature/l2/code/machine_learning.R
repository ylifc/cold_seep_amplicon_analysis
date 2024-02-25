#!/usr/bin/env Rscript
library(mikropml)
library(tidyverse)
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 9)
args <- commandArgs(trailingOnly = TRUE)
output_file <- args[1]
seed <- as.numeric(str_replace(output_file, ".*_(\\d*)\\.Rds", "\\1"))
feature_script <- args[2]
source(feature_script)
ML_table <- read_tsv("./raw_data/KO_depth.txt")
ML_table_preprocessed <- preprocess_data(ML_table,outcome_colname = "Biosphare")
Ready_for_run <- ML_table_preprocessed$dat_transformed
model <- run_ml(Ready_for_run,
                method=approach,
                outcome_colname = "Biosphare",
                kfold = 5,
                cv_times = 100,
                training_frac = 0.8,
                find_feature_importance = TRUE,
		hyperparameters=hyperparameter,
                seed = seed)

saveRDS(model, file=output_file)
