source("./calculation_code/Step1_cold_seep_pretreatment_genus_split.R")
library(tidyverse)
#calculation of relative abundance of genus in each sample
genus_rel_abu <- complete_taxononmy_genus %>%
    select(-phylum,-taxonomy,-class) %>%
    group_by(index,genus) %>% summarize(.,count=sum(count),.groups = "drop")%>%
    mutate(rel_abu=count/sum(count)) %>% select(-count) %>%
    pivot_wider(.,names_from = "genus",values_from = "rel_abu")

#metadata for sampling information
genus_rel_abu$group1 <- wt$group1

table_1 <- genus_rel_abu %>%
    mutate(depth=str_replace_all(index,".*\\.(.*)","\\1"))%>%
    select(group1,depth,everything())%>%
    mutate(sample_area = str_replace_all(index,"(ROV\\d).*","\\1")) %>%
    mutate(sample_area = str_replace_all(sample_area,".*(ROV\\d)","\\1"))%>%
    select(-index)%>%select(group1,depth,sample_area,everything()) %>%rename(.,biosphare="group1")

table_2$samples <- paste0(table_2$biosphare,"_",table_2$depth,"cm")

table_3 <- table_2 %>% filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
    filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
    filter(.,depth!="65")%>%filter(.,depth!="70")%>%select(-biosphare,-depth,-sample_area)%>%
    select(samples,everything())


Table_genus_0_30cm  <- table_1%>% filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
    filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
    filter(.,depth!="65")%>%filter(.,depth!="70")%>%select(-depth,-sample_area)

write_tsv(Table_genus_0_30cm,"./raw_data/Table_genus_0_30cm.txt")
write_tsv(table_3,"./raw_data/Bacteria_Archaea2.txt")
