# mk-vcf2PLINK
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)
* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2020 

---

## Module description:
Converts vcf to plink and filters MAF.

*Outputs will be uncompressed.

## Module Dependencies:
Plink2 >
[Download and compile plink2](https://www.cog-genomics.org/plink/2.0/)

### Input(s):

A `VCF` file with a `.vcf` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3	
chr1	778597	rs74512038	C	T	6290.29	PASS	NS=80;AN=160;AF=0.10625;MAF=0.10625;AC=17;AC_Het=15;AC_Hom=2;AC_Hemi=0;HWE=1;ExcHet=0.797796	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534
...
```

### Outputs:

* A binary `.bed` filtered by maf.
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


## Module parameters:

PLINK2="plink2"
MAF="0.05"
THREADS_PLINK="4"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-vcf2PLINK directory structure

````
mk-vcf2PLINK /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Purcell, S., Neale, B., Todd-Brown, K., Thomas, L., Ferreira, M. A., Bender, D., ... & Sham, P. C. (2007). PLINK: a tool set for whole-genome association and population-based linkage analyses. The American journal of human genetics, 81(3), 559-575.