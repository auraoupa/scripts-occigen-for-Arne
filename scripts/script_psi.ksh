#!/bin/bash

CONFIG=$1
CASE=$2
YEAR=$3
MONTH=$4

case $MONTH in
  13) dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1y/$YEAR; TAG=1y_$YEAR;;
  *) dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m/$YEAR; mm=$(printf "%02d" $MONTH); TAG=1m_$YEAR$mm;;
esac

mkdir -p $dir
cd $dir

rm mask.nc mesh_hgr.nc mesh_zgr.nc
case $CONFIG in
	TROPICO12) mesh=/store/brodeau/TROPICO12/TROPICO12.L125-I/mesh_mask_TROPICO12_L125_tr21_UPDATED.nc;;
	CALEDO60) mesh=/store/brodeau/TROPICO12/TROPICO12.L125-I/NST/1_mesh_mask_TROPICO12_L125_tr21.nc;;
esac

ln -sf $mesh mask.nc
ln -sf $mesh mesh_hgr.nc
ln -sf $mesh mesh_zgr.nc

ufile=$dir/${CONFIG}-${CASE}_${TAG}_gridU.nc
vfile=$dir/${CONFIG}-${CASE}_${TAG}_gridV.nc

filepsi=${CONFIG}-${CASE}_${TAG}_PSI.nc

if [ ! -f  ${filepsi} ]; then 
	ulimit -s unlimited
	echo ${filepsi}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfpsi -u $ufile -v $vfile -o $filepsi
fi

