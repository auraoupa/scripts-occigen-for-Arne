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


tfile=$dir/${CONFIG}-${CASE}_${TAG}_gridT-2D.nc
t2file=$dir/${CONFIG}-${CASE}_${TAG}_gridT-2D2.nc

filerms=${CONFIG}-${CASE}_${TAG}_RMSSSH.nc

if [ ! -f  ${filerms} ]; then 
	ulimit -s unlimited
	echo ${filerms}
	/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfrmsssh -t $tfile -t2 $t2file -o $filerms -nc4 -var zos zos_sqd 
fi

