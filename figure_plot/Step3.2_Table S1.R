source("./calculation_code/Step3_anosim_calculation.R")
TableS1_anosim_test <- tibble(Sample = c("0cm","5cm","10cm","15cm","20cm","25cm","30cm", "0_to_30cm"),
              ANOSIM_R_value=c(com_0cm_anosim[[5]], com_5cm_anosim[[5]], com_10cm_anosim[[5]], 
                com_15cm_anosim[[5]], com_20cm_anosim[[5]], com_25cm_anosim[[5]],
                com_30cm_anosim[[5]],com_0_30cm_anosim[[5]]),
              ANOSIM_Significance_p_value=c(com_0cm_anosim[[2]], com_5cm_anosim[[2]], com_10cm_anosim[[2]],
                com_15cm_anosim[[2]], com_20cm_anosim[[2]], com_25cm_anosim[[2]],
                com_30cm_anosim[[2]],com_0_30cm_anosim[[2]]))
TableS1_permanova_test <- tibble(Sample = c("0cm","5cm","10cm","15cm","20cm","25cm","30cm", "0_to_30cm"),
                              PERMANOVA_R_value=c(com_0cm_permanova[[1]]$R2[1], com_5cm_permanova[[1]]$R2[1], 
                                        com_10cm_permanova[[1]]$R2[1], com_15cm_permanova[[1]]$R2[1],
                                        com_20cm_permanova[[1]]$R2[1], com_25cm_permanova[[1]]$R2[1], 
                                        com_30cm_permanova[[1]]$R2[1],com_0_30cm_permanova[[1]]$R2[1]),
                              PERMANOVA_Significance_p_value=c(com_0cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_5cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_10cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_15cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_20cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_25cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_30cm_permanova[[1]]$`Pr(>F)`[1],
                                                     com_0_30cm_permanova[[1]]$`Pr(>F)`[1]))%>%
                              .[2:ncol(.)]
TableS1 <- cbind(TableS1_anosim_test,TableS1_permanova_test)
write_tsv(TableS1,"./submission/TableS1.txt")
