#!/bin/bash
#PBS -N scubic
#PBS -e job.err
#PBS -o job.o
#PBS -q workq
#PBS -l nodes=salpeter-02:ppn=56



module load vasp-6.4.3

export OMP_NUM_THREADS=1
export I_MPI_FABRICS=shm
#export I_MPI_HYDRA_TOPOLIB=ipl

cd $PBS_O_WORKDIR

i=50
icount=0
maxstep=10

while [ $i -ne 1 ]
do

mpirun -machinefile $PBS_NODEFILE -np $NCPUS vasp_std

icount=$((icount+1))

echo $icount >> log.dat

if [ $icount -ge $maxstep ]; then

        exit 1

fi


cp CONTCAR POSCAR

i=`grep F OSZICAR | tail -n1 | awk '{print $1;}'`


done



