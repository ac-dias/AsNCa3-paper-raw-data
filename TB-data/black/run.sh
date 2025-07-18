#!/bin/bash
#PBS -N black-TB
#PBS -e job.err
#PBS -o job.o
#PBS -q workq
#PBS -l nodes=1:ppn=16



module load wtb

export OMP_NUM_THREADS=$NCPUS
export I_MPI_FABRICS=shm
#export I_MPI_HYDRA_TOPOLIB=ipl
export KMP_STACKSIZE=500mb
cd $PBS_O_WORKDIR


wtb.x < input.dat




