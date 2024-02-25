source("./calculation_code/Step1_cold_seep_pretreatment_genus_split.R")
supergroup_table <- wt %>% select(-biosphare)%>%
  pivot_longer(-index, names_to = "taxonomy",values_to = "count") %>% 
  mutate(super_group=str_replace_all(taxonomy,".*;p__(.*);c__(.*);o__.*","\\1_\\2"))%>%
  mutate(super_group=str_replace_all(super_group,".*;p__(.*);c__(.*);.*","\\1_\\2"))%>%
  mutate(super_group=str_replace_all(super_group,";__",""))%>% 
  mutate(super_group=str_replace_all(super_group,".*;",""))%>%
  mutate(super_group=str_replace_all(super_group,"p__",""))%>%
  mutate(super_group=str_replace_all(super_group,"d__(.*)","\\1_unclassified"))%>%
  mutate(super_group=str_replace_all(super_group,"Proteobacteria_(.*)","\\1"))%>%
  mutate(super_group=str_replace_all(super_group,"(.*)_.*","\\1"))%>% select(-taxonomy)%>%
  filter(super_group!="Bacteria")
wt_biosphare <- wt %>%select(index,biosphare)
supergroup_table2<-supergroup_table %>% group_by(index,super_group)%>% 
  summarize(.,count=sum(count),.groups = "drop")
supergroup_table2[order(supergroup_table2$count,decreasing = T),]%>%
  select(super_group)%>%head(.,n=300)%>%table(.)

  pivot_wider(.,names_from = "super_group",values_from = "count")%>%
  inner_join(.,wt_biosphare,by="index")%>%
  mutate(depth=str_replace_all(index,".*-(.*)","\\1"))%>%
  select(biosphare,depth,everything())
