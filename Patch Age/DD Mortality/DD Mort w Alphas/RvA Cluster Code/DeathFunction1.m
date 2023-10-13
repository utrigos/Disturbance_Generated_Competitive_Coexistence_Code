function D = DeathFunction1(a,nk,mk,rhok,mu,alpha1,alpha2)

% Calculates the death term for finite volume scheme.
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
%     mu : float 
%         Birth rate coefficient.
%           
% 
%     Returns
%     -------
%     D : array
%         n x 1 vector describing the distributied death quantities.

%It is assumed n_i is passed as nk

A1 = alpha1; %alpha values
A2 = alpha2;

DeathFunction1 = mu.*(1+A1.*nk+A1.*mk); %DD mort This option does not seem to give sensible results.
D =DeathFunction1;


end