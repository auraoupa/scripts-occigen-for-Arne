#!/bin/bash

#SBATCH --nodes=5
#SBATCH --ntasks=108
#SBATCH -J mean1m
#SBATCH -e mean1m.e%j
#SBATCH -o mean1m.o%j
#SBATCH --time=01:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=108 #(= 9 files * 12 month)

CASE=CASEM
YEAR=YEARM
CONFIG=CONFIGM



runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do

	case $filetyp in
		gridT-2D|gridU-2D|gridV-2D|flxT) case $CONFIG in
							TROPICO12)  FREQ=6h;;
							CALEDO60) FREQ=1h;;
						 esac;;

		gridT|gridS|gridU|gridV|gridW) FREQ=1d;;
	esac

	for month in $(seq 1 12); do
		echo './script_monthly_mean_'$CONFIG'.ksh '$CASE' '$filetyp' '$FREQ' '$YEAR' '$month >> tmp_monthly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}_m${month}.ksh
		chmod +x tmp_monthly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}_m${month}.ksh
		liste="$liste ./tmp_monthly_mean_${CONFIG}-${CASE}_${filetyp}_y${YEAR}_m${month}.ksh"
	done

done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste
	
