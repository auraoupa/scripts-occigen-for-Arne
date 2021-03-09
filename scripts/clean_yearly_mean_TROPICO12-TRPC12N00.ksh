#!/bin/bash

CASE=TRPC12N00
YEAR=2012

for filetyp in gridT-2D gridU-2D gridV-2D gridT gridS gridU gridV gridW flxT; do
	rm tmp_yearly_mean_TROPICO12-${CASE}_${filetyp}_y${YEAR}.ksh
done
rm mean1y-trop.e* mean1y-trop.o*
	