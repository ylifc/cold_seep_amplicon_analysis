
processed_data/svm_genus_%.Rds : code/machine_learning.R\
																code/svmRadial_dep.R\
																raw_data/KO_depth.txt
	./code/machine_learning.R $@ code/svmRadial_dep.R

SEEDS = $(shell seq 1 1 100)
svm_GENUS_RDS = $(patsubst %,processed_data/svm_genus_%.Rds,$(SEEDS))

processed_data/svm_genus_performance.tsv : code/grab_ML_result.R $(svm_GENUS_RDS)
	$^
