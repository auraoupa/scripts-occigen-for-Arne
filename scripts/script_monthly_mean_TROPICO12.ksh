#!/bin/bash

CONFIG=TROPICO12
CASE=$1
VAR=$2
FREQ=$3
YEAR=$4
MONTH=$5

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-MEAN/1m

mkdir -p $dir
cd $dir

stdir=/store/CT1/hmg2840/lbrodeau/$CONFIG/${CONFIG}_NST-$CASE-S

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

mm=$(printf "%02d" $MONTH)

file_list=$(ls $stdir/*/${CONFIG}_NST-${CASE}_$FREQ_${YEAR}${mm}??_${YEAR}${mm}??_${filetyp}.nc4)

fileo=${CONFIG}_NST-${CASE}_1m_${YEAR}${mm}_${filetyp}.nc

if [ ! -f  ${fileo}.nc ]; then echo ${fileo}; cdfmoy -l $file_list -o $fileo -nc4; fi


