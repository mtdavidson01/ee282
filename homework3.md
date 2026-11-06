# EE282 Homework 3

## Genome Assembly

### Process

The current release of the _Drosophila melanogaster_ genome containing all chromosomes was downloaded in `fasta` format from Flybase using `wget`.  `md5sum` was used to confirm the file's integrity against Flybase's provided checksums before `faSize` was used to obtain summary information about the genome assembly. This was performed using the script `hw3_genome_summary.sh` in the `code/scripts` directory.

### Summary

Output from `faSize` tells us the current `D. melanogaster` genome consists of:

* 143,726,002 nucleotides

* 1,152,978 Ns

* 1,870 sequences

## Annotation Summary

### Process

The current annotation of the _D. melanogaster_ genome was downloaded in `gtf` format from Flybase and its integrity was verified using the same steps outlined [above](#process).  The number of each feature type was determined by `sort`ing by feature type, generating counts for each type using `uniq -c`, then and `sort`ing again to display features and counts from most to least common. Then, `bioawk` was used to filter for only genes on chromosomes, which were then `sort`ed by chromosome arm and counts generated for each chromosome arm using `uniq -c`. This was performed using `hw3_annotation_summary.sh` in the `code/scripts` directory.

### Summary

Number of each feature type, most to least common:

```
190183  exon
163381  CDS
46858   5UTR
33779   3UTR
30923   start_codon
30863   stop_codon
30838   mRNA
17872   gene
3059    ncRNA
485     miRNA
365     pseudogene
312     tRNA
270     snoRNA
262     pre_miRNA
115     rRNA
32      snRNA
```

Total number of genes per chromosome arm:

```
3508  2L  gene
3649  2R  gene
3481  3L  gene
4226  3R  gene
114   4   gene
2704  X   gene
113   Y   gene
```
