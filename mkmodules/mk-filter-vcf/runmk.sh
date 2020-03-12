#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf" \
  ! -name ".filtered.vcf"  \
| sed 's#.vcf#.filtered.vcf#' \
| xargs mk
