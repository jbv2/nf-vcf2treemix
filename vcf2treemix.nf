#!/usr/bin/env nextflow

/*================================================================
The MORETT LAB presents...

  A treemix maker pipeline.

==================================================================
Version: 0.0.1
Project repository:
==================================================================
Authors:

- Bioinformatics Design
 Judith Ballesteros Villascán (judith.vballesteros@gmail.com)
 Israel Aguilar-Ordonez (iaguilaror@gmail)

- Bioinformatics Development
 Judith Ballesteros Villascán (judith.vballesteros@gmail.com)
 Israel Aguilar-Ordonez (iaguilaror@gmail)

- Nextflow Port
 Judith Ballesteros Villascán (judith.vballesteros@gmail.com)
 Israel Aguilar-Ordonez (iaguilaror@gmail)

=============================
Pipeline Processes In Brief:
.
Pre-processing:
_pre1_split_chromosomes
_pre2_formatvcf
_pre3_filtervcf
_pre4_remove_LD
_pre5_rejoinvcf

_pre6_vcf2plink
_pre7_make_clust

Core-processing:
_001_run_treemix
_002_run_f3statistics
_003_run_f4statistics

Pos-processing
_post1_plot_treemix
_post2_plot_f3statistics
_post3_plot_f4statistics

================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  A vcf Nf-vcf2TreeMix pipeline
  v${version}
  ==========================================

	Usage:

  nextflow run vcf2treemix.nf --vcffile <path to input 1> [--output_dir path to results ]

	  --vcffile    <- compressed vcf file for annotation;
				accepted extension is vcf.gz;
				vcf file must have a TABIX index with .tbi extension, located in the same directory as the vcf file
	  --output_dir     <- directory where results, intermediate and log files will bestored;
				default: same dir where --query_fasta resides
	  -resume	   <- Use cached results if the executed project has been run before;
				default: not activated
				This native NF option checks if anything has changed from a previous pipeline execution.
				Then, it resumes the run from the last successful stage.
				i.e. If for some reason your previous run got interrupted,
				running the -resume option will take it from the last successful pipeline stage
				instead of starting over
				Read more here: https://www.nextflow.io/docs/latest/getstarted.html#getstart-resume
	  --help           <- Shows Pipeline Information
	  --version        <- Show ExtendAlign version
	""".stripIndent()
}

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
version = "0.0.2"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "nf-vcf2TreeMix"

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.vcffile = false  //if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.help = false //default is false to not trigger help message automatically at every run
params.version = false //default is false to not trigger version message automatically at every run

/*//////////////////////////////
  If the user inputs the --help flag
  print the help message and exit pipeline
*/
if (params.help){
	helpMessage()
	exit 0
}

/*//////////////////////////////
  If the user inputs the --version flag
  print the pipeline version
*/
if (params.version){
	println "NF-vcf2TreeMix v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at FEB 2019
*/
nextflow_required_version = '18.10.1'
/*
  Try Catch to verify compatible Nextflow version
  If user Nextflow version is lower than the required version pipeline will continue
  but a message is printed to tell the user maybe it's a good idea to update her/his Nextflow
*/
try {
	if( ! nextflow.version.matches(">= $nextflow_required_version") ){
		throw GroovyException('Your Nextflow version is older than Pipeline required version')
	}
} catch (all) {
	log.error "-----\n" +
			"  This pipeline requires Nextflow version: $nextflow_required_version \n" +
      "  But you are running version: $workflow.nextflow.version \n" +
			"  The pipeline will continue but some things may not work as intended\n" +
			"  You may want to run `nextflow self-update` to update Nextflow\n" +
			"============================================================"
}

/*//////////////////////////////
  INPUT PARAMETER VALIDATION BLOCK
  TODO (jballesteros) check output plot
*/

/* Check if vcffile provided
    if they were not provided, they keep the 'false' value assigned in the parameter initiation block above
    and this test fails
*/
if ( !params.vcffile ) {
  log.error " Please provide both, the --vcffile \n\n" +
  " For more information, execute: nextflow run vcf2TreeMix.nf --help"
  exit 1
}

/*
Output directory definition
Default value to create directory is the parent dir of --vcffile
*/
params.output_dir = file(params.vcffile).getParent()

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script

  This directories will be automatically created by the pipeline to store files during the run
*/
results_dir = "${params.output_dir}/${pipeline_name}-results/"
intermediates_dir = "${params.output_dir}/${pipeline_name}-intermediate/"

/*
Useful functions definition
*/
/* define a function for extracting the file name from a full path */
/* The full path will be the one defined by the user to indicate where the reference file is located */
def get_baseName(f) {
	/* find where is the last appearance of "/", then extract the string +1 after this last appearance */
  	f.substring(f.lastIndexOf('/') + 1);
}


/*//////////////////////////////
  LOG RUN INFORMATION
*/
log.info"""
==========================================
The Nf-vcf2TreeMix
v${version}
==========================================
"""
log.info "--Nextflow metadata--"
/* define function to store nextflow metadata summary info */
def nfsummary = [:]
/* log parameter values beign used into summary */
/* For the following runtime metadata origins, see https://www.nextflow.io/docs/latest/metadata.html */
nfsummary['Resumed run?'] = workflow.resume
nfsummary['Run Name']			= workflow.runName
nfsummary['Current user']		= workflow.userName
/* string transform the time and date of run start; remove : chars and replace spaces by underscores */
nfsummary['Start time']			= workflow.start.toString().replace(":", "").replace(" ", "_")
nfsummary['Script dir']		 = workflow.projectDir
nfsummary['Working dir']		 = workflow.workDir
nfsummary['Current dir']		= workflow.launchDir
nfsummary['Launch command'] = workflow.commandLine
log.info nfsummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "\n\n--Pipeline Parameters--"
/* define function to store nextflow metadata summary info */
def pipelinesummary = [:]
/* log parameter values beign used into summary */
pipelinesummary['VCFfile']			= params.vcffile
// pipelinesummary['vars per chunk']			= params.variants_per_chunk
pipelinesummary['Results Dir']		= results_dir
pipelinesummary['Intermediate Dir']		= intermediates_dir
/* print stored summary info */
log.info pipelinesummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "==========================================\nPipeline Start"

/*//////////////////////////////
  PIPELINE START
*/

/*
	READ INPUTS
*/

/* Load vcf file and .tbi into channel */
Channel
  .fromPath("${params.vcffile}*")
	.toList()
  .set{ vcf_inputs }

/* _pre1_split_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-split-chromosomes/*")
	.toList()
	.set{ mkfiles_pre1 }

process _pre1_split_chromosomes {

	publishDir "${intermediates_dir}/_pre1_split_chromosomes/",mode:"symlink"

	input:
	file vcf from vcf_inputs
	file mk_files from mkfiles_pre1

	output:
	file "*.chunk*" into results_pre1_split_chromosomes mode flatten

	"""
	bash runmk.sh
	"""

}

/* _pre2_formatvcf */
/* Read sample list */
Channel
	.fromPath("${params.sample_list}*")
	.toList()
	.set{ sample_list }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-format-and-select-samples/*")
	.toList()
	.set{ mkfiles_pre2 }

process _pre2_formatvcf {

	publishDir "${intermediates_dir}/_pre2_formatvcf/",mode:"symlink"

	input:
	file vcf from results_pre1_split_chromosomes
	file reference from sample_list
	file mk_files from mkfiles_pre2

	output:
	file "*.vcf" into results_pre2_formatvcf


	"""
	export SAMPLE_LIST="$reference"
	bash runmk.sh
	"""

}

/* _pre3_filtervcf */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-filter-vcf/*")
	.toList()
	.set{ mkfiles_pre3 }

process _pre3_filtervcf {

	publishDir "${intermediates_dir}/_pre3_filtervcf/",mode:"symlink"

	input:
	file vcf from results_pre2_formatvcf
	file mk_files from mkfiles_pre3

	output:
	file "*.filtered.vcf" into results_pre3_filtervcf

	"""
	bash runmk.sh
	"""

}

/* 	Process _pre4_remove_LD */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-remove-LD/*")
	.toList()
	.set{ mkfiles_pre4 }

process _pre4_remove_LD {

	publishDir "${intermediates_dir}/_pre4_remove_LD/",mode:"symlink"

	input:
	file vcf from results_pre3_filtervcf
	file mk_files from mkfiles_pre4

	output:
	file "*.LD.vcf" into results_pre4_remove_LD

	"""
	export LD="${params.ld}"
	export WINDOW="${params.window}"
	export N_sites="${params.n_sites}"
	bash runmk.sh
	"""

}

/* Gather every previous result from pre4 before rejoining */
results_pre4_remove_LD
.toList()
.set{ all_chunks }

/* 	Process _pre5_rejoinvcf */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-rejoin-vcf/*")
	.toList()
	.set{ mkfiles_pre5 }

process _pre5_rejoinvcf {

	publishDir "${intermediates_dir}/_pre5_rejoinvcf/",mode:"symlink"

	input:
	file chunks from all_chunks
	file mk_files from mkfiles_pre5

	output:
	file "*.vcf" into results_pre5_rejoinvcf

	"""
	bash runmk.sh
	"""

}

/* 	Process _pre6_vcf2plink */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-vcf2plink/*")
	.toList()
	.set{ mkfiles_pre6 }

process _pre6_vcf2plink {

	publishDir "${intermediates_dir}/_pre6_vcf2plink/",mode:"symlink"

	input:
	file vcf from results_pre5_rejoinvcf
	file mk_files from mkfiles_pre6

	output:
	file "*.maf_filtered.*" into results_pre6_vcf2plink

	"""
	export PLINK="${params.plink2}"
	export MAF="${params.maf}"
	export THREADS_PLINK="${params.threads_plink}"
	bash runmk.sh
	"""

}

/* 	Process _pre7_make_clust */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-make-clust/*")
	.toList()
	.set{ mkfiles_pre7 }

process _pre7_make_clust {

	publishDir "${intermediates_dir}/_pre7_make_clust/",mode:"symlink"

	input:
	file bfile from results_pre6_vcf2plink
	file reference from sample_list
	file mk_files from mkfiles_pre7

	output:
	file "*.clust" into results_pre7_make_clust

	"""
	export SAMPLE_LIST="$reference"
	bash runmk.sh
	"""

}

/* 	Process _001_run_treemix */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-run-treemix/*")
	.toList()
	.set{ mkfiles_001 }

process _001_run_treemix {

	publishDir "${params.output_dir}/${pipeline_name}-results/_001_run_treemix/",mode:"copy"

	input:
  file bfile from results_pre6_vcf2plink
  file clust from results_pre7_make_clust
  file mk_files from mkfiles_001

	output:
	file "*.TreeMix.*" into results_001_run_treemix
	file "*.treemix.*" into results_01_run_treemix

	"""
	export K_VALUE="${params.k_value}"
	export ROOT_POP="${params.root_pop}"
	export BOOTSTRAP_VALUE="${params.bootstrap_value}"
	export PLINK1="${params.plink1}"
	export MIGRATION_EVENT="${params.migration_event}"
	bash runmk.sh
	"""

}
//
// /* 	Process _002_run_f3statistics */
// /* Read mkfile module files */
// Channel
// 	.fromPath("${workflow.projectDir}/mkmodules/mk-run-f3statistics/*")
// 	.toList()
// 	.set{ mkfiles_002 }
//
// process _002_run_f3statistics {
//
// 	publishDir "${params.output_dir}/${pipeline_name}-results/_002_run_f3statistics/",mode:"copy"
//
// 	input:
//   file input_treemix from results_01_run_treemix
//   file mk_files from mkfiles_002
//
// 	output:
// 	file "*.f3statistics" into results_002_run_f3statistics
//
// 	"""
// 	export K_VALUE="${params.k_value}"
// 	bash runmk.sh
// 	"""
//
// }
//
// /* 	Process _003_run_f4statistics */
// /* Read mkfile module files */
// Channel
// 	.fromPath("${workflow.projectDir}/mkmodules/mk-run-f4statistics/*")
// 	.toList()
// 	.set{ mkfiles_003 }
//
// process _003_run_f4statistics {
//
// 	publishDir "${params.output_dir}/${pipeline_name}-results/_003_run_f4statistics/",mode:"copy"
//
// 	input:
//   file input_treemix from results_01_run_treemix
//   file mk_files from mkfiles_003
//
// 	output:
// 	file "*.f4statistics" into results_003_run_f4statistics
//
// 	"""
// 	export K_VALUE="${params.k_value}"
// 	bash runmk.sh
// 	"""
//
// }
//
/* 	Process _post1_plot_treemix */

/* Read pop order file */
Channel
	.fromPath("${params.pop_order}*")
	.toList()
	.set{ pop_order }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-plot-treemix/*")
	.toList()
	.set{ mkfiles_post1 }

process _post1_plot_treemix {

	publishDir "${params.output_dir}/${pipeline_name}-results/_post1_plot_treemix/",mode:"copy"

	input:
  file treemix from results_001_run_treemix
	file reference from pop_order
  file mk_files from mkfiles_post1

	output:
	file "*"

	"""
	export POP_ORDER="$reference"
	bash runmk.sh
	"""

}
//
// /* 	Process _post2_plot_f3statistics */
// /* Read mkfile module files */
// Channel
// 	.fromPath("${workflow.projectDir}/mkmodules/mk-plot-f3-statistics/*")
// 	.toList()
// 	.set{ mkfiles_post2 }
//
// process _post2_plot_f3statistics {
//
// 	publishDir "${params.output_dir}/${pipeline_name}-results/_post2_plot_f3statistics/",mode:"copy"
//
// 	input:
//   file f3 from results_002_run_f3statistics
//   file mk_files from mkfiles_post2
//
// 	output:
// 	file "*"
//
// 	"""
// 	bash runmk.sh
// 	"""
//
// }
//
// /* 	Process _post3_plot_f4statistics */
// /* Read mkfile module files */
// Channel
// 	.fromPath("${workflow.projectDir}/mkmodules/mk-plot-f4-statistics/*")
// 	.toList()
// 	.set{ mkfiles_post3 }
//
// process _post3_plot_f4statistics {
//
// 	publishDir "${params.output_dir}/${pipeline_name}-results/_post3_plot_f4statistics/",mode:"copy"
//
// 	input:
//   file f4 from results_003_run_f4statistics
//   file mk_files from mkfiles_post3
//
// 	output:
// 	file "*"
//
// 	"""
// 	bash runmk.sh
// 	"""
//
// }
