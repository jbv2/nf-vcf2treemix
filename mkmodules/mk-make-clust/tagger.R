## load libraries
library("dplyr")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "test/data/20kvariantsfromchr1and22_76g_1000GP-population_set.formatted.filtered.LD.maf_filtered.fam" ## %.fam file
# args[2] <- "test/reference/sample_list.tsv" ## $POPULATIONS file
# args[3] <- "test/data/sample.LD.maf_filtered.clust" ## %.clust file

## place args into named object
famfile <- args[1]
tagfile <- args[2]
clustfile <- args[3]


## read files
fam_data.df <- read.table(file = args[1],
                          header = F,
                        sep = "\t", stringsAsFactors = F)

fam_columns_need.df <- fam_data.df %>% select(1, 2)

tag_data.df <- read.table(file = args[2],
                          header = F,
                          sep = "\t", stringsAsFactors = F) %>%
  select(1,3)

## merge files
merged.df <- left_join(fam_columns_need.df[c('V1', 'V2')], by= 'V1', tag_data.df)

## save table
write.table(x = merged.df,
            file = args[3],
            append = F, quote = F,
            sep = "\t",
            row.names = F, col.names = F)
