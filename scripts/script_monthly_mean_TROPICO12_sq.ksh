#!/bin/bash

CONFIG=TROPICO12
CASE=$1
TYP=$2
FREQ=$3
YEAR=$4
MONTH=$5

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m

mkdir -p $dir
cd $dir

stdir=/store/brodeau/$CONFIG/${CONFIG}_NST-$CASE-S

mm=$(printf "%02d" $MONTH)

file_list=$(ls $stdir/*/${CONFIG}_NST-${CASE}_${FREQ}_${YEAR}${mm}??_${YEAR}${mm}??_${TYP}.nc4)

fileo=${CONFIG}-${CASE}_1m_${YEAR}${mm}_${TYP}

if [ ! -f  ${fileo}2.nc ]; then 
	ulimit -s unlimited
	echo ${fileo}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfmoy -l $file_list -o $fileo -nc4
fi


