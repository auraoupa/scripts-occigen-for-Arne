#!/bin/bash

YEAR=2012
CASE=TRPC12N00

#Clean before launching
rm tmp* *.e* *.o*

#Compute yearly means for both TROPICO12 and CALEDO60

cp make_yearly_mean.ksh tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i '11d' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
job1ytrop=$(sbatch tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )

cp make_yearly_mean.ksh tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i '11d' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
job1ycal=$(sbatch tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )


