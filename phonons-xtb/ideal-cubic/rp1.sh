#!/usr/bin/env bash

#phonopy -d input.conf

#factor="001 002 003"
factor="004 005 006 007 008"
factor=($factor)



for (( i = 0; i<${#factor[@]}; i++ )); do

	dir=disp-"${factor[$i]}"
mkdir $dir


cp geo.genS-"${factor[$i]}" ./$dir/geo.gen

cat >> ./$dir/dftb_in.hsd << EOF
Geometry = GenFormat {
    # geometry input file
    <<< geo.gen
}

Hamiltonian = xTB {

    Method = "GFN1-xTB"
    
    }



    # Example uses a fairly large supercell, so not many k-points are included
    KPointsAndWeights = SupercellFolding {
        3 0 0
        0 3 0
        0 0 3
        0.0 0.0 0.0
    }

}

Options = {
    # Required options for storing data needed by phonopy
    WriteResultsTag = Yes
}

ParserOptions = {
    # input parser version for DFTB+ 18.2, but this is backward
    # compatible
    ParserVersion = 6
}

Analysis = {
    # required option for phonopy
    Printforces = Yes
}

EOF


cat >> ./$dir/run.sh << EOF
#!/bin/bash
#PBS -N  ${factor[$i]}
#PBS -e  job.err
#PBS -o  job.o
#PBS -q  workq 
#PBS -l nodes=1:ppn=16

module load dftb-plus-pre_compiled

ulimit -s unlimited

EOF

cat "run-dftb.txt" >> ./$dir/run.sh



done



