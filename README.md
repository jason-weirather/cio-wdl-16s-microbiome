# cio-wdl-16s-microbiome

A workflow for executing a microbiome workflow

This workflow will extract OTU's from 16S sequencing data.

I'm not an author of the biobakery workflow or affiliated with their lab; this workflow is a dockerized wdl implementation of the [Huttenhower lab](http://huttenhower.sph.harvard.edu
)'s [16S biobakery workflow](https://github.com/biobakery/biobakery/wiki/biobakery_workflows#3-16s-profiling). I recommend using whatever tools the Huttenhower lab site has before using this workflow.  This workflow will versioned and held more static for reproducibility and will likely not keep up with the author's updates. If you find this workflow helpfu, the biobakery workflow useful they have a recommended citation:

> McIver LJ, Abu-Ali G, Franzosa EA, Schwager R, Morgan XC, Waldron L, Segata N, Huttenhower C. bioBakery: a meta'omic analysis environment. Bioinformatics. 2018 Apr 1;34(7):1235-1237. PMID: 29194469.

## Quickstart

#### 1. Download the required database files

`picrust` as utilized in this workflow requires two green genes database files.

http://picrust.github.io/picrust/picrust_precalculated_files.html

* [16S_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/16S_13_5_precalculated.tab.gz) 786K md5:`2fb637cbf5b0898bbca15a94e9a08f1f`
* [ko_13_5_precalculated.tab.gz](http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.4/13_5/ko_13_5_precalculated.tab.gz) 242M md5:`8220d5b3f48af4a86c1542973a365500`

Additionally, the green genes database is also required.

*  97_otus.fasta `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/rep_set/97_otus.fasta` 137M md5:`50b2269712b3738afb41892bed936c29`
* 97_otu_taxonomy.txt `ftp://greengenes.microbio.me/greengenes_release/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt` 9.7M md5:`56ef15dccf2e931ec173f4f977ed649b`
