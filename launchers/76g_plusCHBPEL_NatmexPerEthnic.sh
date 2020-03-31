nextflow run vcf2treemix.nf \
	--vcffile real-data/76g_plus_PEL_per_group/76g_1000GP-population_set.vcf.gz \
	--output_dir real-data/76g_plus_PEL_per_group/results \
	-resume \
	-with-report real-data/76g_plus_PEL_per_group/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/76g_plus_PEL_per_group/results/`date +%Y%m%d_%H%M%S`.DAG.html
