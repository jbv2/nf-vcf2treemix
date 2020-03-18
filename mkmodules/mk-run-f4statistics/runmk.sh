#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.treemix.frq.gz" \
| sed 's#.treemix.frq.gz#.f4statistics#' \
| xargs mk
