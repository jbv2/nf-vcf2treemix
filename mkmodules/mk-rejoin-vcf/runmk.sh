#!/bin/bash

find -L . \
  -type f \
  -name "*.chunk*.vcf" \
| sed "s#.chunk[0-9]*##" \
| sort -u \
| xargs mk
