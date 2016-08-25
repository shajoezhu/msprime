#!/bin/bash

dir=test-demo
mkdir ${dir}
cd ${dir}
rm *


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
program1="hybridLambda"
program2="msprime"

# Note that hybrid-Lambda scale branch length by 2Ne rather than 4Ne.
hybrid-Lambda -spcu "(A:0,B:0);" -S 5 5 -num ${nRepeat} -o ${program1} -tmrca -bl -mu 0.001 -seg -sim_Si_num

rearrange_hybridLambdaout ${nLoci}

../main tmp.cfg > ${program2}Out
cat ${program2}Out | sample_stats > ${program2}_stats
grep ";" ${program2}Out > ${program2}Gt
hybrid-Lambda -gt ${program2}Gt -o ${program2} -tmrca -bl


foo
