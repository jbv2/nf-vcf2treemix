# mk-run-treemix
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** March 2020

---

## Module description:
Prepares treemix input by using plink2treemix.py and runs it.

* plink2treemix.py is a tool that takes bfile of plink and set it to TreeMix input.

TO DO jballesteros: run TreeMix with N migration events

## Module Dependencies:
TreeMix >
[Download and compile smartpca](https://bitbucket.org/nygcresearch/treemix/downloads/)

* plink2treemix.py

### Input(s):

* A binary `.bed`.
* A `.bim` file.

Example line(s):

```
1       rs74512038      0       778597  T       C
1       rs553642122     0       790021  T       C
1       rs4951859       0       794299  G       C
...
```
* A `.fam` file.

Example line(s):

```
GROUP1 sample1        0       0       0       -9
GROUP1 sample2        0       0       0       -9
GROUP1 sample3        0       0       0       -9
...
```
* A `.clust` file separated by tabs.

Example line(s):

```
GROUP1        Sample1        Subgroup1
GROUP1        Sample2        Subgroup2
GROUP1        Sample3        Subgroup3
...
```

### Outputs:

* Many `.TreeMix.*` files, default output of TreeMix.

* A `treemix.frq.gz` file, input for treemix.

Example line(s):

```
Subgroup1 Subgroup2 Subgroup3 Subgroup4 Subgroup5
2,64 45,113 36,124 0,152 53,153
1,65 52,106 43,117 0,152 80,126
0,66 9,149 1,159 0,152 33,173
...
```

## Module parameters:
Variable of k_value, root_pop, bootstrap_value, plink1, migration_event:

K_VALUE="1000"
ROOT_POP="YRI"
BOOTSTRAP_VALUE="100"
PLINK1="plink"
MIGRATION_EVENT="0"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-run-treemix directory structure

````
mk-run-treemix /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── plink2treemix.py					 ## Script used in this module.
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Purcell, S., Neale, B., Todd-Brown, K., Thomas, L., Ferreira, M. A., Bender, D., ... & Sham, P. C. (2007). PLINK: a tool set for whole-genome association and population-based linkage analyses. The American journal of human genetics, 81(3), 559-575.
* Pickrell, J. K., & Pritchard, J. K. (2012). Supplementary Material for: Inference of population splits and mixtures from genome-wide allele frequency data.
