
processed_data/l2_genus_%.Rds : code/machine_learning.R\
																code/l2.R\
																raw_data/KO_depth.txt
	./code/machine_learning.R $@ code/l2.R

SEEDS = $(shell seq 1 1 100)
L2_GENUS_RDS = $(patsubst %,processed_data/l2_genus_%.Rds,$(SEEDS))

processed_data/l2_genus_performance.tsv : code/grab_ML_result.R $(L2_GENUS_RDS)

	$^
