#!/usr/bin/env bash

eval "$(mamba shell hook --shell bash)"
mamba activate ee282

# download annotation file
gtf="https://s3ftp.flybase.org/genomes/Drosophila_melanogaster/dmel_r6.69_FB2026_03/gtf/dmel-all-r6.69.gtf.gz"
check="https://s3ftp.flybase.org/genomes/Drosophila_melanogaster/dmel_r6.69_FB2026_03/gtf/md5sum.txt"

cd data/raw/
wget $gtf

# check file integrity
wget -O /dev/stdout $check | md5sum -c --ignore-missing
cd ../..

# count number of each feature, order from most to least common
bioawk -c gff '{ print $feature }' data/raw/dmel-all-r6.69.gtf.gz \
| sort \
| uniq -c \
| sort -k1,1rn \
| column -t

# find total number of genes per chromosome arm
bioawk -c gff '$feature ~ /^gene$/ && $1 ~ /^(X|Y|2L|2R|3L|3R|4)$/ { print $1,$feature }'\
 data/raw/dmel-all-r6.69.gtf.gz \
| sort -k1,1 \
| uniq -c \
| sort -k2,2 \
| column -t
