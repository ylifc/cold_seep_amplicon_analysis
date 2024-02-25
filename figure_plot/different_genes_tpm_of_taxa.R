library(tidyverse)
library(ggplot2)
library(extrafont)
loadfonts()
setwd("D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/Figure_plot")
wt <- read.table("KO_log10_transferm_need_plot.txt",header = T, sep="\t")%>%as.tibble()
tiff("key_genes_of_shared_genes_between_tree_top_MM.tiff",width = 15000,height=4000,res=900)
wt %>% pivot_longer(cols=c(-Category,-Metabolic.module,-KO,-No),names_to="group",values_to="TPM")%>%
  mutate(group=str_replace(group, "biosphare.*","biosphare"))%>%
  group_by(No,group)%>%
  ggplot(aes(x=group,y=TPM,color=group))+facet_wrap(~No,nrow = 1,scales = "free_x",strip.position = "bottom")+
  stat_summary(fun.data = median_hilow,fun.args=list(conf.int=0.5),
               geom="pointrange",
               position=position_dodge(width = 0.5))+
  labs(x=NULL, y="log10(TPM+1)")+
  geom_boxplot()+scale_color_manual(name=NULL, breaks = c("clam.and.sea.anemone.biosphare","mussel.and.tubeworm.biosphare"),labels=c("Clam and sea anemone biosphare","Mussel and Tubeworm biosphare"),values = c("darkred","darkgreen"))+
  theme_classic()+theme_minimal(base_family = "TimesNewRoman")+
  theme(strip.placement = "outside",
        strip.background = element_blank())+theme(axis.text.x = element_blank())
dev.off()
