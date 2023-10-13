%tic

f = datetime('now');
disp(f);

mycount = 1;

    if mycount ==1 || mycount ==6
            %________PARAMETER (a)______%
            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            %________PARAMETER (a)_______%
            
    elseif mycount ==2 || mycount ==7        
            % % %________PARAMETER (b)______%
            Birth1 = 5.6; %resident
            Death1 = 1;   %resident
            % % %________PARAMETER (b)_______%
            
    elseif mycount ==3 || mycount ==8        
            % %________PARAMETER (c)______%
             Birth1 = 6.8; %resident
             Death1 = 2;   %resident
            % %________PARAMETER (c)_______%
            
    elseif mycount ==4 || mycount ==9       
            % %________PARAMETER (d)______%
             Birth1 = 9; %resident
             Death1 = 2;   %resident
            % %________PARAMETER (d)_______%

    end

if mycount <6
    InvType = 1;
elseif mycount > 5 
    InvType =2;
end


gamma =1; %fixed Param

StepSizeB = .5; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = .5;

Birth2 = Birth1:StepSizeB:30-Death1+Birth1; %Mesh for Birth       and Death params. 
Death2 = Death1:StepSizeD:30; %I scale these linearly, but they can have any upper bound.

Lb = length(Birth2);
Ld = length(Death2);


BoolMat1 = zeros(Lb,Ld);
BoolMat2 = zeros(Lb,Ld);

parfor i = 1:Lb
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j)] = InvasionFunction(Birth1, Death1, Birth2(i), Death2(j), gamma, InvType);
        [BoolMat2(i,j),AcBoolMat2(i,j)] = InvasionFunction( Birth2(i), Death2(j), Birth1, Death1, gamma, InvType);        
    end
end


MutInvadeMat = double(BoolMat1&BoolMat2);                             

    BoolMat1(BoolMat1 == 0) = NaN; 
    %BoolMat1(BoolMat1 ~=1) = NaN;            %yellow region where invader does not survive

    BoolMat2(BoolMat2 ==0) = NaN;
    %BoolMat2(BoolMat2 ~=1) = NaN;            %yellow region where invader does not survive

    MutInvadeMat(MutInvadeMat ==0) = NaN;
    %MutInvaderMat(MutInvaderMat ~=1) = NaN;   %yellow region where invader does not survive

figure()
surf(Death2,Birth2,BoolMat1)
title('n_i invades n_j')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

figure()
surf(Death2,Birth2,BoolMat2)
title('n_j invades n_i')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

figure()
surf(Death2,Birth2,MutInvadeMat)
title('Mutual Invasion')
xlabel('mu_i')
ylabel('b_i')
view(0,90)


f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeB)
fprintf('%f\n',InvType)

%toc

%exit;