library(vegan)
table_mussle_0_30cm <- table_1 %>% filter(.,biosphare=="mussel")%>%
  filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
  filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
  filter(.,depth!="65")
dist <- vegdist(table_mussle_0_30cm[,4:ncol(table_mussle_0_30cm)])
dist2 <- as.matrix(dist)
dist3 <- dist2[lower.tri(dist2)]
boxplot(dist3)


table_1_0_5cm_mussel<- table_1 %>% filter(.,biosphare=="mussel") %>%
  filter(.,depth!="10")%>%
  filter(.,depth!="15")%>%filter(.,depth!="20")%>%filter(.,depth!="25")%>% 
  filter(.,depth!="30")%>%filter(.,depth!="35")%>%filter(.,depth!="40")%>%
  filter(.,depth!="45")%>%filter(.,depth!="50")%>%filter(.,depth!="55")%>%
  filter(.,depth!="60")%>%filter(.,depth!="65")
com_0_5cm_mussel <- as.matrix(table_1_0_5cm_mussel[,4:ncol(table_1_0_5cm_mussel)])
com_0_5cm_mussel_anosim <- anosim(com_0_5cm_mussel, table_1_0_5cm_mussel$depth, 
                                  distance = "bray", permutations = 9999)

table_1_5_10cm_mussel<- table_1 %>% filter(.,biosphare=="mussel") %>%
  filter(.,depth!="0")%>%
  filter(.,depth!="15")%>%filter(.,depth!="20")%>%filter(.,depth!="25")%>% 
  filter(.,depth!="30")%>%filter(.,depth!="35")%>%filter(.,depth!="40")%>%
  filter(.,depth!="45")%>%filter(.,depth!="50")%>%filter(.,depth!="55")%>%
  filter(.,depth!="60")%>%filter(.,depth!="65")
com_5_10cm_mussel <- as.matrix(table_1_5_10cm_mussel[,4:ncol(table_1_5_10cm_mussel)])
com_5_10cm_mussel_anosim <- anosim(com_5_10cm_mussel, table_1_5_10cm_mussel$depth, 
                                  distance = "bray", permutations = 9999)

table_1_10_15cm_mussel<-table_1 %>% filter(.,biosphare=="mussel") %>% 
  filter(.,depth!="0")%>%filter(.,depth!="5")%>%
  filter(.,depth!="20")%>%filter(.,depth!="25")%>% filter(.,depth!="30")%>%
  filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
  filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
  filter(.,depth!="65")
com_10_15cm_mussel <- as.matrix(table_1_10_15cm_mussel[,4:ncol(table_1_10_15cm_mussel)])
com_10_15cm_mussel_anosim <- anosim(com_10_15cm_mussel, table_1_10_15cm_mussel$depth, 
                                   distance = "bray", permutations = 9999)

table_1_15_20cm_mussel<- table_1 %>% filter(.,biosphare=="mussel") %>%
  filter(.,depth!="0")%>%filter(.,depth!="5")%>%filter(.,depth!="10")%>%
  filter(.,depth!="25")%>% filter(.,depth!="30")%>%
  filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
  filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
  filter(.,depth!="65")
com_15_20cm_mussel <- as.matrix(table_1_15_20cm_mussel[,4:ncol(table_1_15_20cm_mussel)])
com_15_20cm_mussel_anosim <- anosim(com_15_20cm_mussel, table_1_15_20cm_mussel$depth, 
                                   distance = "bray", permutations = 9999)

table_1_20_25cm_mussel<- table_1 %>% filter(.,biosphare=="mussel") %>% 
  filter(.,depth!="0")%>%filter(.,depth!="5")%>%filter(.,depth!="10")%>%
  filter(.,depth!="15")%>% filter(.,depth!="30")%>%
  filter(.,depth!="35")%>%filter(.,depth!="40")%>%filter(.,depth!="45")%>%
  filter(.,depth!="50")%>%filter(.,depth!="55")%>%filter(.,depth!="60")%>%
  filter(.,depth!="65")
com_20_25cm_mussel <- as.matrix(table_1_20_25cm_mussel[,4:ncol(table_1_20_25cm_mussel)])
com_20_25cm_mussel_anosim <- anosim(com_20_25cm_mussel, table_1_20_25cm_mussel$depth, 
                                   distance = "bray", permutations = 9999)

table_1_0_30cm_mussel<- table_1 %>% filter(.,biosphare=="mussel") %>% 
  filter(.,depth==c("0","5","10","15","20","25","30"))
com_0_30cm_mussel <- as.matrix(table_1_0_30cm_mussel[,4:ncol(table_1_0_30cm_mussel)])
com_0_30cm_mussel_anosim <- anosim(com_0_30cm_mussel, table_1_0_30cm_mussel$depth, 
                                   distance = "bray", permutations = 9999)

