# Scripts on occigen for Arne

All there is to know to properly look at CALEDO simulations on occigen ...

On occigen, there are 3 types of space :
  - your home (/home/abendinger), limited to 100G 30 000 files
  - your scratch (/scratch/cnt0024/ige2071/abendinger), common space between all memebers of ige2071 group, limited to 20,480 Tb 900 000files in total
  - your store ( /store/abendinger ), no limitations
  
I advise you to put all the valuable scripts on your home, the working or temporary files on the scratch and for longer conservation on the store (make tar of files)
Conda environments and git repo can have many files so better put it on scratch

- `etat_projet` command to check on the quotas
- `module list`to see what is already loaded and `module avail`to see what's available


For now, the outputs of simulations are on /store/CT1/hmg2840/lbrodeau/TROPICO12/

Two methodologies can be applied for you, depending on what you prefer and/or what is more efficient :
  - 1) bash scripts and fortran librairies to compute means, eke, rmssh, etc .. then whatever you prefer for plots
  - 2) plots directly in python using jupyter-notebooks on visu or frontal nodes, attacking the raw outputs of simulation (no intermediate files)
  
  
Method 1 :

  - install CDFTOOLS
  - bash scripts + mpi + job submission
  
Method 2 :

  - install conda environment (conda-pack or svp)
  - vncviewer on tunnel machine
  - notebooks
  

## Git

In any case, keep track of the scripts with git repo, backed-up on github (sshfs on tunnel machine)

On occigen :
  - create a repository where to store all your git repo (on scratch), for instance `/scratch/cnt0024/ige2071/aalbert/git`
On the tunnel machine :
  - create a repo that will mirror the one on occigen, in my case `alberta@ige-meom-cal1:~/sshfs-occ-aalbert`
  - `cd; sshfs aalbert@occigen.cines.fr:/scratch/cnt0024/ige2071/aalbert/git sshfs-occ-aalbert` 
  - `cd sshfs-occ-aalbert`
  - manage your git repos (git clone, git pull, git add + commit + push)
  
## Method 1

for fortran code, load the following modules (in your .bashrc) :

```
module load intel
module load openmpi/intel/2.0.1
module load hdf5/1.8.17
module load netcdf/4.4.0_fortran-4.4.2
```


### CDFTOOLS

On the tunnel machine :
  - go to to the repo that mirrors occigen repo for git (redo the sshfs command if needed)
  - `git clone https://github.com/meom-group/CDFTOOLS.git`
  
On occigen :
  - follow the instructions here : https://github.com/meom-group/CDFTOOLS (use macro.occigen2 and be sure to have WORKDIR defined and the modules loaded)
  - the executables are now in /scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin
  
### Bash scripts

Some examples of scripts that can be deployed for any TROPICO12-CALEDO60 simulation :
  - some generic scripts that compute monthly means :
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_monthly_mean_TROPICO12.ksh
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/script_monthly_mean_CALEDO60.ksh
  - jobs that call the above scripts to effectively compute monthly means for a given simulation :
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_monthly_mean_CALEDO60-TRPC12N00.ksh
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/make_monthly_mean_TROPICO12-TRPC12N00.ksh
  - cleaning scripts :
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/clean_monthly_mean_CALEDO60-TRPC12N00.ksh
    - https://github.com/auraoupa/scripts-occigen-for-Arne/blob/main/scripts/clean_monthly_mean_TROPICO12-TRPC12N00.ksh

Do a `chmod +x script.ksh` for each one of them, in order to be able to execute them.

To launch the job the syntax is : `sbatch make_monthly_mean_CALEDO60-TRPC12N00.ksh`, it will produce 2 outputs `mean-cal.e$id_of_the_job` (error) and `mean-cal.e$id_of_the_job` (output), always have a quick look to see if something went wrong, for instance the error :

```
srun: Job step aborted: Waiting up to 32 seconds for job step to finish.
slurmstepd: error: *** STEP 11538725.0 ON n1259 CANCELLED AT 2021-02-25T13:43:42 DUE TO TIME LIMIT ***
slurmstepd: error: *** JOB 11538725 ON n1259 CANCELLED AT 2021-02-25T13:43:42 DUE TO TIME LIMIT ***
```

means that the job finished before the tasks were completed, meaning that you have to increase the walltime in the job it is the line : `#SBATCH --time=00:30:00`

## Method 2
  
### Conda

For method #2, you will need all the python librairies to deal with netcdf files, parallezition of computations, plotting and mapping

On the tunnel machine :
  - install conda from installer :https://docs.conda.io/en/latest/miniconda.html
  - set up the environment with all librairies you want :
    - `conda create --name myenv`
    - `conda install -c conda-forge netcdf4 xarray dask numpy seawater cartopy cmocean papermill jupyter conda-pack ipykernel seaborn`
  - `conda pack -n caledo`
  - `scp caledo.tar.gz aalbert@occigen.cines.fr:/scratch/cnt0024/ige2071/aalbert/conda/.`
  - `wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`
  - `scp Miniconda3-latest-Linux-x86_64.sh aalbert@occigen.cines.fr:/home/aalbert/.`
    
On occigen :

  - `chmod +x Miniconda3-latest-Linux-x86_64.sh; ./Miniconda3-latest-Linux-x86_64.sh` (choose /scratch/cnt0024/ige2071/aalbert/conda/miniconda3 for where to install)
  - add in .bash_aliases `alias cond="export PATH='/scratch/cnt0024/ige2071/aalbert/conda/miniconda3/bin:$PATH'"`
  - `source .bash_aliases; cond`
  - `cd /scratch/cnt0024/ige2071/aalbert/conda/; mkdir caledo; tar -xzf caledo.tar.gz -C caledo`
  - `source caledo/bin/activate`
  - `python -m ipykernel install --user --name caledo --display-name caledo`
    
## Notebook

First terminal :
  - connect to visu : `ssh -CY aalbert@visu.cines.fr`
  - check if one visu is available : `vizqueue`, only 4 nodes visu1-4
  - book one node for maximum 6h : `vizalloc -m vnc -t 360`, one node is allocated to you
  
Second terminal :
  - connect to the visu node allocated to you : `ssh -CX aalbert@visu3.cines.fr`
  - got to your notebook repo (same architecture than on occigen) znd launch jupyter notebook : `/scratch/cnt0024/ige2071/aalbert/conda/miniconda3/bin/jupyter-notebook --no-browser` (make an alias of it)
  
  - add `alias jupnb="export PATH="/scratch/cnt0024/ige2071/aalbert/conda/miniconda3/bin:$PATH"; jupyter-notebook --no-browser"` in your .bash_aliases, `source /home/aalbert/.bash_aliases`
  - go to your notebooks repo and launch jupyter notebook with jupnb command

Third terminal :
  - launch vncviewer on the tunnel machine
  - enter the name of the visu node you got in VNC server : `visu3.cines.fr:5901` , click on connect
  - enter login & passwd
  - a virtual machine is launching, slide up to get to the desktop
  - click on Applications/Outils Sytem/Terminal
  - `module load firefox; firefox` 
  - copy the adress output for jupyter command in the firefox terminal
  - 
    
  

