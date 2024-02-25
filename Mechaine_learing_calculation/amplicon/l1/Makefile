
processed_data/l1_genus_%.Rds : code/machine_learning.R\
																code/l1.R\
																raw_data/KO_depth.txt
	./code/machine_learning.R $@ code/l1.R

SEEDS = $(shell seq 1 1 100)
L1_GENUS_RDS = $(patsubst %,processed_data/l1_genus_%.Rds,$(SEEDS))

processed_data/l1_genus_performance.tsv : code/grab_ML_result.R $(L1_GENUS_RDS)
	$^
