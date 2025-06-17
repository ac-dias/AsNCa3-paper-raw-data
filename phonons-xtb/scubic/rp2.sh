#!/usr/bin/env bash


phonopy -f disp-{001..003}/results.tag --dftb+

phonopy -p bandas.conf -s 

phonopy-bandplot band.yaml --gnuplot >> disp.dat

phonopy -p thermal.conf -s

phonopy-propplot thermal_properties.yaml --gnuplot >> thermal.dat

phonopy  anime.conf
