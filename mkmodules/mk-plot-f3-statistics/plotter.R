## load libraries
library("dplyr")
library("ggplot2")
library(tibble)

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## Uncomment For debugging only
## Comment for production mode only
 args[1] <- "test/data/76g_1000GP-population_set.formatted.filtered.LD.maf_filtered.f3.tsv" ## %.tsv file
 args[2] <- "test/data/76g_1000GP-population_set.formatted.filtered.LD.maf_filtered.f3raw_plot.svg" ## raw svg file
 

## place args into named object
f3_tsv <- read.table(file = args[1], header = T, sep = "\t", stringsAsFactors = F)
output_file <- args[2]
output_file2 <- gsub(pattern = ".f3raw_plot.svg", replacement = ".f3significant_plot.svg", x = output_file)

abs_y <- abs(x = f3_tsv$Z_score)
abs_x <- abs(x = f3_tsv$f3_statistic)

#Making plot
#f3 general overview 
f3_raw.p <- ggplot(f3_tsv, aes(f3_statistic, Z_score, colour = Tested_Tree)) +
  ylim(-max(abs_y), max(abs_y)) +
  xlim(-max(abs_x), max(abs_x)) +
  geom_hline(yintercept = 0,colour="black", linetype="solid") +
  geom_vline(xintercept = 0,colour="black", linetype="solid") +
  geom_hline(yintercept = -2,colour="#990000", linetype="dashed") +
  geom_point() +
  geom_errorbarh(aes(xmax = f3_statistic + Standard_error, xmin = f3_statistic - Standard_error)) +
  geom_label(data = f3_tsv %>% filter(f3_statistic < 0 & Z_score < -2), # Filter data first
      aes(label=Tested_Tree)) +
  ylab("Z score") +
  xlab("f3 values") +
  ggtitle(label = "Raw results of f3 statistics") +
  theme(plot.title = element_text(hjust = 0.5, size = 15),
        panel.background = element_blank(),
        panel.border = element_rect(linetype = "solid", fill = NA),
        legend.position="none") 

## save plot
ggsave(filename = output_file,
       plot = f3_raw.p,
       device = "svg",
       width = 10, height = 7 , units = "in",
       dpi = 300)

## Filter data  by Zscore < -2
f3_significant <- f3_tsv %>%
  filter(f3_statistic < 0) %>%
  filter(Z_score < -2)

#Making plot
f3_significant.p <-ggplot(f3_significant, aes(f3_statistic, Z_score, colour = Tested_Tree)) +
  geom_hline(yintercept = 0,colour="black", linetype="solid") +
  geom_vline(xintercept = 0,colour="black", linetype="solid") +
  geom_hline(yintercept = -2,colour="#990000", linetype="dashed") +
  geom_point() +
  geom_errorbarh(aes(xmax = f3_statistic + Standard_error, xmin = f3_statistic - Standard_error)) +
  ylim(-15,-2) +
  xlim(-5,0.5) +
  ylab("Z score") +
  xlab("f3 values") +
  geom_label(data = f3_tsv %>% filter(f3_statistic < 0 & Z_score < -2), # Filter data first
             aes(label=Tested_Tree)) +
  ggtitle(label = "Significant results of f3 statistics") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 15)) 
  

## save plot
ggsave(filename = output_file2,
       plot = f3_significant.p,
       device = "svg",
       width = 10, height = 7 , units = "in",
       dpi = 300)


