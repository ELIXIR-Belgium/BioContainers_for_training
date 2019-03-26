#!/bin/bash -ue
tophat2 -p 1 --GTF ggal_1_48850000_49020000.bed.gff genome.index ggal_liver_1.fq ggal_liver_2.fq
mv tophat_out/accepted_hits.bam .
