#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH -J mean1y-cal
#SBATCH -e mean1y-trop.e%j
#SBATCH -o mean1y-trop.o%j
#SBATCH --time=01:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=9 #(= 9 files * 1 year)

CASE=TRPC12N00
YEAR=2012
runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do

	echo './script_yearly_mean_TROPICO12_sq.ksh TROPICO12 '$CASE' '$filetyp' '$YEAR >> tmp_yearly_mean_TROPICO12-${CASE}_${filetyp}_y${YEAR}.ksh
	chmod +x tmp_yearly_mean_TROPICO12-${CASE}_${filetyp}_y${YEAR}.ksh
	liste="$liste ./tmp_yearly_mean_TROPICO12-${CASE}_${filetyp}_y${YEAR}.ksh"

done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste
	
