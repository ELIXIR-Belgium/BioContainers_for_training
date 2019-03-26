#!/bin/bash -ue
cufflinks --no-update-check -q -p 1 -G ggal_1_48850000_49020000.bed.gff accepted_hits.bam
mv transcripts.gtf transcript_ggal_gut.gtf
