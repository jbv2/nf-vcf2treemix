input_file="real-data/76g_plus_PEL_per_group/76g_1000GP-population_set.vcf.gz"
output_directory=$(dirname $input_file)/results/

nextflow run vcf2treemix.nf \
	--vcffile $input_file \
	--sample_list real-data/76g_plus_PEL_per_group/reference/sample_list.tsv \
	--pop_order real-data/76g_plus_PEL_per_group/reference/pop_order \
	--root_pop "CHB" \
	--output_dir $output_directory \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
