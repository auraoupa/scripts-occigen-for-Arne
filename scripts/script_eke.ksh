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


ufile=$dir/${CONFIG}-${CASE}_${TAG}_gridU.nc
u2file=$dir/${CONFIG}-${CASE}_${TAG}_gridU2.nc
vfile=$dir/${CONFIG}-${CASE}_${TAG}_gridV.nc
v2file=$dir/${CONFIG}-${CASE}_${TAG}_gridV2.nc
tfile=$dir/${CONFIG}-${CASE}_${TAG}_gridT.nc

fileeke=${CONFIG}-${CASE}_${TAG}_EKE.nc
filemke=${CONFIG}-${CASE}_${TAG}_MKE.nc
filetke=${CONFIG}-${CASE}_${TAG}_TKE.nc

if [ ! -f  ${fileeke} ]; then 
	ulimit -s unlimited
	echo ${fileeke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -u2 $u2file -v $vfile -v2 $v2file -t $tfile  -o $fileeke -nc4 -var uo vo uo_sqd vo_sqd
fi

if [ ! -f  ${filemke}.nc ]; then 
	ulimit -s unlimited
	echo ${filemke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -v $vfile -t $tfile  -o $filemke -nc4 -mke -var uo vo uo_sqd vo_sqd
fi
 
if [ ! -f  ${filetke}.nc ]; then 
	ulimit -s unlimited
	echo ${filetke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -v $vfile -t $tfile  -o $filetke -nc4 -tke -var uo vo uo_sqd vo_sqd
fi
