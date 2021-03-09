#!/bin/bash

CONFIG=CALEDO60
CASE=$1
VAR=$2
FREQ=$3
YEAR=$4
MONTH=$5

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1d

mkdir -p $dir
cd $dir

stdir=/store/CT1/hmg2840/lbrodeau/TROPICO12/TROPICO12_NST-$CASE-S

case $VAR in
	mldr10_1|rho_air|sos|tos|windsp|zos) filetyp=gridT-2D;;
	tauuo|uos) filetyp=gridU-2D;;
	tauvo|vos) filetyp=gridV-2D;;
	so) filetyp=gridS;;
	thetao) filetyp=gridT;;
	uo) filetyp=gridU;;
	vo) filetyp=gridV;;
	wo) filetyp=gridW;;
	empmr|evap_oce|precip|qla_oce|qlw_oce|qns_oce|qsb_oce|qsr_oce|qt_oce|taum) filetyp=flxT;;
esac

case $MONTH in
	1|3|5|7|8|10|12) dend=31;;
	4|6|9|11) dend=30;;
	2) case $YEAR in
		2012) dend=29;;
		*) dend=28;;
	esac;;
esac

for day in $(seq 1 $dend); do
	mm=$(printf "%02d" $MONTH)
	dd=$(printf "%02d" $day)
  file_list=$(ls $stdir/*/NST/${CASE}-${CONFIG}_$FREQ_${YEAR}${mm}${dd}_${YEAR}${mm}${dd}_${filetyp}.nc4)
  fileo=${CONFIG}-${CASE}_1d_${YEAR}${mm}${dd}_${filetyp}.nc
  if [ ! -f  ${fileo}.nc ]; then echo ${fileo}; cdfmoy -l $file_list -o $fileo -nc4; fi
done
