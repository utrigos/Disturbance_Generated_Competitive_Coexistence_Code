# Disturbance_Generated_Competitive_Coexistence_Code

## General Description

This code is used to simulate either analytical or numerical results for the different models described in the paper.

All figures generated in the main paper and the supplement are labeled as Fig_"Fig#", i.e. "Fig_3b" or "Fig_S1" for supplemental figures.

There are several folders of code relating to the different model cases described. 

"Basic Files" holds a very basic code for the density-dependent reproduction case. 

"Patch-Age" holds a variety of folders with the more detailed model cases (some of which were run on the cluster and make take an indefinite amount of time on a regular computer.

All of the folder have the same basic setup: there are
- two reproduction functions (one for the resident--species 1--and one for the invader--species 2.  
- two death functions (similarly setup to the reproduction functions)
- a one species code--which simulates one species on its own
- a two species code--which simulates the invasion
- InvasionFunction.m which simulates the invasion (in some of the folders)
- HRAgeFlux which runs the flux code
- RhoHRAge which simulates patch dynamics.

SPECIFIC INSTRUCTIONS TO REPLICATE FIGURES BEGIN
September 2024 Update

Main Manuscript
Fig 1: No code.

Fig 2:  

	2(a): Set g =0.1 mycount=1, ai=aj=1. mycount = 1. Run “fig2a_fig5_figS2_Sept2024Update.m” in folder
		Patch Age > DD Reproduction > DDReproduction-with-Acritical 
  
	2(b): Set F == 1. Run “Fig2_b_d_Fig3b_Sep2024Update.m” in folder
		Patch Age > DD Offspring Survival AND Reproduction 
  
	2(c): Set i = 5, g = 2.5. Run “Fig2c_FigS4_Sep2024Update.m” in folder
		Patch Age > DD Reproduction 
  
	2(d): Set F == 2. Run “Fig2_b_d_Fig3b_Sep2024Update.m” in folder
		Patch Age > DD Offspring Survival AND Reproduction 

Fig 3:

	3(a): Set i=5:5 . Run “Fig3a_FigS5_FigS6_Sept2024Updated.m” in folder
		Patch Age > DD Offspring Survival > Cluster Matrix Data
  
	3(b): Set F == 3. Run “Fig2_b_d_Fig3b_Sep2024Update.m” in folder
		Patch Age > DD Offspring Survival AND Reproduction 
Fig 4:

	4(a): Set mycount = 1; . Run “Fig4a_FigS8_Sep2024Updated.m” in folder
		Patch Age > DD Mortality > DD Mort > Cluster Matrix Data r:m tradeoff
  
	4(b): Set F == 1; . Run “Fig_4_b_d_Sep2024Update.m” in folder
		Patch Age > DD Mortality > DD Mort > Cluster Matrix Data r:m tradeoff
  
	4(c): Set i = 4:4 . Run “Fig_4c_Fig_S9_Sept2024Updated.m” in folder
		Patch Age > DD Mortality > DD Mort w Alphas > Cluster Matrix Data r:alpha tradeoff
  
	4(d): Set F==2; . Run “Fig_4_b_d_Sep2024Update.m” in folder
		Patch Age > DD Mortality > DD Mort > Cluster Matrix Data r:m tradeoff
  
Fig 5: Set mycount=2; Change gamma as needed. Run “fig2a_fig5_figS2_Sept2024Update.m” in folder
		Patch Age > DD Reproduction > DDReproduction-with-Acritical 


Supplementary Information

Fig S1: Set mycount = 5:8 . Run “Fig_S1.m” in folder 
		Patch Age  > DD Reproduction > DDReproduction-with-Acritical > Cluster_Matrices
  
Fig S2: Change gamma as needed and run “fig2a_fig5_figS2_Sept2024Update.m” in folder
		Patch Age > DD Reproduction > DDReproduction-with-Acritical 
  
Fig S3: Run “Fig_S3.m” in folder
		Patch Age > DD Reproduction > DDReproductionwAlphas > RichardsExtrap > Cluster Matrix Data
  
Fig S4: Change gamma as needed and run “Fig2c_FigS4_Sep2024Update.m” in folder
		Patch Age > DD Reproduction 
  
Fig S5: Set i=6:6 . Run “Fig3a_FigS5_FigS6_Sept2024Updated.m” in folder
		Patch Age > DD Offspring Survival > Cluster Matrix Data
  
Fig S6: Change i as needed. Run “Fig3a_FigS5_FigS6_Sept2024Updated.m” in folder
		Patch Age > DD Offspring Survival > Cluster Matrix Data
  
Fig S7: Run “FigS7.m” in folder
		Patch Age > DD Mortality
  
Fig S8: Set mycount = 1:4 . Run “Fig4a_FigS8_Sep2024Updated.m” in folder
		Patch Age > DD Mortality > DD Mort > Cluster Matrix Data r:m tradeoff
  
Fig S9: Set i = 1:6 . Run “Fig_4c_Fig_S9_Sept2024Updated.m” in folder
		Patch Age > DD Mortality > DD Mort w Alphas > Cluster Matrix Data r:alpha tradeoff




Testing New Figures
Fig 3c :  Run “DDR_Alpha_Mortality_Trade_Off_New_Code_Oct_23_2024.m” in folder
	Patch Age > DD Reproduction



SPECIFIC INSTRUCTIONS TO REPLICATE FIGURES END

To run an invasion run 

- For Basic Files - "InvasionSweep.m" runs a one species simulation run "Invasion.m" both of which use the reproduction/death functions.

- For DD Mort w Alphas - (density-dependent adult-survival with varying competition) 	
	- "MutInvSweepWAc_brokenup.m" runs an invasion
	- "Invasion.m" runs one species dynamics
both of which use the reproduction/death/HRAgeFlux/RhoHRAge functions.

- For DD Mort - (density-dependent adult survival) 
	- "MutualInvasionSweep.m" runs the invasion
	- "Invasion.m" runs one species dynamics
both of which use the reproduction/death/HRAgeFlux/RhoHRAge functions.

- For DD Offspring Survival 
	- DDR_invasion.m simulates one species dynamics.
	- MutualInvasionSweepParallel.m simulates a two species invasion. (This code is setup for the cluster, comment out lines 7-18 if attempting to run on a personal computer, this may take an indefinite amount of time, reduce meshsize considerably if attempting.)
	-parallel_job_mutual.sh is a cluster job setup.

- For DD Reproduction
	- Fig code
	- DDReproduction-with-Acritical
		- DD_Seed_W_Alphas_Invasion.m will run one species dynamics with varying competition.
		- InvasionFunction.m will run one species dynamics with fixed competition.
		- InvasionSweep.m will run an invasion.
		- MutualInvasionSweep.m will run an invasion (updated version.)
		- InvasionSweepParallel.m will run an invasion in parallel.
		- MutualInvasionSweepwAc.m will run an invasion (and output critical values.
		- NumOverlaidwTheoretical.m will run an invasion (numerical + analytical on one graph).
		- fig_ will run the respective figures.
		


----- Extra Files -----
- in DD Mort W Alphas (density-dependent adult-survival with varying competition)

	- Cluster Matrix Data r:alpha tradeoff contains matrices run on the cluster as well as some fig code that requires these matrices.
	- MvA simulates a tradeoff between mortality and competition. Run MutInvSweepWAc_brokenUp.m to simulate an invasion and Invasion.m to simulate one species dynamics.
	- RvA Cluster Code simulates a tradeoff between reproduction and competition. Run MutInvSweepWAc_brokenUp.m to simulate an invasion and Invasion.m to simulate one species dynamics.


- in DD Mort (density-dependent adult survival)

	- Cluster Matrix Data r:m tradeoff contains matrices run on the cluster as well as some fig code 	  that requires these matrices.

- in DD Offspring Survival AND Reproduction
	This code runs a case which has both density-dependent offspring-survival AND density-dependent 	reproduction.
	- This folder contains a fig code as well as 
		- Invasion_Varying_DDRAlphas.m which fixes competition on reproduction and varies the 		
			competition on density-dependent offspring-survival (one species dynamics)
		- MutualInvasionSweepParallel.m (This code is set up to run on the cluster, comment out lines 
			7-17 to run on a personal computer, but this may take an indefinite amount of time. Reduce
			 mesh size considerably if attempting to run on a personal computer.)

- in DD Offspring Survival
	- Cluster Matrix Data contains matrices run on the cluster as well as a fig code which requires these matrices.



### Dependencies

Code was run on MATLAB_R2021b. 


## Version History

* 1.0.0
    * Initial Release

## Authors

Contributors names and contact info



## License

When you chose a license, you can include this text:

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments/More infor

Code was developed by Azmy S. Ackleh and Rainey Lyons.
