#!/bin/bash

CONFIG=$1
CASE=$2
TYP=$3
YEAR=$4

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1y/$YEAR

mkdir -p $dir
cd $dir

stdir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m/$YEAR

file_list=$(ls $stdir/${CONFIG}-${CASE}_1m_${YEAR}??_${TYP}.nc)

fileo=${CONFIG}-${CASE}_1y_${YEAR}_${TYP}.nc

if [ ! -f  ${fileo} ]; then 
	ulimit -s unlimited
	echo ${fileo}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfmoy_weighted -l $file_list -o $fileo -nc4
fi


