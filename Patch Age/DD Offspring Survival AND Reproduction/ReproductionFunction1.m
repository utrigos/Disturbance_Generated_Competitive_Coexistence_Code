function B = ReproductionFunction1(a,nk,mk,rhok,b,Salpha1,Salpha2,Ralpha1,Ralpha2)

% Calculates the birth term for finite volume scheme.
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
%         n x 1 vector describing the distributied birth quantities.

    %It is assumed n_i is passed into the function as nk
    % The function f_i in the paper (here is where we include b_i=r_i)

SA1 = Salpha1; %reproduction competition coefficient for resident
SA2 = Salpha2; %reproduction competition coefficient for invader
RA1 = Ralpha1; %offspring survival competition coefficient for resident
RA2 = Ralpha2; %offspring survival competition coefficient for invader

RecruitFunction1 = b.*max(1-(RA1.*nk+RA1.*mk),0); %Max
BirthFunction1 = max(1-(SA1.*nk+SA1.*mk),0);

B = trapz(a,rhok.*nk.*BirthFunction1).*RecruitFunction1; %DD offspring survival

end