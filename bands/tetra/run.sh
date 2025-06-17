#!/bin/bash
#PBS -N tetra
#PBS -e job.err
#PBS -o job.o
#PBS -q workq
#PBS -l nodes=salpeter-10:ppn=16



module load vasp-6.4.3

export OMP_NUM_THREADS=1
export I_MPI_FABRICS=shm
#export I_MPI_HYDRA_TOPOLIB=ipl

cd $PBS_O_WORKDIR


cp INCAR-scf INCAR
cp KPOINTS-scf KPOINTS

mpirun -hostfile $PBS_NODEFILE -np $NCPUS vasp_std > log-scf.out

cp INCAR-bnd INCAR
cp KPOINTS-bnd KPOINTS

mpirun -hostfile $PBS_NODEFILE -np $NCPUS vasp_std > log-bnd.out






