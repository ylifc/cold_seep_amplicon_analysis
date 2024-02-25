processed_data/rf_genus_%.Rds : code/machine_learning.R\
																code/rf_dep.R\
																raw_data/KO_depth.txt
	./code/machine_learning.R $@ code/rf_dep.R

SEEDS = $(shell seq 1 1 100)
rf_GENUS_RDS = $(patsubst %,processed_data/rf_genus_%.Rds,$(SEEDS))

processed_data/rf_genus_performance.tsv : code/grab_ML_result.R $(rf_GENUS_RDS)
	$^
