## Compute the amplitude and phase of the tide from SSH outputs of a simulation

### compile the TIDAL_TOOLS : https://github.com/molines/TIDAL_TOOLS

  - git clone https://github.com/molines/TIDAL_TOOLS

```
   cd TIDAL_TOOLS
   mkdir bin
   cd src
   ln -sf ../Macrolib/macro.occigen2 make.macro
   make tid_harm_ana
```

### apply it to ssh

 script : make_tidal_amp_phase.ksh 