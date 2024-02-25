#!/usr/bin/env Rscript
approach <- "glmnet"
hyperparameter <- list(alpha=0, lambda=c(0.0001,0.001,0.01,0.1,1))