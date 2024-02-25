source("calculation_code/Figure1_A(hc2Newick).R")
ww <- read.table("./raw_data/Bacteria_Archaea3.txt",header = T, row.names = 1, sep = "\t")
dist = vegdist(ww,method = "bray")
h <- hclust(dist)
write(hc2Newick(h),file='hclust.newick')
####imported to itols tree for plotting