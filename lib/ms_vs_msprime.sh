#!/bin/bash

dir=test-demo
mkdir ${dir}
cd ${dir}
#rm *


## compare population sturture for a single population data
COMPAREFILE=compareDemo
rm ${COMPAREFILE}

nLoci=1
nRepeat=10000

msMutationRate=20 # Since the mutation rate for msprime is 2.0 per segment per 4Ne, nLoci = 10, this is scaled up by the sequence length

source ../process_sample_stats.src

cat ../devSimple.cfg.core > tmp.cfg
echo "num_loci = ${nLoci};" >> tmp.cfg
echo "num_repeat = ${nRepeat};" >> tmp.cfg
echo "recombination_map = ([0.0, 0.0], [${nLoci}.0, 0.0]);"  >> tmp.cfg

program1="ms"
program2="msprime"
case=${program1}vs${program2}_kingman


ms $( grep "{ population = 0; time = 0.0; }" tmp.cfg | wc -l | cut -f1 -d' ') ${nRepeat} -T -t ${msMutationRate} -seed 1 1 1 > msOut
cat ${program1}Out | sample_stats > ${program1}_stats
#grep ";" ${program1}Out > ${program1}Gt
#hybrid-Lambda -gt ${program1}Gt -o ${program1} -tmrca -bl

../main tmp.cfg > ${program2}Out
cat ${program2}Out | sample_stats > ${program2}_stats
#grep ";" ${program2}Out > ${program2}Gt
#hybrid-Lambda -gt ${program2}Gt -o ${program2} -tmrca -bl


foo
