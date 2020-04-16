# An microbiome pipeline environment
FROM ubuntu:20.04

RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND='noninteractive' apt-get install -y \
               nano \
               wget \
               git \
               apt-utils \
               build-essential \
               sudo \
               libhdf5-serial-dev \
    && apt-get autoremove \
    && apt-get clean


ENV PATH="/opt/conda/bin:${PATH}"
ARG PATH="/opt/conda/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
RUN conda --version

RUN conda install -c conda-forge \
                  -c bioconda \
          python=2.7 \
          cython \
          numpy \
          h5py \
          biom-format==2.1.7 \
          vsearch==2.14.2 \
          clustalo==1.2.3 \
          cogent==1.5.3 \
          fasttree==2.1.10

#          picrust==1.1.0 \ 


RUN pip install --upgrade pip &&\
    pip install anadama2==0.6.7 \
                biobakery-workflows==0.14.3

#RUN conda install -c bioconda vsearch==2.14.2 \
#                              clustalo==1.2.3

RUN wget \
    https://github.com/picrust/picrust/releases/download/1.1.0/picrust-1.1.0.tar.gz \
    && \
    tar -xzf picrust-1.1.0.tar.gz && \
    cd picrust-1.1.0 && \
    pip install -e . 

COPY data/db/ko_13_5_precalculated.tab.bz2 /picrust-1.1.0/picrust/data/
COPY data/db/16S_13_5_precalculated.tab.bz2 /picrust-1.1.0/picrust/data/

RUN bzcat /picrust-1.1.0/picrust/data/ko_13_5_precalculated.tab.bz2 | \
    gzip > /picrust-1.1.0/picrust/data/ko_13_5_precalculated.tab.gz && \
    rm /picrust-1.1.0/picrust/data/ko_13_5_precalculated.tab.bz2 && \
    bzcat /picrust-1.1.0/picrust/data/16S_13_5_precalculated.tab.bz2 | \
    gzip > /picrust-1.1.0/picrust/data/16S_13_5_precalculated.tab.gz && \
    rm /picrust-1.1.0/picrust/data/16S_13_5_precalculated.tab.bz2

COPY data/db/97_otus.fasta.bz2  /database/
COPY data/db/97_otu_taxonomy.txt.bz2  /database/

RUN bzip2 -d /database/97_otus.fasta.bz2 && \
    bzip2 -d /database/97_otu_taxonomy.txt.bz2

ENV GREEN_GENES_USEARCH_DB="/database/97_otus.fasta"
ENV GREEN_GENES_FASTA_DB="/database/97_otus.fasta"
ENV GREEN_GENES_TAXONOMY_DB="/database/97_otu_taxonomy.txt"