library(tidyverse)
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 6)
wt <- read_tsv("./raw_data/Bacteria_Archaea.txt")
#split column for phylum level
complete_taxononmy_phylum <- wt %>% select(-group1)%>%
    pivot_longer(-index, names_to = "taxonomy",values_to = "count") %>% 
    mutate(phylum=str_replace_all(taxonomy,".*;p__(.*);c__.*","\\1")) %>%
    mutate(phylum=str_replace_all(phylum,";__",""))%>%
    mutate(phylum=str_replace_all(phylum,".*;",""))%>%
    mutate(phylum=str_replace_all(phylum,"p__",""))%>%
    mutate(phylum=str_replace_all(phylum,"d__(.*)","\\1_unclassified"))

#split column for class level
complete_taxononmy_class <-complete_taxononmy_phylum %>% 
    mutate(class=str_replace_all(taxonomy,"c__(.*);o__.*","\\1")) %>%
    mutate(class=str_replace_all(class,";__.*","_unclassified"))%>%
    mutate(class=str_replace_all(class,".*;",""))%>%
    mutate(class=str_replace_all(class,"d__",""))%>%
    mutate(class=str_replace_all(class,"p__",""))%>%
    mutate(class=str_replace_all(class,"c__",""))

#split column for genus level
complete_taxononmy_genus<- complete_taxononmy_class %>% 
    mutate(genus=str_replace_all(taxonomy,";__.*","_unclassified"))%>%
    mutate(genus=str_replace_all(genus,".*;.*__(.*);.*uncultured","\\1_uncultured"))%>%
    mutate(genus=str_replace_all(genus,".*__(.*)_unclassified","\\1_unclassified"))%>%
    mutate(genus=str_replace_all(genus,".*g__(.*)","\\1"))%>%
    mutate(genus=str_replace_all(genus,"-"," "))

write_tsv(complete_taxononmy_genus,"./raw_data/table_1.txt")


