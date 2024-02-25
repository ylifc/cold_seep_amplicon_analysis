table_1 <- read_tsv("./raw_data/Bacteria_Archaea4.txt")
source("./calculation_code/geom_ord_ellipse.R")
library(ggrepel)
library(tidyverse)
library(plyr)
library(showtext)
library(grid)
library(ggtext)
font_files() %>% tibble()%>%filter(str_detect(family, "Times"))%>%pull(family)
font_add(family = "Times", regular="Times New Roman.ttf")
showtext_auto()
table_2 <- table_1 %>%select(-Biosphare,-Depth)
m_com <- as.matrix(table_2)
nmds = metaMDS(m_com, distance = "bray")
data.scores = as.data.frame(scores(nmds))
grp=as.data.frame(c(rep("Clam and sea anemone biosphare",60),
                    rep("None seep region",98),rep("Mussel and tubeworm biosphare",30)))
lnames(grp)="group"

tiff("./submission/Figure_S1.tiff", units="in",width = 8, height = 6,res = 600)
  ggplot(data = data.scores,aes(x=NMDS1,y=NMDS2,color=grp$group)) +
  geom_point(inherit.aes = TRUE,size=4)+
  scale_shape_manual(values = c(21:28))+
  geom_ord_ellipse(aes(NMDS1,NMDS2,color=grp$group,group=grp$group),
                   ellipse_pro = 0.92,linetype=3,size=1)+ theme_bw()+
  theme(panel.grid=element_blank())+
  theme(axis.title.x  = element_text(color="black", face = "bold"),
        axis.title.y = element_text(colour = "black",face = "bold"))+
  labs(x="NMDS1", y="NMDS2", title = "From 0 cm to 30 cm (Species level)",
       caption = "NMDS stress = 0.15;   ANOSIM <i>p</i> value < 0.0001;   ANOSIM R value = 0.57<br>PERMANOVA R value = 0.21;    PERMANOVA <i>p</i> value < 0.0001",
       color="Biosphare")+theme(text = element_text(face = "bold",size=14,family = "Times"),
                                plot.title = element_text(face = "bold",hjust = 0.5),
                                plot.caption = element_markdown(hjust = 0),
                                plot.title.position  = "panel",
                                plot.caption.position = "plot")
dev.off()
