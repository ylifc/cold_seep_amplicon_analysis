#!/usr/bin/env Rscript
library(mikropml)
library(tidyverse)
library(glue)
library(reshape2)

rds_files <- commandArgs(trailingOnly = TRUE)
root <- str_replace(rds_files, "_\\d*\\.Rds", "") %>% unique

iterative_run_ml_results <- map(rds_files, readRDS)

iterative_run_ml_results %>%
  map(pluck, "trained_model") %>%
  combine_hp_performance() %>%
  pluck("dat") %>%
  write_tsv(glue("{root}_hp.tsv"))

a <- iterative_run_ml_results %>%
  map(pluck,"performance")%>%transpose(.)%>%map(unlist)
data.frame(x=a[1],y=a[3])%>%
  write_tsv(glue("{root}_performance.tsv"))
