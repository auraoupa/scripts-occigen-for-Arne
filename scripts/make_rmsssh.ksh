#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=13
#SBATCH -J rmsssh
#SBATCH -e rmsssh.e%j
#SBATCH -o rmsssh.o%j
#SBATCH --time=01:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24
#SBATCH --dependency=afterok:JOBIDMOY

NB_NPROC=13 #(= rmsssh for 12 months and 1 year)

CASE=CASEM
YEAR=YEARM
CONFIG=CONFIGM

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for month in $(seq 1 12); do
	echo './script_rmsssh.ksh '${CONFIG}' '$CASE' '$YEAR' '$month >> tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}m${month}.ksh
	chmod +x tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}m${month}.ksh
	liste="$liste ./tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}m${month}.ksh"

done
echo './script_rmsssh.ksh '${CONFIG}' '$CASE' '$YEAR' 13' >> tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}.ksh
chmod +x tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}.ksh
liste="$liste ./tmp_rmsssh_${CONFIG}-${CASE}_y${YEAR}.ksh"
runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste
	
