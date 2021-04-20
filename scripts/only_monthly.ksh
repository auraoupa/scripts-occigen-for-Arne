#!/bin/bash

YEAR=2013
CASE=TRPC12N00

#Clean before launching
rm tmp* *.e* *.o*

#Compute monthly means for both TROPICO12 and CALEDO60
cp make_monthly_mean.ksh tmp_make_monthly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_monthly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_monthly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_monthly_mean_TROPICO12-${CASE}-${YEAR}.ksh
job1mtrop=$(sbatch tmp_make_monthly_mean_TROPICO12-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )

cp make_monthly_mean.ksh tmp_make_monthly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_monthly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_monthly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_monthly_mean_CALEDO60-${CASE}-${YEAR}.ksh
job1mcal=$(sbatch tmp_make_monthly_mean_CALEDO60-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )

