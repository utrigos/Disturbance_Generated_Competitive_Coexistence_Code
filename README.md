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
