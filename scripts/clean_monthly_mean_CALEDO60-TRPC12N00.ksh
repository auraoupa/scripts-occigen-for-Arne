#!/bin/bash


for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do

	case $filetyp in
		gridT-2D|gridU-2D|gridV-2D|flxT) FREQ=1h;;
		gridT|gridS|gridU|gridV|gridW) FREQ=1d;;
	esac

	for month in $(seq 1 12); do
		rm tmp_monthly_mean_CALEDO60-TRPC12N00_${filetyp}_m${month}.ksh
	done

done

	
