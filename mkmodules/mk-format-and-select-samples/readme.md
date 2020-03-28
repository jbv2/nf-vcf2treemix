# mk-format-and-select-samples
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)
* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)  

**Date:** March 2020

---

## Module description:
Removes unused contigs in header and keeps given samples.

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
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3	sampleX sampleY
chr1	778597	rs74512038	C	T	6290.29	PASS	BaseQRankSum=-1.05;ClippingRankSum=0;ExcessHet=2.3451;FS=10.853;InbreedingCoeff=0.0097;MQ=69.78;MQRankSum=0;POSITIVE_TRAIN_SITE;QD=15.12;ReadPosRankSum=-0.678;SOR=0.306;VQSLOD=9.88;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=713977;GRCH37_REF=C;GRCH37_38_REF_STRING_MATCH;DP=18077;AF=0.0825688;MLEAC=17;MLEAF=0.109;EAS_AF=0.2083;AMR_AF=0.0648;AFR_AF=0.0098;EUR_AF=0.003;SAS_AF=0.0297;AN=160;AC=17	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534
chr1	779047	rs12028261	G	A	61525.2	PASS	BaseQRankSum=0.697;ClippingRankSum=0;ExcessHet=0.7322;FS=0;InbreedingCoeff=0.1074;MQ=66.21;MQRankSum=-0.174;POSITIVE_TRAIN_SITE;QD=30.78;ReadPosRankSum=0.23;SOR=0.686;VQSLOD=4.48;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=714427;GRCH37_REF=G;GRCH37_38_REF_STRING_MATCH;DP=15427;AF=0.795872;MLEAC=139;MLEAF=0.891;EAS_AF=0.7917;AMR_AF=0.8718;AFR_AF=0.4546;EUR_AF=0.9493;SAS_AF=0.9315;AN=160;AC=142	GT:AD:DP:GQ:PGT:PID:PL	1/1:0,17:17:51:.:.:580,51,0	1/1:0,27:27:81:.:.:923,81,0	1/1:0,17:17:51:.:.:601,51,0
```
* A `tsv` with samples to be kept.
Example line(s):
```
#Uncomment samples you want to include in the analysis		
#Otherwise, place a # at the start of the line to exclude samples from the analysis		
Sample1	M	NatMX
Sample2	M	NatMX
Sample3	F	NatMX
...
```

### Output:

An uncompressed simplified vcf with extension `.vcf` only wanted samples and a short header.

Example line(s):

```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3
chr1	778597	rs74512038	C	T	6290.29	PASS	NS=80;AN=160;AF=0.10625;MAF=0.10625;AC=17;AC_Het=15;AC_Hom=2;AC_Hemi=0;HWE=1;ExcHet=0.797796	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534
chr1	779968	rs3131984	T	G	70139.5	PASS	NS=80;AN=160;AF=1;MAF=0;AC=160;AC_Het=0;AC_Hom=160;AC_Hemi=0;HWE=1;ExcHet=1;STR_R2=0.332769;STR_POS=778597	GT:AD:DP:GQ:PL	1/1:0,31:31:93:1093,93,0	1/1:0,24:24:72:814,72,0	1/1:0,23:23:69:798,69,0
```

## Module parameters:
Path to sample list.
SAMPLE_LIST="test/reference/sample_list.tsv"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-format-and-select-samples directory structure

````
mk-format-and-select-samples /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
