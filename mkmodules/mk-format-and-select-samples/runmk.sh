#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf.gz" \
  ! -name ".formatted.vcf"  \
| sed 's#.vcf.gz#.formatted.vcf#' \
| xargs mk
