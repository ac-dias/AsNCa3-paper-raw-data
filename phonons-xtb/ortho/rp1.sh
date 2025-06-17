#!/usr/bin/env bash

phonopy -d input.conf

factor="001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063 064 065 066 067 068 069 070 071 072 073 074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120"
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
    
    



    # Example uses a fairly large supercell, so not many k-points are included
    KPointsAndWeights = SupercellFolding {
        2 0 0
        0 2 0
        0 0 2
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

source /etc/programs/anaconda3/etc/profile.d/conda.sh

conda activate dftb

ulimit -s unlimited

EOF

cat "run-dftb.txt" >> ./$dir/run.sh



done



