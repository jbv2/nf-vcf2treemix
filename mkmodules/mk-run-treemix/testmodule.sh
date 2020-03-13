#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export K_VALUE="1000"
export ROOT_POP="YRI"
export BOOTSTRAP_VALUE="100"
export PLINK1="plink"
export MIGRATION_EVENT="1"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are a plink file mixed with clusters, the TreeMix input and TreeMix output.
bash runmk.sh \
&& mv test/data/*.frq.strat* test/data/*miss test/data/*.treemix.frq.gz test/data/*.TreeMix* test/results/ \
&& echo "[>>>] Module Test Successful"
