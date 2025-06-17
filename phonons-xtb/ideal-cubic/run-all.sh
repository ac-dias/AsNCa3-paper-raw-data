#!/bin/bash
#PBS -N  ideal-cubic
#PBS -e  job.err
#PBS -o  job.o
#PBS -q  workq 
#PBS -l nodes=1:ppn=16

module load dftb-plus-pre_compiled

ulimit -s unlimited

export OMP_NUM_THREADS=$NCPUS

export I_MPI_FABRICS=shm

cd $PBS_O_WORKDIR


factor="001 002 003"
factor=($factor)

for (( i = 0; i<${#factor[@]}; i++ )); do

	dir=disp-"${factor[$i]}"
	
	cd $dir
	
	dftb+ > output.dat
	
	cd ..
	
	echo "${factor[$i]}"/3 >> log.out

done	
