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

#Compute yearly means for both TROPICO12 and CALEDO60

cp make_yearly_mean.ksh tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1mtrop'/g' tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh
job1ytrop=$(sbatch tmp_make_yearly_mean_TROPICO12-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )

cp make_yearly_mean.ksh tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1mcal'/g' tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh
job1ycal=$(sbatch tmp_make_yearly_mean_CALEDO60-${CASE}-${YEAR}.ksh  | awk '{print $NF}' )

#Compute monthly and yearly diags : EKE, RMSSSH
cp make_eke.ksh tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1ytrop'/g' tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh
sbatch tmp_make_eke_TROPICO12-${CASE}-${YEAR}.ksh

cp make_eke.ksh tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1ycal'/g' tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh
sbatch tmp_make_eke_CALEDO60-${CASE}-${YEAR}.ksh 

cp make_rmsssh.ksh tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/TROPICO12/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1ytrop'/g' tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh
sbatch tmp_make_rmsssh_TROPICO12-${CASE}-${YEAR}.ksh

cp make_rmsssh.ksh tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/YEARM/'$YEAR'/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CASEM/'$CASE'/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/CONFIGM/CALEDO60/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sed -i 's/JOBIDMOY/'$job1ycal'/g' tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh
sbatch tmp_make_rmsssh_CALEDO60-${CASE}-${YEAR}.ksh 

