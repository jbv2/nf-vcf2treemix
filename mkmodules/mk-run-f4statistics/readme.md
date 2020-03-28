# mk-run-f4statistics
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** March 2020 

---

## Module description:
Runs f4 statistics.

## Module Dependencies:
threepop >
[Download and compile smartpca](https://bitbucket.org/nygcresearch/treemix/downloads/)

### Input(s):

* A `treemix.frq.gz` file, input for treemix.

Example line(s):

```
Subgroup1 Subgroup2 Subgroup3 Subgroup4 Subgroup5 
2,64 45,113 36,124 0,152 53,153 
1,65 52,106 43,117 0,152 80,126 
0,66 9,149 1,159 0,152 33,173
...
```

### Outputs:

* A `.f4statistics` file with f4 values with columns indicating:
[tested tree][f_4 statistic][standard error][Z-score]

Example line(s):

```
npop:5 nsnp:2826
Estimating covariance matrix in 2 blocks of size 1000
Estimating f_4 in 2 blocks of size 1000
total_nsnp 2826 nsnp 2826
Subgroup1,Subgroup2;Subgroup3,Subgroup4 -0.0205164 0.00813115 -2.52318
Subgroup1,Subgroup4;Subgroup3,Subgroup2 -0.00345427 0.000435442 -7.93278
...
```

## Module parameters:
Variable of k_value:

K_VALUE="1000"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-run-f4statistics directory structure

````
mk-run-f4statistics /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Pickrell, J. K., & Pritchard, J. K. (2012). Supplementary Material for: Inference of population splits and mixtures from genome-wide allele frequency data.