function B = ReproductionFunction2(a,nk,mk,rhok,b)

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



BirthFunction2 = b; %DD mort
B = trapz(a,rhok.*nk.*BirthFunction2).*ones(length(a),1); %reproduction term


end