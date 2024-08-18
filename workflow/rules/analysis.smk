#Genome Structure Level
rule build_database_repeatmodeler:
    input:
         genome="results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta",
    output:
          multiext("results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db",
                   ".nhr",
                   ".nnd",
                   ".nin",
                   ".nni",
                   ".nog",
                   ".nsq",
                   ".translation")
    params:
          db_name="results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db",
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/builddatabase.py"

rule repeatmodeler:
    input:
         db="results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db.nhr"
    output:
          "results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db-families.fa"
    params:
          db_name="results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db",
          threads = 32,
          engine="ncbi",
          out_dir= "results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/"
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/repeatmodeler.py"

rule repeatmasker:
    input:
         genome="results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta",
         lib="results/ComparativeGenomics/1_GenomeStructureLevel/RModeler/{assembler}/genome_db-families.fa"
    output:
          directory("results/ComparativeGenomics/1_GenomeStructureLevel/RMasker/{assembler}")
    conda:
         "envs/genomics.yaml"
    threads: 32
    script:
          "workflow/scripts/genomics/analysis/repeatmasker.py"

rule tRNAscan:
    input:
         genome="results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta"
    params: threads=32
    output:
          tRNA="results/ComparativeGenomics/1_GenomeStructureLevel/tRNAscan/{assembler}/genome.tRNAscan",
          stats="results/ComparativeGenomics/1_GenomeStructureLevel/tRNAscan/{assembler}/genome.stats",
          gff="results/ComparativeGenomics/1_GenomeStructureLevel/tRNAscan/{assembler}/genome.gff"
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/tRNAscan.py"

rule tRNAscan_cov:
    input:
         genome="results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta"
    params: threads=32
    output:
          tRNA="results/ComparativeGenomics/1_GenomeStructureLevel/tRNAscan/sensitive_search/{assembler}/genome.tRNAscan_cov",
          stats="results/ComparativeGenomics/1_GenomeStructureLevel/tRNAscan/sensitive_search/{assembler}/genome.stats_cov"
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/tRNAscan_cov.py"

rule barrnap:
    input:
         genome="results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta"
    output:
          gff="results/ComparativeGenomics/1_GenomeStructureLevel/barrnap/{assembler}/genome.rrna.gff",
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/barrnap.py"

rule cdhit:
    input:
        genome = "results/Genomics/1_Assembly/2_Assemblers/{assembler}/assembly.fasta"
    params:
        threads=32
    output: "results/ComparativeGenomics/1_GenomeStructureLevel/cdhit/{assembler}/genome_{n}.cdhit"
    conda:
         "envs/genomics.yaml"
    script:
          "workflow/scripts/genomics/analysis/cdhit.py"
