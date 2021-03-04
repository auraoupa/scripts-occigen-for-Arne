#!/bin/bash

CASE=TRPC12N00
YEAR=2012

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do

	for month in $(seq 1 12); do
		rm tmp_monthly_mean_CALEDO60-${CASE}_${filetyp}_y${YEAR}_m${month}.ksh
	done

done

rm mean1m-cal.e* mean1m-cal.o*
	
