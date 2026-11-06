#!/usr/bin/env bash

eval "$(mamba shell hook --shell bash)"
mamba activate ee282

# download file of all chromosomes
chrom="https://s3ftp.flybase.org/genomes/dmel/dmel_r6.69_FB2026_03/fasta/dmel-all-chromosome-r6.69.fasta.gz"
check="https://s3ftp.flybase.org/genomes/dmel/dmel_r6.69_FB2026_03/fasta/md5sum.txt"

cd data/raw/
wget $chrom

# check file integrity
wget -O /dev/stdout $check | md5sum -c --ignore-missing

# run faSize
faSize dmel-all-chromosome-r6.69.fasta.gz
