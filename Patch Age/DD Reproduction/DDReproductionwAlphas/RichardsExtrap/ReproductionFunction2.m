function B = ReproductionFunction2(a,nk,mk,rhok,b,alpha1,alpha2)

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

A1 = alpha1; %alpha values
A2 = alpha2;

%BirthFunction2 = b.*exp(-(A1.*nk+A2.*mk)); %Exponential 
%BirthFunction2 = b.* (1-A1*nk./(nk+1)-A2*mk./(mk+1)); %Beverton Holt
%B = TrapzRE(a,rhok.*nk).*BirthFunction2; %DD recruitement
%B = rhok.*nk.*BirthFunction1.*ones(length(a),1);            %DD Mort  


BirthFunction2 = b.*max(1-(A2.*nk+A2.*mk),0); %Max
B = TrapzRE(a,rhok.*nk.*BirthFunction2).*ones(length(a),1); %reproduction term

end