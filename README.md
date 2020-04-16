# CIO-16S-microbiome-workflow
A workflow for executing a microbiome workflow

This workflow will extract OTU's from 16S sequencing data.

This workflow is a dockerized wdl implementation of the [Huttenhower lab](http://huttenhower.sph.harvard.edu
)'s [16S biobakery workflow](https://github.com/biobakery/biobakery/wiki/biobakery_workflows#3-16s-profiling)

## Quickstart

#### 1. Download the required database files

`picrust` as utilized in this workflow requires two green genes database files.

http://picrust.github.io/picrust/picrust_precalculated_files.html

* [16S_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/16S_13_5_precalculated.tab.gz) 786K md5:`2fb637cbf5b0898bbca15a94e9a08f1f`
* [ko_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/ko_13_5_precalculated.tab.gz) 242M md5:`8220d5b3f48af4a86c1542973a365500`

Additionally, the green genes database is also required.

*  97_otus.fasta `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/rep_set/97_otus.fasta` 137M md5:`50b2269712b3738afb41892bed936c29`
* 97_otu_taxonomy.txt `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt` 9.7M md5:`56ef15dccf2e931ec173f4f977ed649b`
