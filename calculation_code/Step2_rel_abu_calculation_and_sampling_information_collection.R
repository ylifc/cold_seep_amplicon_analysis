source("./calculation_code/Step1_cold_seep_pretreatment_genus_split.R")
library(tidyverse)
#calculation of relative abundance of genus in each sample
genus_rel_abu <- complete_taxononmy_genus %>% 
    select(-phylum,-taxonomy,-class) %>% 
    filter(.,genus!="uncultured_uncultured") %>%
    group_by(index,genus) %>% summarize(.,count=sum(count),.groups = "drop")%>%
    mutate(rel_abu=count/sum(count)) %>% select(-count) %>%
    pivot_wider(.,names_from = "genus",values_from = "rel_abu")

#metadata for sampling information
table_1 <- wt %>% select(index, biosphare) %>% inner_join(.,genus_rel_abu,by="index")%>%
    mutate(depth=str_replace_all(index,".*-(.*)","\\1"))%>%
    select(biosphare,depth,everything())%>%
    mutate(sample_area = str_replace_all(index,"(ROV\\d).*","\\1")) %>%
    mutate(sample_area = str_replace_all(sample_area,".*(ROV\\d)","\\1"))%>%
    select(-index)%>%select(biosphare,depth,sample_area,everything())