#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.LD.vcf" \
  ! -name "*.simplified*.vcf" \
| sed 's#.vcf#.maf_filtered.bed#' \
| xargs mk
