function [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma,Salpha1,Salpha2,Ralpha1,Ralpha2) 

% Implements flux limiter finite volume scheme to simulate population 
% dynamics for the two species case.
%     Parameters
%     ----------
%     Na :integer 
%         Number of nodes in the age variable.
%     Nt :integer 
%         Number of nodes in the time variable.
%InitCon1:array 
%         1 x Na Vector represented the initial age distribution for species 1.
%InitCon2:array 
%         1 x Na Vector represented the initial age distribution for species 2.
%   amax :float 
%         Maximum age.
%   tmax :float 
%         Maximum time of the simulation.
% birth1 :float 
%         Birth rate coefficient for species 1.
% birth2 :float 
%         Birth rate coefficient for species 2.
% death1 :float 
%         Death rate coefficient for species 1.
% death2 :float 
%         Death rate coefficient for species 2.
%  gamma :float 
%         Disturbance rate coefficient.
% alpha1 :float 
%         Competition rate coefficient for species 1.
% alpha2 :float 
%         Competition rate coefficient for species 2.
% 
%     Returns
%     -------
%     n : array
%         Nx x Nt matrix discribing the evolution of age distribution
%           over time of species 1.
%     m : array
%         Nx x Nt matrix discribing the evolution of age distribution
%           over time of species 2.
%     SI: float
%         Approximated equilibrium constant for species 1.
%     SJ: float
%         Approximated equilibrium constant for species 2.


%This is the same as the HRAge function, but it takes initial
%condition and birth/death as parameters.

da = amax/Na;
dt = tmax/Nt;

a = 0:da:amax;
t = 0:dt:tmax;

la=length(a);
CFL = gamma*(dt+(3/2)*(dt/da));

%===============Model Ingredients===================================
initn=InitCon1; %initial Density for sp 1 (resident)
initm=InitCon2; %inital Density for sp 2 (invader)

p=0; %proportion surviving disturbance 

b1 =Birth1; %Reproduction constants
b2 = Birth2 ;
mu1 = Death1; %Death constants
mu2 = Death2;
SA1 = Salpha1; %reproduction competition coefficient for resident
SA2 = Salpha2; %reproduction competition coefficient for invader
RA1 = Ralpha1; %offspring survival competition coefficient for resident
RA2 = Ralpha2; %offspring survival competition coefficient for invader

SingleSpeciesR1 = b1/(mu1+gamma);
SingleSpeciesR2 = b2/(mu2+gamma);
%===================================================================

n = zeros(length(a),length(t));
m = zeros(length(a),length(t));
n(:,1) = initn';
m(:,1) = initm';

rho = diag(gamma*exp(-gamma.*a))*ones(length(a),length(t));


for k = 1:length(t)-2
   %% Gathers model functions for current time step 
   RepoN = ReproductionFunction1(a,n(:,k),m(:,k),rho(:,k),b1,SA1, SA2, RA1, RA2);
   RepoM = ReproductionFunction2(a,m(:,k),n(:,k),rho(:,k),b2,SA1, SA2, RA1, RA2);

   DeathN = DeathFunction1(a,n(:,k),m(:,k),rho(:,k),mu1);
   DeathM = DeathFunction1(a,m(:,k),n(:,k),rho(:,k),mu2);
   
   %% Calculate flux at interfaces
   FluxN = HRAgeFlux(n(:,k));
   FluxM = HRAgeFlux(m(:,k));
   
   %% Solve PDE at half time step
   for j = 2:la
      n(j,k+1) = n(j,k) + dt*RepoN(j) - dt*DeathN(j) *n(j,k) -dt/da*(FluxN(j)-FluxN(j-1));
      m(j,k+1) = m(j,k) + dt*RepoM(j) - dt*DeathM(j) *m(j,k) -dt/da*(FluxM(j)-FluxM(j-1));
   end
 %% Calculate half time boundary value
   n(1,k+1) = p*da*gamma*((1/2)*n(end,k+1)*rho(end,k+1)+(3/2)*n(2,k+1)*rho(3,k+1)+sum(n(3:end-1,k+1).*rho(3:end-1,k+1)));
   m(1,k+1) = p*da*gamma*((1/2)*m(end,k+1)*rho(end,k+1)+(3/2)*m(2,k+1)*rho(3,k+1)+sum(m(3:end-1,k+1).*rho(3:end-1,k+1)));  

    %% Repeat calculations using half time information
   s=k+1;

   RepoN = ReproductionFunction1(a,n(:,s),m(:,s),rho(:,s),b1,SA1, SA2, RA1, RA2);
   RepoM = ReproductionFunction2(a,m(:,s),n(:,s),rho(:,s),b2,SA1, SA2, RA1, RA2);

   DeathN = DeathFunction1(a,n(:,s),m(:,s),rho(:,s),mu1);
   DeathM = DeathFunction1(a,m(:,s),n(:,s),rho(:,s),mu2);

   FluxN = HRAgeFlux(n(:,s));
   FluxM = HRAgeFlux(m(:,s));
   
   for j = 2:length(a)
      n(j,s+1) = n(j,s) + dt*RepoN(j) - dt*DeathN(j) *n(j,s) -dt/da*(FluxN(j)-FluxN(j-1));
      m(j,s+1) = m(j,s) + dt*RepoM(j) - dt*DeathM(j) *m(j,s) -dt/da*(FluxM(j)-FluxM(j-1));
   end
   
   
   n(1,s+1) = p*da*gamma*((1/2)*n(end,s+1)*rho(end,s+1)+(3/2)*n(2,s+1)*rho(3,s+1)+sum(n(3:end-1,s+1).*rho(3:end-1,s+1)));
   m(1,s+1) = p*da*gamma*((1/2)*m(end,s+1)*rho(end,s+1)+(3/2)*m(2,s+1)*rho(3,s+1)+sum(m(3:end-1,s+1).*rho(3:end-1,s+1)));  

   %% New time is average of calculated steps
   n(:,k+1) = 0.5*(n(:,k+1)+n(:,s+1));
   m(:,k+1) = 0.5*(m(:,k+1)+m(:,s+1));
end

%% Repeat calculations for final time

k = length(t)-1;

RepoN = ReproductionFunction1(a,n(:,k),m(:,k),rho(:,k),b1,SA1, SA2, RA1, RA2);
RepoM = ReproductionFunction2(a,m(:,k),n(:,k),rho(:,k),b2,SA1, SA2, RA1, RA2);

DeathN = DeathFunction1(a,n(:,k),m(:,k),rho(:,k),mu1);
DeathM = DeathFunction1(a,m(:,k),n(:,k),rho(:,k),mu2);

FluxN = HRAgeFlux(n(:,k));
FluxM = HRAgeFlux(m(:,k));
   
for j = 2:length(a)
   n(j,k+1) = n(j,k) + dt*RepoN(j) - dt*DeathN(j) *n(j,k) -dt/da*(FluxN(j)-FluxN(j-1));
   m(j,k+1) = m(j,k) + dt*RepoM(j) - dt*DeathM(j) *m(j,k) -dt/da*(FluxM(j)-FluxM(j-1));
end

n(1,k+1) = p*da*gamma*((1/2)*n(end,k+1)*rho(end,k+1)+(3/2)*n(2,k+1)*rho(3,k+1)+sum(n(3:end-1,k+1).*rho(3:end-1,k+1)));
m(1,k+1) = p*da*gamma*((1/2)*m(end,k+1)*rho(end,k+1)+(3/2)*m(2,k+1)*rho(3,k+1)+sum(m(3:end-1,k+1).*rho(3:end-1,k+1)));  

%% Calculate Equilibrium constant
SN = ReproductionFunction1(a,n(:,end),m(:,end),rho(:,end),b1,SA1, SA2, RA1, RA2);
SM = ReproductionFunction2(a,m(:,end),n(:,end),rho(:,end),b2,SA1, SA2, RA1, RA2);
SI = SN(1);
SJ = SM(1);

%% Calculate Estimated reproduction numbers (currently unused)
RepoNum1 = max(0,1-1*SJ/mu2)*SingleSpeciesR1;
RepoNum2 = max(0,1-SI/mu1)*SingleSpeciesR2;



end
