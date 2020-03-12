#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.treeout.gz" \
| sed 's#.treeout.gz#.treeplot.svg#' \
| xargs mk
