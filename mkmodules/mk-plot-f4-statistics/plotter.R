## load libraries
library("dplyr")
library("ggplot2")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "test/data/20kvariantsfromchr1and22_76g_1000GP-population_set.formatted.filtered.LD.maf_filtered.f4.tsv" ## %.tsv file
# args[2] <- "test/data/20kvariantsfromchr1and22_76g_1000GP-population_set.formatted.filtered.LD.maf_filtered.f4raw_plot.svg" ## raw svg file
 

## place args into named object
f4_tsv <- read.table(file = args[1], header = T, sep = "\t", stringsAsFactors = F)
output_file <- args[2]
output_file2 <- gsub(pattern = ".f4raw_plot.svg", replacement = ".f4significant_plot.svg", x = output_file)

#Making plot
f4_raw.p <- ggplot(f4_tsv, aes(f4_statistic, Z_score, colour = Tested_Tree)) +
  geom_point() +
  geom_errorbarh(aes(xmax = f4_statistic + Standard_error, xmin = f4_statistic - Standard_error)) +
  ylab("Z score") +
  xlab("f4 values") +
  ggtitle(label = "Raw results of f4 statistics") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 15)) 

## save plot
ggsave(filename = output_file,
       plot = f4_raw.p,
       device = "svg",
       width = 10, height = 7 , units = "in",
       dpi = 300)

## Filter data  by Zscore < -3 and > 3
f4_significant <- f4_tsv %>%
  filter(Z_score < -3 | Z_score > 3)

#Making plot
f4_significant.p <- ggplot(f4_significant, aes(f4_statistic, Z_score, colour = Tested_Tree)) +
  geom_point() +
  geom_errorbarh(aes(xmax = f4_statistic + Standard_error, xmin = f4_statistic - Standard_error)) +
  geom_hline(yintercept = -3,colour="#990000", linetype="dashed") +
  geom_hline(yintercept = 3,colour="#990000", linetype="dashed") +
  geom_vline(xintercept = 0, colour="#990000", linetype="dashed") +
  ylab("Z score") +
  xlab("f4 values") +
  ggtitle(label = "Significant results of f4 statistics") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 15)) 
  

## save plot
ggsave(filename = output_file2,
       plot = f4_significant.p,
       device = "svg",
       width = 10, height = 7 , units = "in",
       dpi = 300)


