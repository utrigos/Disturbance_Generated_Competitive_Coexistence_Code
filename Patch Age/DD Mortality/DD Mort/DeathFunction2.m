function D = DeathFunction2(a,nk,mk,rhok,mu)

% Calculates the death term for finite volume scheme.
% This is the same as DeathFunction1, but can be used if different
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
%     mu : float 
%         Birth rate coefficient.
%           
% 
%     Returns
%     -------
%     D : array
%         n x 1 vector describing the distributed death quantities.

%It is assumed n_i is passed as nk

A1 = 1;
A2 = 1;


DeathFunction2 = mu.*(A1.*nk+A2.*mk); %DD mort


D =DeathFunction2;


end