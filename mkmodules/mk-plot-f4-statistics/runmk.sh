#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.f4statistics" \
| sed 's#.f4statistics#.f4raw_plot.svg#' \
| xargs mk
