function INT = TrapzRE(a,vec)

% Approximates the definite integral of a function f(a) over the values a
% using Richardson extrapolation and the built in MATLAB function trapz.
%     Parameters
%     ----------
%     a : array 
%         n x 1 vector representing a uniformly partitioned interval 
%   vec : array 
%         n x 1 vector representing the function f evaluated at the 
%           partition nodes
% 
%     Returns
%     -------
%   INT : float
%         Approximated integral value.

%% Calculate uniform step size
da = a(4)-a(3);

%% Construct finer mesh using half the given step size and interpolate the 
% given function over new mesh
a2 = a(1):da/2:a(end);
vec2 = spline(a,vec,a2);

%% Use trapz() to approximate integral over the two different meshes
INT1 = trapz(a,vec);
INT2 = trapz(a2,vec2);

%% Preform Richardson extrapolation 
INT = (2^2 * INT2 - INT1)/(2^2-1);

end