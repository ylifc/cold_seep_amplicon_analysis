library(tidyverse)
library(ggplot2)
library(extrafont)
loadfonts()
windowsFonts(TimesNewRoman = windowsFont("Times New Roman"))
data <- read.table("KO_depth.txt",sep = "\t",header = T)
ggplot_data <- data%>%as.tibble()%>%pivot_longer(cols=c(-biosphere,-depth),names_to = "genes",values_to = "TPM")%>%
  mutate(genes=factor(genes,levels=c("nirK","nirS","pmoA","hao","narG/narZ/nxrA","nirH","nosZ","norB","norC","nirA","narB","nasC/nasA","nirB","nirD","soxA","soxB","soxC",
                                     "sat/met3","aprA","aprB","dsrA","dsrB","mdh","mcrA","mtrA","mer","mch","aprE","nprE","purH","purD","pyrE","pyrF","ndk","gmk","cobS",
                                     "CobW","folC","bioB","bioD","fabF","fabH","fadA","fadB","aptA","aptG","lysA","thrC","gdhA","adiA")))%>%
  group_by(depth,genes,biosphere)%>%filter(genes!="NA")

tiff("TPM_variation.tiff",width = 9000,height = 8000,res = 600)
ggplot_data%>%ggplot(aes(x=TPM,y=genes,color=biosphere))+facet_wrap(~depth,nrow = 1,scales = "free_x",strip.position = "bottom")+
  stat_summary(fun.data = median_hilow,fun.args=list(conf.int=0.65),
                                                 geom="pointrange",
                                                 position=position_dodge(width = 0.5))+geom_boxplot()+theme_classic()+
  labs(x="Log10(TPM+1)",y="Genes",title = "key genes")+
  theme(axis.title.x  = element_text(face = "bold",size=12,family = "TimesNewRoman"),
        axis.title.y = element_text(face = "bold",size=12,family = "TimesNewRoman"),
        text = element_text(face = "bold",size=12,family = "TimesNewRoman"),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(face = "bold",size=12,family = "TimesNewRoman",color="black"),
        axis.text.y = element_text(face = "bold",size=12,family = "TimesNewRoman"),
        panel.grid.major.x=element_line(color="gray",size = 0.1),
        panel.grid.major.y=element_line(colour = "gray",size=0.1,linetype = "dotted"))+ theme(
          legend.text = element_text(face = "bold",size=1,family = "TimesNewRoman"),
          legend.position="bottom", 
          legend.box = "horizontal", 
          legend.margin=margin(t=0, b=0, l=0, r=0), 
          legend.box.margin=margin(0,0,0,0), 
          legend.key.width=unit(1, "cm"),
          legend.key.height=unit(0.5, "cm"), 
          legend.spacing.x = unit(0.5, 'cm'),
          legend.spacing.y = unit(0.2, 'cm')
        )+guides(color=guide_legend(title=NULL))+
  lims(x=c(0,3))
  
dev.off()
