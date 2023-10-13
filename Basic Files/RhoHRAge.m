function u=RhoHRAge(Nx,Nt,xmax,tmax,gamma)

% Implements flux limiter finite volume scheme to simulate patch 
% dynamics.
%     Parameters
%     ----------
%     Nx :integer 
%         Number of nodes in the age variable.
%     Nt :integer 
%         Number of nodes in the time variable.
%   xmax :float 
%         Maximum age.
%   tmax :float 
%         Maximum time of the simulation.
%  gamma :float 
%         Disturbance rate coefficient.
% 
%     Returns
%     -------
%     u : array
%         Nx x Nt matrix discribing the evolution of patch disturbance over
%           time.

dx=xmax/Nx;
dt=tmax/Nt;

x=0:dx:xmax;
t=0:dt:tmax;

lx=length(x);
CFL = gamma*(dt+(3/2)*(dt/dx));
 

%===============Model Ingredients===================================
iniu=gamma*exp(-gamma*x); %initial Density

birth = gamma* ones(lx,1);
death = birth;
%===========================================================


u(:,1)=iniu';

for k = 1:length(t)-2;      
    F = HRAgeFlux(u(:,k));   

    for j = 2:lx
       u(j,k+1) = u(j,k) -dt/dx*(F(j)-F(j-1)) - dt*death(j)*u(j,k);
    end
 
    u(1,k+1) = trapz(x,birth.*u(:,k+1));

%=====================================================    
    s = k+1;
    F = HRAgeFlux(u(:,s));   

    for j = 2:lx
       u(j,s+1) = u(j,s) -dt/dx*(F(j)-F(j-1)) - dt*death(j)*u(j,s);
    end
  
    u(1,s+1) = trapz(x,birth.*u(:,s+1));
    
    
    
%=============RK Time Discretization=================    
    u(:, k+1) = 0.5*(u(:,k+1)+u(:,s+1));
end

k = length(t)-1;
F = HRAgeFlux(u(:,k));   

for j = 2:lx
   u(j,k+1) = u(j,k) -dt/dx*(F(j)-F(j-1)) - dt*death(j)*u(j,k);
end

u(1,k+1) = trapz(x,birth.*u(:,k+1));




figure(1)
hold on
plot(x,u(:,end))
plot(x,gamma*exp(-gamma*x),'r') %SteadyState
legend('simulation','steady state')
title('Long Time')

end