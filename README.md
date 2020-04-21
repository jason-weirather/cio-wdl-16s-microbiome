# cio-wdl-16s-microbiome

A workflow for executing OTU's from 16S sequencing data.

I'm not an author of the biobakery workflow or affiliated with their lab; this workflow is a dockerized wdl implementation of the [Huttenhower lab](http://huttenhower.sph.harvard.edu
)'s [16S biobakery workflow](https://github.com/biobakery/biobakery/wiki/biobakery_workflows#3-16s-profiling). I recommend using whatever tools the Huttenhower lab site has before using this workflow.  This workflow will versioned and held more static for reproducibility and will likely not keep up with the author's updates. If you find this pipeline helpful and the biobakery workflow useful they have a recommended citation, but please check their site to make sure its the most relevant for your use case:

> McIver LJ, Abu-Ali G, Franzosa EA, Schwager R, Morgan XC, Waldron L, Segata N, Huttenhower C. bioBakery: a meta'omic analysis environment. Bioinformatics. 2018 Apr 1;34(7):1235-1237. PMID: 29194469.

# Quickstart

These instructions are based on my execution of the workflow through a Cromwell `Local Backend`.  

### 1. Install Cromwell 

[here is the latest version](https://github.com/broadinstitute/cromwell/releases/latest)

I also like to set an alias to the jars.  You may want to modify this to include your configuration file depending on how you are running cromwell, but this will just use the default local backend.

I add these to .bashrc

```
alias cromwell='java -jar /your/path/cromwell-49/cromwell-49.jar'
alias womtool='java -jar /your/path/cromwell-49/womtool-49.jar'
```

### 2. Prepare the input files 

Tou can modify `example/input.json` to the appropriate path in your system for an example.

```
{
  "run_biobakery.vsearch.docker": "vacation/cio-wdl-16s-microbiome:latest",
  "run_biobakery.vsearch.samples":{
    "Sample1":[
      "/your/path/cio-wdl-16S-microbiome/data/test/sample1_R1_001.fastq.gz",
      "/your/path/cio-wdl-16S-microbiome/data/test/sample1_R2_001.fastq.gz"
    ],
    "Sample2":[
      "/your/path/cio-wdl-16S-microbiome/data/test/sample2_R1_001.fastq.gz",
      "/your/path/cio-wdl-16S-microbiome/data/test/sample2_R2_001.fastq.gz"
    ],
    "Sample3":[
      "/your/path/cio-wdl-16S-microbiome/data/test/sample3_R1_001.fastq.gz",
      "/your/path/cio-wdl-16S-microbiome/data/test/sample3_R2_001.fastq.gz"
    ]
  }
}
```

### 3. Execute the run

`$ cromwell run -i input.json /your/path/cio-wdl-16S-microbiome/wdl/microbiome.wdl -m output.meta.json`

### 4. Inspect results

In this example, the json file `output.meta.json` will contain a map to all output files.

Here is an example of the `outputs` section of the `output.meta.json` file.

```
"outputs": {
    "run_biobakery.vsearch.categorize_by_function_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_categorize_by_function.tsv",
    "run_biobakery.vsearch.closed_reference_tre": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/closed_reference.tre",
    "run_biobakery.vsearch.anadama_log": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/anadama.log",
    "run_biobakery.vsearch.taxonomy_closed_reference_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_taxonomy_closed_reference.tsv",
    "run_biobakery.vsearch.eestats2_txt": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_eestats2.txt",
    "run_biobakery.vsearch.denovo_otu_table_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_denovo_otu_table.tsv",
    "run_biobakery.vsearch.taxonomy_open_reference_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_taxonomy_open_reference.tsv",
    "run_biobakery.vsearch.otu_mapping_results_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_otu_mapping_results.tsv",
    "run_biobakery.vsearch.predict_metagenomes_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_predict_metagenomes.tsv",
    "run_biobakery.vsearch.read_counts_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_read_counts.tsv",
    "run_biobakery.vsearch.vsearch_otus_tsv": "/homes6/jasonw/LocalWork/test/cromwell-executions/run_biobakery/8718c711-236e-4951-ab40-2c6beca24239/call-vsearch/execution/output_data/all_samples_vsearch_otus.txt"
  }
```

# Details

### Inputs

### Outputs

# Resources

#### Database files

Here I'll try to keep track of reference files used by the workflow.  Thusfar they have been small enough they could be included in the source here and in the docker image, so no additional steps are needed to install these on the user's part.

`picrust` as utilized in this workflow requires two green genes database files.

http://picrust.github.io/picrust/picrust_precalculated_files.html

* [16S_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/16S_13_5_precalculated.tab.gz) 786K md5:`2fb637cbf5b0898bbca15a94e9a08f1f`
* [ko_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/ko_13_5_precalculated.tab.gz) 242M md5:`8220d5b3f48af4a86c1542973a365500`

Additionally, the green genes database is also required.

* 97_otus.fasta `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/rep_set/97_otus.fasta` 137M md5:`50b2269712b3738afb41892bed936c29`
* 97_otu_taxonomy.txt `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt` 9.7M md5:`56ef15dccf2e931ec173f4f977ed649b`
