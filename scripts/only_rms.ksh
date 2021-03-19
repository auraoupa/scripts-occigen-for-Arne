#!/bin/bash

YEAR=2012
CASE=TRPC12N00

#Clean before launching
rm tmp* *.e* *.o*


cp make_rmsssh.ksh tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i '11d' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sbatch tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh

cp make_rmsssh.ksh tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i '11d' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sbatch tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh 

