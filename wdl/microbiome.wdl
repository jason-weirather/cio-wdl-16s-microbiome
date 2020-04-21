# Input: Take an array of bams and merge them
#           optionally can take another array of bams that also get merged
# Output: A sorted merged bam

task vsearch {
    Map[String,Array[File]] samples

    Int? memory = 16
    Int? disk_space = 200
    Int? num_cpu = 8
    Int? num_preempt = 0
    Int? boot_disk_gb = 10

    String? docker = "vacation/cio-wdl-16s-microbiome:latest"
    runtime {
        docker: "${docker}"
        memory: "${memory} GB"
        disks: "local-disk ${disk_space} HDD"
        cpu: "${num_cpu}"
        preemptible: "${num_preempt}"
        bootDiskSizeGb: "${boot_disk_gb}"
        zones: "us-east1-b"
    }
    command <<<
        python /scripts/prepare_inputs.py ${write_json(samples)}
        mkdir mytempdir
        mkdir output_data
        biobakery_workflows 16s --input mytempdir --output output_data --method vsearch
    >>>
    output {
        File categorize_by_function_tsv = "output_data/all_samples_categorize_by_function.tsv"
        File denovo_otu_table_tsv = "output_data/all_samples_denovo_otu_table.tsv"
        File eestats2_txt = "output_data/all_samples_eestats2.txt"
        File otu_mapping_results_tsv = "output_data/all_samples_otu_mapping_results.tsv"
        File predict_metagenomes_tsv = "output_data/all_samples_predict_metagenomes.tsv"
        File read_counts_tsv = "output_data/all_samples_read_counts.tsv"
        File taxonomy_closed_reference_tsv = "output_data/all_samples_taxonomy_closed_reference.tsv"
        File taxonomy_open_reference_tsv = "output_data/all_samples_taxonomy_open_reference.tsv"
        File vsearch_otus_tsv = "output_data/all_samples_vsearch_otus.txt"
        File anadama_log = "output_data/anadama.log"
        File closed_reference_tre = "output_data/closed_reference.tre"
    }
    meta {
        maintainer: "Jason L Weirather"
        citation: "McIver LJ, Abu-Ali G, Franzosa EA, Schwager R, Morgan XC, Waldron L, Segata N, Huttenhower C. bioBakery: a meta'omic analysis environment. Bioinformatics. 2018 Apr 1;34(7):1235-1237. PMID: 29194469."
    }
}
workflow run_biobakery {
    call vsearch
}

