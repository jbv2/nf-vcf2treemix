# mk-split-chromosomes
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** March 2020 

---

## Module description:
Split chromosomes from a compressed vcf file.

*Outputs will be compressed.

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

### Input(s):

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 
Also, it requires the index file with extension `.tbi`

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3	
chr1	778597	rs74512038	C	T	6290.29	PASS	BaseQRankSum=-1.05;ClippingRankSum=0;ExcessHet=2.3451;FS=10.853;InbreedingCoeff=0.0097;MQ=69.78;MQRankSum=0;POSITIVE_TRAIN_SITE;QD=15.12;ReadPosRankSum=-0.678;SOR=0.306;VQSLOD=9.88;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=713977;GRCH37_REF=C;GRCH37_38_REF_STRING_MATCH;DP=18077;AF=0.0825688;MLEAC=17;MLEAF=0.109;EAS_AF=0.2083;AMR_AF=0.0648;AFR_AF=0.0098;EUR_AF=0.003;SAS_AF=0.0297;AN=160;AC=17	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534	
chr22	17279730	rs4819992	T	C	12267.1	PASS	BaseQRankSum=-0.36;ClippingRankSum=0;ExcessHet=6.6084;FS=0.521;InbreedingCoeff=-0.1008;MQ=69.71;MQRankSum=0;POSITIVE_TRAIN_SITE;QD=14.48;ReadPosRankSum=0.52;SOR=0.626;VQSLOD=10.54;culprit=MQRankSum;NS=2504;AA=C|||;VT=SNP;GRCH37_POS=17760620;GRCH37_REF=T;GRCH37_38_REF_STRING_MATCH;DP=21464;AF=0.302752;MLEAC=32;MLEAF=0.205;EAS_AF=0.3214;AMR_AF=0.196;AFR_AF=0.6248;EUR_AF=0.1511;SAS_AF=0.364;AN=160;AC=33	GT:AD:DP:GQ:PL	0/0:36,0:36:99:0,99,1485	0/1:16,22:38:99:670,0,445	0/0:36,0:36:99:0,99,1369
```

### Output:

Many `.chunk#.vcf.gz`. One per chromosome. 

Example line(s):

```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3	
chr1	778597	rs74512038	C	T	6290.29	PASS	BaseQRankSum=-1.05;ClippingRankSum=0;ExcessHet=2.3451;FS=10.853;InbreedingCoeff=0.0097;MQ=69.78;MQRankSum=0;POSITIVE_TRAIN_SITE;QD=15.12;ReadPosRankSum=-0.678;SOR=0.306;VQSLOD=9.88;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=713977;GRCH37_REF=C;GRCH37_38_REF_STRING_MATCH;DP=18077;AF=0.0825688;MLEAC=17;MLEAF=0.109;EAS_AF=0.2083;AMR_AF=0.0648;AFR_AF=0.0098;EUR_AF=0.003;SAS_AF=0.0297;AN=160;AC=17	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534	
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-split-chromosomes directory structure

````
mk-split-chromosomes /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.