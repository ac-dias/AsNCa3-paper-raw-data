#!/bin/bash
#PBS -N  ortho
#PBS -e  job.err
#PBS -o  job.o
#PBS -q  workq 
#PBS -l nodes=salpeter-06:ppn=16

source /etc/programs/anaconda3/etc/profile.d/conda.sh

conda activate dftb

ulimit -s unlimited

export OMP_NUM_THREADS=$NCPUS

export I_MPI_FABRICS=shm

cd $PBS_O_WORKDIR


factor="001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063 064 065 066 067 068 069 070 071 072 073 074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120"
factor=($factor)

for (( i = 0; i<${#factor[@]}; i++ )); do

	dir=disp-"${factor[$i]}"
	
	cd $dir
	
	dftb+ > output.dat
	
	cd ..
	
	echo "${factor[$i]}"/3 >> log.out

done	
