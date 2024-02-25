source("./calculation_code/Step3_anosim_calculation.R")
TableS1_anosim_test <- tibble(Sample = c("0cm","5cm","10cm","15cm","20cm","25cm","30cm", "0_to_30cm", "5_to_30cm"),
              R_value=c(com_0cm_anosim[[5]], com_5cm_anosim[[5]], com_10cm_anosim[[5]], 
                com_15cm_anosim[[5]], com_20cm_anosim[[5]], com_25cm_anosim[[5]],
                com_30cm_anosim[[5]],com_all_layers_anosim[[5]],com_5_30cm_anosim[[5]]),
              Significance_p_value=c(com_0cm_anosim[[2]], com_5cm_anosim[[2]], com_10cm_anosim[[2]],
                com_15cm_anosim[[2]], com_20cm_anosim[[2]], com_25cm_anosim[[2]],
                com_30cm_anosim[[2]],com_all_layers_anosim[[2]],com_5_30cm_anosim[[2]]))
write_tsv(TableS1_anosim_test,"TableS1.txt")