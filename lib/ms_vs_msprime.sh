#!/bin/bash

dir=test-demo
mkdir ${dir}
cd ${dir}
rm *pdf


## compare population sturture for a single population data
COMPAREFILE=compareDemo
rm ${COMPAREFILE}

nLoci=10
nRepeat=10000

msMutationRate=20 # Since the mutation rate for msprime is 2.0 per segment per 4Ne, nLoci = 10, this is scaled up by the sequence length

source ../process_sample_stats.src

cat ../devSimple.cfg.core > tmp.cfg
echo "num_loci = ${nLoci};" >> tmp.cfg
echo "num_repeat = ${nRepeat};" >> tmp.cfg
echo "recombination_map = ([0.0, 0.0], [${nLoci}.0, 0.0]);"  >> tmp.cfg

case="simple"

ms $( grep "{ population = 0; time = 0.0; }" tmp.cfg | wc -l | cut -f1 -d' ') ${nRepeat} -T -t ${msMutationRate} -r 0 ${nLoci} -seed 1 1 1 > msOut
cat msOut | sample_stats > ms_stats
grep ";" msOut > msGt
hybrid-Lambda -gt msGt -o ms -tmrca -bl

../main tmp.cfg > msprimeOut
cat msprimeOut | sample_stats > msprime_stats
grep ";" msprimeOut > msprimeGt
hybrid-Lambda -gt msprimeGt -o msprime -tmrca -bl


foo
