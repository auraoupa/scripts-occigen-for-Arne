# Bash scripts to compute monthly and annual means and some extra diagnostics

I regrouped every steps in one single bash script that will launch every means and diags for one year of simulation :

  - [big_script.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/big_script.ksh), all you have to change is the name of the run and the year you want to consider, then you launch it : `./big_script.ksh`

This script is then launching :

  - the monly means of TROPICO12 
  - the monthly means of CALEDO60
  - the yearly means of TROPICO12 (when the monthly means are done, conditional job)
  - the yearly means of CALEDO60 (when the monthly means are done, conditional job)
  - 3D Eddy, Mean and Total Kinetic Energy for monthly and yearly means for TROPICO12 (when the yearly means are done)  
  - 3D Eddy, Mean and Total Kinetic Energy for monthly and yearly means for CALEDO60 (when the yearly means are done) 
  - Standart deviation of monthly and yearly means of SSH for TROPICO12  (when the yearly means are done)  
  - Standart deviation of monthly and yearly means of SSH for CALEDO60  (when the yearly means are done)  
  
So it requires :
  - [make_monthly_mean.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_monthly_mean.ksh) (to be changed when/if the frequency of outputs are changed), this script needs also :
    - [script_monthly_mean_CALEDO60.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_monthly_mean_CALEDO60.ksh)
    - [script_monthly_mean_TROPICO12.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_monthly_mean_TROPICO12.ksh)   
  - [make_yearly_mean.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_yearly_mean.ksh) (from monthly means previously computed), this script needs :
    - [script_yearly_mean_from_monthly_mean.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_yearly_mean_from_monthly_mean.ksh)
   - [make_eke.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_eke.ksh), that needs :
    - [script_eke.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_eke.ksh)
   - [make_rmsssh.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_rmsssh.ksh), that needs :
    - [script_rmsssh.ksh](https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_rmsssh.ksh)

Other diagnostics can be added to this big script on the same manner (curl, barotropic stream functions, etc ...) with 2 scripts :
  - a script_diag.ksh (the computation of the diag for one file)
  - a make_diag.ksh (a job that implements script_diag for every file (every month for instance) in parallel)

Always do a `chmod +x script.ksh` for each one of them, in order to be able to execute them.

When the script is launched, do `squeue -u yourlogin`to check on the status of the multiple jobs that have been launched, some of them are waiting that the first are finished before going into queue (dependency).

When all the jobs are completed, check all the outputs :

If the log file *.e* are empty that's good news, it means that no error were found.

Finally check in the output directories that the files are all here : 252 in 1m, in 1y.

A typical error is :

```
srun: Job step aborted: Waiting up to 32 seconds for job step to finish.
slurmstepd: error: *** STEP 11538725.0 ON n1259 CANCELLED AT 2021-02-25T13:43:42 DUE TO TIME LIMIT ***
slurmstepd: error: *** JOB 11538725 ON n1259 CANCELLED AT 2021-02-25T13:43:42 DUE TO TIME LIMIT ***
```

That means that the job finished before the tasks were completed, meaning that you have to increase the walltime in the job it is the line : `#SBATCH --time=00:30:00` in make_*ksh
