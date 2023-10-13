function B = ReproductionFunction2(a,nk,mk,rhok,b,Salpha1,Salpha2,Ralpha1,Ralpha2)
    
    % Calculates the birth term for finite volume scheme.
% This is the same as ReproductionFunction1, but can be used if different
% competition effects are of interest.
%     Parameters
%     ----------
%     a : array 
%         n x 1 vector describing a partitioned age domain.
%     nk : array 
%         n x 1 vector describing the population age distribution at some time 
%             of the resedient species.
%     mk : array 
%         n x 1 vector describing the population age distribution at some time 
%             of the competitor species.
%   rhok : array 
%         n x 1 vector describing the patch age distribution at some time 
%     b : float 
%         Birth rate coefficient.
%alpha1 : float 
%         Intraspecies competition coefficient.
%alpha2 : float 
%         Interspecies competition coefficient.
%           
% 
%     Returns
%     -------
%     B : array
%         n x 1 vector describing the distributied bith quantities.


    %It is assumed n_i is passed into the function as nk
    % The function f_i in the paper (here is where we include b_i)

SA1 = Salpha1; %reproduction competition coefficient for resident
SA2 = Salpha2; %reproduction competition coefficient for invader
RA1 = Ralpha1; %offspring survival competition coefficient for resident
RA2 = Ralpha2; %offspring survival competition coefficient for invader

RecruitFunction2 = b.*max(1-(RA2.*nk+RA2.*mk),0); %Max
BirthFunction2 = max(1-(SA2.*nk+SA2.*mk),0); %Max

B = trapz(a,rhok.*nk.*BirthFunction2).*RecruitFunction2;                     %DD offspring survival

end