#!/bin/bash
#PBS -N hse06-ideal-cubic
#PBS -e job.err
#PBS -o job.o
#PBS -q workq
#PBS -l nodes=1:ppn=1



module load vasp-6.4.3
module load wannier90
#module load intel

export OMP_NUM_THREADS=1
export I_MPI_FABRICS=shm
#export I_MPI_HYDRA_TOPOLIB=ipl

cd $PBS_O_WORKDIR

#vasp=/home/lovelace/proj/proj897/adias/programs/vasp.6.4.2/bin/vasp_std
#wannier=/home/lovelace/proj/proj897/adias/programs/wannier90-3.1.0/bin/wannier90.x

#mpirun -hostfile $PBS_NODEFILE -np $NCPUS vasp_std > log_hse06.out

wannier90.x wannier90



