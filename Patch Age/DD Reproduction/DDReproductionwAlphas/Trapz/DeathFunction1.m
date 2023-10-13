function D = DeathFunction1(a,nk,mk,rhok,mu)

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
D = mu.*ones(length(nk),1);
end