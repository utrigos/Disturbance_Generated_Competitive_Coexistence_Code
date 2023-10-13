tic; %timing

tmax = 400;
amax = 20;
Na = 400; %These control accuracy of scheme. The OneSpecies function will print out a CFL value.
Nt = 12000; %This value estimates the true CFL condition. Just make sure this value << 1.

StepSizeB = 1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 1; 

Birth1 = 2.34; %fixed Param
Death1 = 0.4; %fixed Param
gamma =0.2; %fixed Param

da = amax/Na;
a = (0:da:amax)';

initcon = 2.*exp(-2*a);
eps = 10^(-5); %Initial size for invader. Also used as extinction check tolerence.
Birth2 = Birth1:StepSizeB:15*Birth1; %Mesh for Birth and Death params. 
Death2 = Death1:StepSizeD:20*Death1; %I scale these linearly, but they can have any upper bound.


%=====================================
Matrix = zeros(length(Birth2),length(Death2)); % These will store the results of the simulations
Matrix2 = zeros(length(Birth2),length(Death2));

n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma);

InitCon1 = n(:,end);
InitCon2 = eps.* ones(length(a),1);

rho =gamma.*exp(-gamma.*a); % rho at steady-state
for i = 1:length(Birth2)
    for j = 1:length(Death2)
        [n,m,R1,R2] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2(i),Death2(j),gamma);
        if R1 >1 && R2>1
            Matrix2(i,j) =1;
        end
        
        if sum(da*rho.*m(:,end)) > eps
            if sum(da*rho.*n(:,end))> eps
                Matrix(i,j) = 1;
            else
                Matrix(i,j) = 2;
            end
        else
            continue
        end
    end
end

Matrix(Matrix == 0) = NaN; 
%Matrix(Matrix ~=1) = NaN;
Matrix2(Matrix2 ==0) = NaN;

fig1 = figure(1)
surf(Death2,Birth2,Matrix)
title('Invasion Parameter Sweep')
xlabel('mu_i')
ylabel('b_i')
view(0,90)
%In this figure you will see two regions. In one, both species seem to
%coexist (blue on my version of MATLAB) and in the other the invader 
%takes the resident (yellow on my version). If you would like to remove the
%yellow region, uncomment out the line "Matrix(Matrix ~=1) = NaN;"


toc; %timing


%plot of invader over time
fig3 = figure(3)
dt = tmax/Nt;
t = 0:dt:tmax;
surf(t,a,m,'EdgeColor',[0.8500, 0.3250, 0.0980])
title('Invader changing over time')
xlabel('time')
ylabel('age')
zlabel('Invasive Species')



exit;