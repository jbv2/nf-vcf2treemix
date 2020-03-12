## Load libraries
library("svglite")
source("plotting_funcs.R")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "test/data/TreeMix" ## %.Treemix* files
# args[2] <- "test/reference/pop_order" ## For residual fit plot
# args[3] <- "test/data/TreeMix.treeplot.svg" ## Tree output plot


## Passing args to named objects
Treemix <- args[1]
pop_order <- args[2]
svg_file1 <- args[3]
svg_file2 <- gsub(pattern = ".treeplot.svg", replacement = ".residual_plot.svg", x = svg_file1)

## save plot
svglite(file = svg_file1, width = 10, height = 7)
plot_tree(Treemix)
dev.off()

## save plot
svglite(file = svg_file2, width = 10, height = 7)
plot_resid(Treemix, pop_order)
dev.off()
