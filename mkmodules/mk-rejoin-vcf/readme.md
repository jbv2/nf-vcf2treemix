# mk-rejoin-vcf
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2020 

---

## Module description:
Concatenates multiple vcf of different chromosomes.

*Outputs will be uncompressed.

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

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

### Output:

An uncompressed simplified vcf with extension `.vcf` with all chromosomes.

Example line(s):

```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3	
chr1	778597	rs74512038	C	T	6290.29	PASS	NS=80;AN=160;AF=0.10625;MAF=0.10625;AC=17;AC_Het=15;AC_Hom=2;AC_Hemi=0;HWE=1;ExcHet=0.797796	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534
chr2	14004	rs142050900	G	A	2435.59	PASS	NS=80;AN=160;AF=0.10625;MAF=0.10625;AC=17;AC_Het=13;AC_Hom=4;AC_Hemi=0;HWE=0.202204;ExcHet=0.963771	GT:AD:DP:GQ:PGT:PID:PL	0/0:14,0:14:42:.:.:0,42,497	0/0:12,0:12:36:.:.:0,36,412	0/1:7,9:16:99:.:.:261,0,199
...
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-rejoin-vcf directory structure

````
mk-rejoin-vcf /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.