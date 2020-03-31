echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run vcf2treemix.nf \
	--vcffile test/data_76g/20kvariantsfromchr1and22_76g_1000GP-population_set.vcf.gz \
	--sample_list test/reference_76g/sample_list.tsv \
	--pop_order test/reference_76g/pop_order \
	--output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Nf-vcf2TreeMix: Basic pipeline TEST SUCCESSFUL \n======"
