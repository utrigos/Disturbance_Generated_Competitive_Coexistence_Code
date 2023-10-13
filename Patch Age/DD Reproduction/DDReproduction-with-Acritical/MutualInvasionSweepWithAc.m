tic

f = datetime('now');
disp(f);

% Birth1 = 2.34; %fixed Param %resident
% Death1 = 0.4; %fixed Param %resident

Birth1 = 5.6; %fixed Param %resident
Death1 = 1; %fixed Param %resident


InvType = 1; 
%InvType = 2 


gamma =1; %fixed Param
            
StepSizeB = 5; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 5;


Birth2 = Birth1:StepSizeB:30; %Mesh for Birth       and Death params. 
Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.

Lb = length(Birth2);
Ld = length(Death2);


%% Mutual Invasion Block
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
%%

    %% Critical Age Block
MutInvadeMatAc = double(AcBoolMat1&AcBoolMat2);                             

    AcBoolMat1(AcBoolMat1 == 0) = NaN; 
    %BoolMat1(BoolMat1 ~=1) = NaN;            %yellow region where invader does not survive

    AcBoolMat2(AcBoolMat2 ==0) = NaN;
    %BoolMat2(BoolMat2 ~=1) = NaN;            %yellow region where invader does not survive

    MutInvadeMatAc(MutInvadeMatAc ==0) = NaN;
    %MutInvaderMat(MutInvaderMat ~=1) = NaN;   %yellow region where invader does not survive

%%
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


figure()
surf(Death2,Birth2,MutInvadeMat)
hold on
surf(Death2,Birth2,MutInvadeMatAc)
title('Mutual Invasion and Critical Age Cond')
xlabel('mu_i')
ylabel('b_i')
view(0,90)



f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeB)
fprintf('%f\n',InvType)

toc
