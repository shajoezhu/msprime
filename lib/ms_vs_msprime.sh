#!/bin/bash

dir=test-demo
mkdir ${dir}
cd ${dir}
rm *pdf

rep=100000

## compare population sturture for a single population data
COMPAREFILE=compareDemo
rm ${COMPAREFILE}


source ../process_sample_stats.src

rep=10000

case="simple"
ms 100 ${rep} -T -t 10 | sample_stats > ms_stats
../main ../devSimple.cfg | sample_stats > msprime_stats

foo
