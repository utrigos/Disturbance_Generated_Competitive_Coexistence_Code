function [n,CFL] = OneSpecies(Na,Nt,initcon,amax, tmax,birth,death,gamma,Salpha1,Salpha2,Ralpha1,Ralpha2)

                % Implements flux limiter finite volume scheme to simulate population 
% dynamics for the one species case.
%     Parameters
%     ----------
%     Na :integer 
%         Number of nodes in the age variable.
%     Nt :integer 
%         Number of nodes in the time variable.
%initcon :array 
%         Vector represented the initial condition for age structured model.
%   amax :float 
%         Maximum age.
%   tmax :float 
%         Maximum time of the simulation.
%  birth :float 
%         Birth rate coefficient.
%  death :float 
%         Death rate coefficient.
%  gamma :float 
%         Disturbance rate coefficient.
% alpha1 :float 
%         Competition rate coefficient.
% alpha2 :float 
%         Competition rate coefficient.
% 
%     Returns
%     -------
%     n : array
%         Nx x Nt matrix discribing the evolution of the age distribution
%           over time.
%    CFL: float
%         Approximated CFL condition for finite volume scheme.


da = amax/Na;
dt = tmax/Nt;

a = 0:da:amax;
t = 0:dt:tmax;

la=length(a);
CFL = gamma*(dt+(3/2)*(dt/da));

%===============Model Ingredients===================================
%initial Density for sp 1

initn=initcon;

p =0; %proportion of sp 1 surviving disturbance 
b = birth ; %Reproduction constant
mu = death; %Death constant

SA1 = Salpha1; %reproduction competition coefficient for resident
SA2 = Salpha2; %reproduction competition coefficient for invader
RA1 = Ralpha1; %offspring survival competition coefficient for resident
RA2 = Ralpha2; %offspring survival competition coefficient for invader

R0 = b/(mu+gamma);
%===========================================================

n = zeros(length(a),length(t));
n(:,1) = initn;
m = zeros(length(a),length(t));

rho = gamma*diag(exp(-gamma*a))*ones(length(a),length(t));


for k = 1:length(t)-2
   RepoN = ReproductionFunction1(a,n(:,k),m(:,k),rho(:,k),b,SA1,SA2,RA1,RA2);
   DeathN = DeathFunction1(a,n(:,k),m(:,k),rho(:,k),mu);
   FluxN = HRAgeFlux(n(:,k));
   
   for j = 2:la
      n(j,k+1) = n(j,k) + dt*RepoN(j) - dt*DeathN(j) *n(j,k) -dt/da*(FluxN(j)-FluxN(j-1));
   end
    n(1,k+1) = p*da*gamma*((1/2)*n(end,k+1)*rho(end,k+1)+(3/2)*n(2,k+1)*rho(3,k+1)+sum(n(3:end-1,k+1).*rho(3:end-1,k+1)));

   
   s=k+1;
   RepoN = ReproductionFunction1(a,n(:,s),m(:,s),rho(:,s),b,SA1,SA2,RA1,RA2);
   DeathN = DeathFunction1(a,n(:,s),m(:,s),rho(:,s),mu);
   FluxN = HRAgeFlux(n(:,s));
   
   for j = 2:length(a)
      n(j,s+1) = n(j,s) + dt*RepoN(j) - dt*DeathN(j) *n(j,s) -dt/da*(FluxN(j)-FluxN(j-1));
   end 
    n(1,s+1) = p*da*gamma*((1/2)*n(end,s+1)*rho(end,s+1)+(3/2)*n(2,s+1)*rho(3,s+1)+sum(n(3:end-1,s+1).*rho(3:end-1,s+1)));

   
   n(:,k+1) = 0.5*(n(:,k+1)+n(:,s+1));
end

k = length(t)-1;

RepoN = ReproductionFunction1(a,n(:,k),m(:,k),rho(:,k),b,SA1,SA2,RA1,RA2);
DeathN = DeathFunction1(a,n(:,k),m(:,k),rho(:,k),mu);
FluxN = HRAgeFlux(n(:,k));
   
for j = 2:length(a)
   n(j,k+1) = n(j,k) + dt*RepoN(j) - dt*DeathN(j) *n(j,k) -dt/da*(FluxN(j)-FluxN(j-1));
end

 n(1,k+1) = p*da*gamma*((1/2)*n(end,k+1)*rho(end,k+1)+(3/2)*n(2,k+1)*rho(3,k+1)+sum(n(3:end-1,k+1).*rho(3:end-1,k+1)));



end