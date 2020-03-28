# mk-make-clust
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** March 2020 

---

## Module description:
Makes clust file for running smartpca by using tagger.R

* tagger.R is a tool that takes columns of fam file and the groups of samples and makes clust file.

## Module Dependencies:
tagger.R

### Input(s):

* A fam file.
Example line(s):

```
GROUP1 sample1        0       0       0       -9
GROUP1 sample2        0       0       0       -9
GROUP1 sample3        0       0       0       -9
...
```
* A .tsv file with information of the group of the sample that it belongs to.

Example line(s):
```
#Uncomment samples you want to include in the analysis          
#Otherwise, place a # at the start of the line to exclude samples from the analysis             
Sample1        M       NatMX
Sample2        M       NatMX
Sample3        F       NatMX
...
```

### Outputs:

* A `.clust` file separated by tabs. 

Example line(s):

```
GROUP1        Sample1        Subgroup1
GROUP1        Sample2        Subgroup2
GROUP1        Sample3        Subgroup3
...
```

## Module parameters:

`SAMPLE_LIST="test/reference/sample_list.tsv""`

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-make-clust directory structure

````
mk-make-clust /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── tagger.R					 ## Script used in this module.
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
