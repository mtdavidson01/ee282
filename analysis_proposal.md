# EE282 Analysis Proposal

## Introduction

Bacterial population sizes and spontaneous mutations mean even individual colonies and cultures commonly thought of as "clonal" actually represent mixed populations of closely related genotypes. As a result, mutant phenotypes can readily be isolated, especially in the case of a phenotype conferring a large fitness advantage in the face of a strong selective pressure. Lytic bacteriophages (phages) are one such pressure, lethal to susceptible bacteria they encounter. By isolating and sequencing phage resistant mutants, candidate genomic factors required for phage susceptibility can be identified to gain insight into phage-bacteria interactions and potential pleiotropic effects of phage selection.

## Dataset(s)

The Whiteson Lab has a collection of _Stenotrophomonas maltophilia_ clinical isolates, which they have used to isolate a variety of phages over the last several years. Three phages - ESCSMPI, PLC, and SBP2phi2 - were identified to fit therapeutic criteria, and selected for further characterization and use in further assays. Each phage infects a different _S. maltophilia_ isolate: SM71, SM22, and SM50 respectively. To investigate host genetic or genomic factors required for phage susceptibility, 5-6 phage resistant mutants were isolated from independent cultures of each host. The total of 3 wildtype and 17 mutant isolates were sent for Illumina sequencing, and fastq files 2x150bp paired-end short read data has been received and is awaiting analysis.

## Analysis

To identify candidate phage resistance mutations, variants must be called against the genomes of the wildtype ancestors. When working with common laboratory strains high quality annotated assemblies can usually be obtained from RefSeq. In this investigation, the ancestral strains are clinical isolates that have not previously been sequenced, necessitating assembly before variant calling can be performed. Ancestral reference assemblies will also be annotated prior to use in variant calling to allow for streamlined analysis of any mutations found in phage resistant isolates. Before working with data from any sample, read quality will be evaluated and adjusted. The remainder of the analysis portion of this proposal will focus on the specific tools to be used to complete these necessary steps.

### Quality Control and Preprocessing

Quality of sequencing data is of obvious importance for any downstream analysis. For _de novo_ assembly, removing sequencing artifacts, such as adapters, that may result in high quality bases that are not biologically meaningful is very important (Prjibelski et al. 2020). Additionally, certain illumina machines interpret absence of a signal as the presence of a G, resulting in a long string of high confidence G bases at the end of a read if library preparation resulted in short fragments or if a read had poor signal (Stoler and Nekrutenko 2021). In a brief exploration of one fastq file in the dataset using `less`, reads containing long poly-G tails were found to be present. To ensure this sort of artifact does not interfere with assembly and variant calling, all data will be cleaned using fastp. Fastp is available on HPC3 as a module, and will be used to filter poly-G tails and adapters, as well as any quality trimming determined to be needed (Chen 2025). Additionally, html reports produced by fastp will allow for assessment of fastq file quality before and after processing.

### Assembly

To assemble the three ancestral _S. maltophilia_ genomes, I will use Shovill and SPAdes. SPAdes is a very commonly used assembler for microbial genomic, metagenomic, and transcriptomic data (Prjibelski et al. 2020). Shovill is a wrapper for SPAdes that performs limited preprocessing to increase assembly speed, as well as perform error correction and filtering after assembly (Seemann 2026). In addition to efficient resource use, using Shovill will allow for convenient sub-sampling of reads through the `--gsize` and `--depth` to avoid assembly issues resulting from too much coverage. Shovill's main output will be fasta files containing contigs of the ancestral genomes, which will be annotated before their use as reference genomes in variant calling. SPAdes as a standalone program is included as a module on HPC3, and Shovill is available via bioconda.

### Annotation

Variant calling will allow for the identification of differences between ancestral strains and mutant isolates, but identifying differences in sequence alone does not provide enough information for meaningful insight into why these mutations may correspond to a given phenotype. By annotating the ancestral genomes, genomic features affected by mutations can be determined or inferred, allowing for potential links between genotype and phenotype. The most straightforward version of this in the context of this project would be identifying a single mutation introducing a premature stop codon in an outer membrane protein, indicating that gene is required for phage susceptibility and encodes a candidate phage receptor. Annotating ancestral genomes before variant calling will allow for the human-readable output files from variant calling to be more immediately meaningful to knowledgable users.

To annotate the ancestral _S. maltophilia_ assemblies, Bakta will be used. Bakta is an accurate and efficient annotation program tailored to bacteria, providing improved identification of CDSs with relatively small increases in runtime or resource usage compared to similar annotation tools (Schwengers et al. 2021). Bakta is available from bioconda, and has the singular drawback of requiring a large (53 GB) database to run.

### Variant Calling

Once assemblies of ancestral _S. maltophilia_ genomes have been annotated, variants will be called for each of the phage resistant mutant isolates using breseq. Initially developed for analyzing data from the long-term evolution experiment in _E. coli_, breseq can be used to call variants in isolates or populations of haploid organisms with small genomes against a reference (Deatherage and Barrick 2014). Important outputs from breseq will include an html file with information about mutations identified in an easy to parse format, as well as a VCF file which will be used for visualization of sequence variation between mutants and wildtype strains.

## Data Visualization

Output from breseq may contain enough information for a researcher working on a project to gain meaningful insights, but it is insufficient for effective and clear communication of those insights to an audience less well versed in the details of a given project. To address this, VCF files generated by breseq will be used in R to create plots conveying this information more effectively. The R package gggenomes allows for VCF and GFF files to be read into R and used to generate gene arrow maps, representing differences between similar genomes exactly as needed to communicate sequence variation phage resistant isolates (Hackl et al. 2024). Gene arrow maps showing differences between wildtype and phage resistant mutant isolates will be generated for each ancestral _S. maltophilia_ strain.

## Conclusion

The Whiteson Lab's _S. maltophilia_ dataset will allow for analysis of genomic factors required for phage infection. Standard tools in the field for the necessary preprocessing, assembly, annotation, and variant calling are readily available for use on HPC3 as modules or through bioconda, and are straightforward and fast. Script testing and troubleshooting can be done quickly as a result, and once a script is established the structure of the dataset means that analysis for each ancestor can be performed in parallel. Additionally, the dataset's structure provides redundancy, where an issue discovered in sequence data of one isolate is self-limited, or at most affects one genotype in the case of an ancestor. Together, this allows for a project using a robust dataset that allows for fast analysis and troubleshooting.

## References

Chen S. 2025. fastp 1.0: An ultra-fast all-round tool for FASTQ data quality control and preprocessing. *iMeta* **4**: e70078.

Deatherage DE, Barrick JE. 2014. Identification of Mutations in Laboratory-Evolved Microbes from Next-Generation Sequencing Data Using breseq. In *Engineering and Analyzing Multicellular Systems: Methods and Protocols* (eds. L. Sun and W. Shou), pp. 165–188, Springer, New York, NY.

Hackl T, Ankenbrand M, van Adrichem B, Wilkins D, Haslinger K. 2024. gggenomes: effective and versatile visualizations for comparative genomics. arXiv doi: 2411.13556.

Prjibelski A, Antipov D, Meleshko D, Lapidus A, Korobeynikov A. 2020. Using SPAdes De Novo Assembler. *Current Protocols in Bioinformatics* **70**: e102.

Schwengers O, Jelonek L, Dieckmann MA, Beyvers S, Blom J, Goesmann A. 2021. Bakta: rapid and standardized annotation of bacterial genomes via alignment-free sequence identification. *Microbial Genomics* **7**: 000685.

Seemann T. 2026. Shovill: Robust Microbial Short-Read Genome Assembly. Preprints.org doi: 10.20944/preprints202607.1422.v1

Stoler N, Nekrutenko A. 2021. Sequencing error profiles of Illumina sequencing instruments. *NAR Genom Bioinform* **3**: lqab019.
