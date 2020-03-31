#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.f3statistics" \
| sed 's#.f3statistics#.f3raw_plot.svg#' \
| xargs mk
