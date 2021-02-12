#!/bin/ksh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --constraint=VISU
#SBATCH -J make_tide
#SBATCH -e make_tide.e%j
#SBATCH -o make_tide.o%j
#SBATCH --time=5:59:00
#SBATCH --exclusive

CONFIG=TROPICO05
CASE=TRPC5T0
seg=00008785-00017544
freq=M2

sdir=/scratch/cnt0024/ige2071/aalbert/$CONFIG/$CONFIG-$CASE/1h/tide
mkdir -p $sdir
cd $sdir

ln -sf /scratch/cnt0024/ige2071/brodeau/NEMO/$CONFIG/$CONFIG-$CASE-S/$seg/*1h*gridT-2D.nc

ln -sf /scratch/cnt0024/ige2071/aalbert/git/scripts-occigen-for-Arne/plot-amplitude-phase-tide/namelist_${freq} namelist

/scratch/cnt0024/ige2071/aalbert/git/TIDAL_TOOLS/bin/tid_harm_ana -l *gridT-2D.nc

