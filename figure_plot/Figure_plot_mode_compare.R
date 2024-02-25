library(tidyverse)
library(ggplot2)
install.packages("extrafont")
library(extrafont)
font_import()
loadfonts()
windowsFonts(TimesNewRoman = windowsFont("Times New Roman"))

KO_l1_with_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/with_depth/l1/processed_data/l1_genus_performance.tsv")%>%
        mutate(method="l1_depth")
KO_l1_without_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/without_depth/l1/processed_data/l1_genus_performance.tsv")%>%
  mutate(method="l1")
KO_l2_with_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/with_depth/l2/processed_data/l2_genus_performance.tsv")%>%
  mutate(method="l2_depth")
KO_l2_without_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/without_depth/l2/processed_data/l2_genus_performance.tsv")%>%
  mutate(method="l2")
KO_rf_with_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/with_depth/rf/processed_data/rf_genus_performance.tsv")%>%
  mutate(method="rf_depth")
KO_rf_without_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/without_depth/rf/processed_data/rf_genus_performance.tsv")%>%
  mutate(method="rf")
KO_svm_with_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/with_depth/svm/processed_data/svm_genus_performance.tsv")%>%
  mutate(method="svm_depth")
KO_svm_without_depth <- read_tsv(file = "D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/without_depth/svm/processed_data/svm_genus_performance.tsv")%>%
  mutate(method="svm")
tiff("model_compare.tiff",width = 7000,height=4000,res=900)
bind_rows(KO_l1_with_depth,KO_l1_without_depth,KO_l2_with_depth,KO_l2_without_depth,KO_rf_with_depth,KO_rf_without_depth,KO_svm_with_depth,KO_svm_without_depth)%>%
  select(method,AUC,cv_metric_AUC)%>%rename(Training=cv_metric_AUC,Testing=AUC)%>%pivot_longer(cols=c(Testing,Training),
                                                                                               names_to="training_testing",
                                                                                               values_to="AUC")%>%
  mutate(training_testing=factor(training_testing,levels=c("Training","Testing")),
         model=str_replace(method,"_.*",""),
         model=str_replace(model,"l2","L2 Regularized\nLogistic Regression"),
         model=str_replace(model,"l1","L1 Regularized\nLogistic Regression"),
         model=str_replace(model,"rf","Random Forest"),
         model=str_replace(model,"svm","Support Vector\nMachine"),
         method=str_replace(method, "l1_depth", "KEGG+depth"),
         method=str_replace(method, "l1", "KEGG"),
         method=str_replace(method, "l2_depth", "KEGG+depth"),
         method=str_replace(method, "l2", "KEGG"),
         method=str_replace(method, "rf_depth", "KEGG+depth"),
         method=str_replace(method, "rf", "KEGG"),
         method=str_replace(method, "svm_depth", "KEGG+depth"),
         method=str_replace(method, "svm", "KEGG"))%>%
  ggplot(aes(x=method, y=AUC, color=training_testing))+
  geom_hline(yintercept = 0.87,color="red",linetype="dashed")+
  facet_wrap(~model,nrow = 1,scales = "free_x",strip.position = "bottom")+
  stat_summary(fun.data = median_hilow,fun.args=list(conf.int=0.5),
                                                                     geom="pointrange",
                                                                      position=position_dodge(width = 0.5))+
  lims(y=c(0.5,1))+
  labs(x=NULL, y="Area under the receiver\noperator characteristic curve")+
  scale_color_manual(name=NULL, breaks = c("Training","Testing"),labels=c("Training","Testing"),values = c("grey","dodgerblue"))+
  theme_classic()+theme_minimal(base_family = "TimesNewRoman")+
  theme(strip.placement = "outside",
        strip.background = element_blank())
dev.off()
