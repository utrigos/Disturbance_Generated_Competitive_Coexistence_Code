function [Result,AcVal,CFL] = InvasionFunction(BirthRes, DeathRes, BirthInvade, DeathInvade, Gamma, InvType,Salpha1,Salpha2,Ralpha1,Ralpha2)

% Simulates species invasion and resident reaction using the finite volume
% scheme TwoSpecies().
%     Parameters
%     ----------
%     BirthRes :float 
%               Birth rate coefficient for resident species.
%     DeathRes :float 
%               Birth rate coefficient for resident species.
%  Birthinvade :float 
%               Birth rate coefficient for invader species.
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

tmax = 400; 
amax = 40;

Na = 800;
Nt = 12000;

eps = 10^(-6);

da = amax/Na;
a = 0:da:amax;

initcon = 2.*exp(-2*a);

[n,CFL] = OneSpecies(Na,Nt,initcon,amax, tmax,BirthRes,DeathRes,Gamma,Salpha1,Salpha2,Ralpha1,Ralpha2); 

InitConRes = n(:,end);

if InvType ==1
    InitConInvade = eps.* ones(length(a),1); %constant eps case
elseif InvType ==2
    InitConInvade = eps.*a.*exp(-a); %eps(a) case
end    
    
[n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitConRes,InitConInvade,BirthRes,DeathRes,BirthInvade,DeathInvade,Gamma,Salpha1,Salpha2,Ralpha1,Ralpha2);
rho = Gamma.*exp(-Gamma.*a'); % rho at steady-state

if sum(da*rho.*m(:,end)) > eps
    Result = 1; 
else 
    Result = 0;
end

%% AC value
if max(Salpha1.*n(:,end)+Salpha1.*m(:,end))<1 && max(Ralpha1.*n(:,end)+Ralpha1.*m(:,end))<1 
           AcVal= 1;
else
            AcVal=0;
end
%% AC value

end