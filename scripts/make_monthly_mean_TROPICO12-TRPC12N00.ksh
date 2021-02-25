#!/bin/bash

#SBATCH --nodes=5
#SBATCH --ntasks=108
#SBATCH -J mean-trop
#SBATCH -e mean-trop.e%j
#SBATCH -o mean-trop.o%j
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=108 #(= 9 files * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do

	case $filetyp in
		gridT-2D|gridU-2D|gridV-2D|flxT) FREQ=6h;;
		gridT|gridS|gridU|gridV|gridW) FREQ=1d;;
	esac

	for month in $(seq 1 12); do
		echo './script_monthly_mean_TROPICO12.ksh TRPC12N00 '$filetyp' '$FREQ' 2012 '$month >> tmp_monthly_mean_TROPICO12-TRPC12N00_${filetyp}_m${month}.ksh
		chmod +x tmp_monthly_mean_TROPICO12-TRPC12N00_${filetyp}_m${month}.ksh
		liste="$liste ./tmp_monthly_mean_TROPICO12-TRPC12N00_${filetyp}_m${month}.ksh"
	done

done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste
	
