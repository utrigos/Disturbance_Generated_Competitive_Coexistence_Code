function F = HRAgeFlux(uk)

% Calculates the flux for age structured models using minmod limiter.
%     Parameters
%     ----------
%     uk : array 
%         n x 1 vector describing population age distribution at some time k.
% 
%     Returns
%     -------
%     F : array
%         n x 1 vector describing boundary fluxes.

F = zeros(length(uk),1);
mm =@(a,b) (sign(a)+sign(b))/2*min(abs(a),abs(b));

F(1) = uk(1);
F(2) = uk(2);
F(end-1) = uk(end-1);
F(end) = uk(end);
for j = 3:length(uk)-2
   F(j) = uk(j) + 0.5* mm(uk(j+1)-uk(j), uk(j)-uk(j-1));   
end
end