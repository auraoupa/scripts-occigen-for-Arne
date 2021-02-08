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
  1 - bash scripts and fortran librairies to compute means, eke, rmssh, etc .. then whatever you prefer for plots
  1 - plots directly in python using jupyter-notebooks on visu nodes, attacking the raw outputs of simulation (no intermediate files)
