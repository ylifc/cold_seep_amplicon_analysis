setwd("D:/RESEARCH/cold_seep_different_biosphere/Nutrients")
library(tidyverse)
library(ggplot2)
library(extrafont)
loadfonts()
wt<-read.table("nutrients_summary.txt",header = T,sep = "\t")%>%as.tibble()
ww <- wt%>%pivot_longer(cols=c(-Depth,-Biosphere),names_to="parameters",values_to="values")%>%
  group_by(Depth,Biosphere,parameters)%>%summarize(median=median(values),
                                        l_quartile = quantile(values,prob=0.55),
                                        u_quartile = quantile(values,prob=0.45))%>%
  mutate(parameters=str_replace(parameters,"\\.mg.L","(mg/L)"))%>%
  mutate(parameters=str_replace(parameters,"\\.",""))%>%
  mutate(parameters=str_replace(parameters,"\\.",""))%>%
  mutate(parameters=str_replace(parameters,"\\.",""))
tiff("Nutrients.tiff",width = 9000,height=5000,res=900)
  ggplot(ww,aes(x=median,y=Depth,xmin=l_quartile, xmax=u_quartile))+geom_point()+geom_linerange()+
  facet_grid(Biosphere ~ parameters,scales = "free")+ 
  scale_y_continuous(trans = "reverse")+theme_minimal(base_family = "TimesNewRoman")+
  theme(panel.spacing = unit(1, "lines"),
        strip.background = element_rect(color = "black", fill = "white"))+xlab("")+
    theme(axis.text.x = element_text(size = 6, color = "black"),
          axis.text.y = element_text(size = 6, color = "black"),
          strip.text = element_text(size = 8, color = "red",face = "bold"))
  dev.off()
  