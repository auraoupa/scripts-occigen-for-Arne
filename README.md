# Scripts on occigen for Arne

All there is to know to properly look at CALEDO simulations on occigen ...

On occigen, there are 2 types of space :
  - your home (/home/abendinger), limited to 100G 30 000 files
  - your scratch (/scratch/cnt0024/ige2071/abendinger), common space between all memebers of ige2071 group, limited to 20,480 Tb 900 000files in total
  - your store ( /store/abendinger ), no limitations
  
I advise you to put all the valuable scripts on your home, the working or temporary files on the scratch and for longer conservation on the store (make tar of files)
Conda environments and git repo can have many files so better put it on scratch

- `etat_projet` command to check on the quotas
- `module list`to see what is already loaded and `module avail`to see what's available


For now, the outputs of simulations are on /store/CT1/hmg2840/lbrodeau/TROPICO12/

Two methodologies can be applied for you, depending on what you prefer :
  - 1) bash scripts and fortran librairies to compute means, eke, rmssh, etc .. then whatever you prefer for plots
  - 2) plots directly in python using jupyter-notebooks on visu nodes, attacking the raw outputs of simulation (no intermediate files)
  
  
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
  - create a repo that will the mirror of the one on occigen, in my case `alberta@ige-meom-cal1:~/sshfs-occ-aalbert`
  - `cd; sshfs aalbert@occigen.cines.fr:/scratch/cnt0024/ige2071/aalbert/git sshfs-occ-aalbert` 
  - `cd sshfs-occ-aalbert`
  - manage your git repos (git clone, git pull, git add + commit + push)
  
## Conda

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
    - `chmod +x Miniconda3-latest-Linux-x86_64.sh; ./Miniconda3-latest-Linux-x86_64.sh`
    - add in .bash_aliases `alias cond="export PATH='/scratch/cnt0024/ige2071/aalbert/conda/miniconda3/bin:$PATH'"`
    - `source .bash_aliases; cond`
    - `cd /scratch/cnt0024/ige2071/aalbert/conda/; mkdir caledo; tar -xzf caledo.tar.gz -C caledo`
    - `source caledo/bin/activate`
    - `python -m ipykernel install --user --name caledo --display-name caledo`
    

    
  

