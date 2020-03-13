#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf" \
 ! -name "*.LD.vcf" \
| sed 's#.vcf#.LD.vcf#' \
| xargs mk
