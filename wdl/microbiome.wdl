# Input: Take an array of bams and merge them
#           optionally can take another array of bams that also get merged
# Output: A sorted merged bam

task biobakery {
    Array[Object] samples

    Int? memory = 16
    Int? disk_space = 200
    Int? num_cpu = 8
    Int? num_preempt = 0
    Int? boot_disk_gb = 10

    String? docker = "vacation/cio-wdl-16s-microbiome:1.0"
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
        mkdir mytempdir
        echo "samples is:"
        echo "${samples}"
        echo "Hello World"
        touch sorted.bam
    >>>
    output {
        File output_bam = "sorted.bam"
    }
    meta {
        maintainer: "Jason L Weirather"
        citation: "McIver LJ, Abu-Ali G, Franzosa EA, Schwager R, Morgan XC, Waldron L, Segata N, Huttenhower C. bioBakery: a meta'omic analysis environment. Bioinformatics. 2018 Apr 1;34(7):1235-1237. PMID: 29194469."
    }
}
workflow run_biobakery {
    call biobakery
}

