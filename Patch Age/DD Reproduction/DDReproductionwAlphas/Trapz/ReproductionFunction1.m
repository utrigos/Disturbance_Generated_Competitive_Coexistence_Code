function B = ReproductionFunction1(a,nk,mk,rhok,b,alpha1,alpha2)

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


A1 = alpha1; %alpha values
A2 = alpha2;

BirthFunction1 = b.*max(1-(A1.*nk+A1.*mk),0); %Max


B = trapz(a,rhok.*nk.*BirthFunction1).*ones(length(a),1); %reproduction term DD reproduction

end