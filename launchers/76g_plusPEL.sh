nextflow run vcf2treemix.nf \
	--vcffile real-data/76g_plus_PEL/76g_1000GP-population_set4_M2_AF05_AN855_76g4PELs.vcf.gz \
	--output_dir real-data/76g_plus_PEL/results \
	-resume \
	-with-report real-data/76g_plus_PEL/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/76g_plus_PEL/results/`date +%Y%m%d_%H%M%S`.DAG.html
