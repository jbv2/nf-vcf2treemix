#!/usr/bin/env bash

## Find files with .vcf.gz extension

find -L . \
	-type f \
	-name '*.vcf.gz' \
	! -name '*.chunk*' \
| sed 's#.vcf.gz#.SPLITVCF#' \
| xargs mk
