#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.fam" \
  ! -name "*.converted.fam" \
| sed 's#.fam#.clust#' \
| xargs mk
