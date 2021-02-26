#!/bin/bash

CONFIG=$1
CASE=$2
TYP=$3
YEAR=$4
MONTH=$5

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m

mkdir -p $dir
cd $dir

stdir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m

ufile=$stdir/${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_gridU.nc
u2file=$stdir/${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_gridU2.nc
vfile=$stdir/${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_gridV.nc
v2file=$stdir/${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_gridV2.nc
tfile=$stdir/${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_gridT.nc

fileeke=${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_EKE.nc
filemke=${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_MKE.nc
filetke=${CONFIG}-${CASE}_1m_${YEAR}${MONTH}_TKE.nc

if [ ! -f  ${fileeke}.nc ]; then 
	ulimit -s unlimited
	echo ${fileeke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -u2 $u2file -v $vfile -v2 $v2file -t $tfile  -o $fileeke -nc4 -var uo vo uo_cub vo_cub
fi

if [ ! -f  ${filemke}.nc ]; then 
	ulimit -s unlimited
	echo ${filemke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -v $vfile -t $tfile  -o $filemke -nc4 -mke -var uo vo uo_cub vo_cub
fi
 
if [ ! -f  ${filetke}.nc ]; then 
	ulimit -s unlimited
	echo ${filetke}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfeke -u $ufile -v $vfile -t $tfile  -o $filetke -nc4 -tke -var uo vo uo_cub vo_cub
fi
