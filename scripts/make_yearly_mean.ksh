#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=13
#SBATCH -J mean1y
#SBATCH -e mean1y.e%j
#SBATCH -o mean1y.o%j
#SBATCH --time=01:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24
#SBATCH --dependency=afterok:JOBIDMOY

NB_NPROC=13 #(= 13 files * 1 year)

CASE=CASEM
YEAR=YEARM
CONFIG=CONFIGM

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT gridU2 gridV2 gridT2 gridT-2D2; do

	echo './script_yearly_mean_from_monthly_mean.ksh '${CONFIG}' '$CASE' '$filetyp' '$YEAR >> tmp_yearly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}.ksh
	chmod +x tmp_yearly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}.ksh
	liste="$liste ./tmp_yearly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}.ksh"

done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste
	
