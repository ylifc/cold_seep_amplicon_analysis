source("./calculation_code/Step2_rel_abu_calculation_and_sampling_information_collection.R")
source("./calculation_code/geom_ord_ellipse.R")
library(ggrepel)
library(tidyverse)
library(plyr)
library(sysfonts)
library(showtext)
showtext_auto()
font_add("myFont1", "timesbd.ttf")
table_2 <- table_1 %>% filter(depth!="0") %>% filter(depth!="35")%>%
  filter(depth!="40")%>%filter(depth!="45")%>%filter(depth!="50")%>%
  filter(depth!="55")%>%filter(depth!="60")%>%filter(depth!="65")%>%
  filter(depth!="70")
select(-depth,-sample_area,-biosphare)
write_tsv(table_2,"test2.txt")
m_com <- as.matrix(table_2)
nmds = metaMDS(m_com, distance = "bray")
data.scores = as.data.frame(scores(nmds))
grp=as.data.frame(c(rep("clam",31),rep("clam_mat",5),
                    rep("control",25),rep("mussel",46),
                    rep("sea_anemone",12),rep("thintubeworm",24),
                    rep("thintubeworm_mat",5),rep("tubeworm",7)))
colnames(grp)="group"

tiff("./submission/Figure_S1.tiff", units="in",width = 7, height = 5,res = 600)
  ggplot(data = data.scores,aes(x=NMDS1,y=NMDS2,color=grp$group)) +
  geom_point(inherit.aes = TRUE,size=4)+
  scale_shape_manual(values = c(21:28))+
  geom_ord_ellipse(aes(data.scores$NMDS1,data.scores$NMDS2,color=grp$group,group=grp$group),
                   ellipse_pro = 0.95,linetype=3,size=1)+ theme_bw()+
  theme(panel.grid=element_blank())+
  theme(axis.title.x  = element_text(color="black"),
        axis.title.y = element_text(colour = "black"))+
  labs(color="Biosphare")+theme(text = element_text(face = "bold",size=14,family = "Times New Roman"))
  grid.text(expression(bold("NMDS stress = 0.14")), x = 0.85, y = 0.95,gp=gpar(family="Times New Roman"))
  grid.text(expression(bold("ANOSIM p value < 0.0001")), x = 0.85, y = 0.90,gp=gpar(family="Times New Roman"))
  grid.text(expression(bold("ANOSIM R value = 0.356")), x= 0.85, y = 0.85,gp=gpar(family="Times New Roman"))
dev.off()