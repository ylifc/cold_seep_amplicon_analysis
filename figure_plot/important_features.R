library(tidyverse)
library(ggplot2)
library(extrafont)
loadfonts()
setwd("D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/with_depth/l2/")
windowsFonts(TimesNewRoman = windowsFont("Times New Roman"))
l2_files <- list.files(path = "processed_data",
                       pattern = "*.Rds",
                       full.names = TRUE)
test <-l2_files[1]
  
ll <- readRDS(test)%>%pluck("feature_importance") %>% as.tibble()%>%select(feat,perf_metric,perf_metric_diff)


get_feature_importance <- function(file_name) {
    feature_importance <- readRDS(file_name)%>%pluck("feature_importance") %>% as.tibble()%>%select(feat,perf_metric,perf_metric_diff)
}
l2_feature_importance <- map_dfr(l2_files,get_feature_importance)
l2_feature_importance %>%rename(feature=feat)%>% group_by(feature)%>%summarize(median=median(perf_metric_diff),
                                                                               l_quartile = quantile(perf_metric_diff,prob=0.25),
                                                                               u_quartile = quantile(perf_metric_diff,prob=0.75))%>%
  mutate(feature=fct_reorder(feature,median))%>%filter(median>0.5)%>%write.csv("rf_feature_importance2.csv")

setwd("D:/RESEARCH/cold_seep_different_biosphere/metagenome_ML/Figure_plot/")
wt <- read.table(file = "renamed_metabolic_modules.txt",sep = "\t",header = T)
tiff("ML_KO_0.5.tiff",width = 3500,height=2000,res=900)
wt%>%mutate(feature=fct_reorder(feature,median))%>%ggplot(aes(x=median,y=feature,xmin=l_quartile, xmax=u_quartile))+geom_point()+geom_linerange()+
  geom_vline(xintercept = 0.55,color="red",linetype="dashed")+theme_classic()+theme_minimal(base_family = "TimesNewRoman")+
  theme(strip.placement = "outside",
        strip.background = element_blank())
dev.off()
