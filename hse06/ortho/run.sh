#!/bin/bash
#PBS -N hse06-ortho
#PBS -e job.err
#PBS -o job.o
#PBS -q serial
#PBS -l nodes=1:ppn=1
#PBS -l mem=10G


#module load vasp-6.4.3
#module load wannier90
module load intel

export OMP_NUM_THREADS=1
export I_MPI_FABRICS=shm
#export I_MPI_HYDRA_TOPOLIB=ipl

ulimit -s unlimited

cd $PBS_O_WORKDIR

vasp=/home/lovelace/proj/proj897/adias/programs/vasp.6.4.2/bin/vasp_std
wannier=/home/lovelace/proj/proj897/adias/programs/wannier90-3.1.0/bin/wannier90.x

#mpirun -hostfile $PBS_NODEFILE -np $NCPUS $vasp > log_hse06.out

$wannier wannier90



