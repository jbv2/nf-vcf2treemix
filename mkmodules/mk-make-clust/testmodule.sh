#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export POPULATIONS="./test/reference/samples.txt"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results file is *.clust
bash runmk.sh \
&& mv test/data/*.clust test/results/ \
&& echo "[>>>] Module Test Successful"
