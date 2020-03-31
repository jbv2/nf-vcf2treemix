input_file="test/data_76g/20kvariantsfromchr1and22_76g_1000GP-population_set.vcf.gz"
output_directory=$(dirname $input_file)/results/

echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run vcf2treemix.nf \
	--vcffile $input_file \
	--sample_list test/reference_76g/sample_list.tsv \
	--pop_order test/reference_76g/pop_order \
	--root_pop "YRI" \
	--output_dir $output_directory \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Nf-vcf2TreeMix: Basic pipeline TEST SUCCESSFUL \n======"
