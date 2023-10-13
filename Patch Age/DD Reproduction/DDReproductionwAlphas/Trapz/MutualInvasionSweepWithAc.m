tic

f = datetime('now');
disp(f);

% 
Birth1 = 33.3; %fixed Param %resident
Birth2 = 33.3;
Death1 = 18.5; %fixed Param %resident
alpha1 = 7.6;


gamma =2.5; %fixed Param

% Birth1 = 33.3; %fixed Param %resident
% Birth2 = 33.3;
% Death1 = 18.5; %fixed Param %resident
% alpha1 = 7.6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%InvType = 1; %Ursula ADDED CODE CONSTANT INVASION

InvType = 2; %Ursula ADDED CODE FUNCTION INVASION


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            
StepSizeA = 1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 1;


alpha2 = 12:StepSizeA:22; %Mesh for Birth       and Death params. 
Death2 = 3:StepSizeD: 8; %I scale these linearly, but they can have any upper bound.

La = length(alpha2);
Ld = length(Death2);

%% Mutual Invasion Block
BoolMat1 = zeros(La,Ld);
BoolMat2 = zeros(La,Ld);

parfor i = 1:La
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j)] = InvasionFunction(Birth1, Death1, Birth2, Death2(j), gamma, InvType,alpha1,alpha2(i));
        [BoolMat2(i,j),AcBoolMat2(i,j)] = InvasionFunction(Birth2, Death2(j), Birth1, Death1, gamma, InvType,alpha2(i),alpha1);        
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
% figure()
% surf(Death2,alpha2,BoolMat1, 'DisplayName', 'Sp i','EdgeColor','k','FaceColor', 'r','FaceAlpha',0.5,'EdgeAlpha',0.5)
% title('n_i invades n_j')
% xlabel('mu_i')
% ylabel('b_i')
% view(0,90)
%  legend('Location','south','FontSize',16)
% 
% 
% figure()
% surf(Death2,alpha2,BoolMat2,'DisplayName', 'Sp j','EdgeColor','k','FaceColor', 'b','FaceAlpha',0.5,'EdgeAlpha',0.5)
% title('n_j invades n_i')
% xlabel('mu_i')
% ylabel('\alpha_i')
% view(0,90)
% %  axis([10 Death1 50 60])
%  legend('Location','south','FontSize',16)

% figure()
% surf(Death2,alpha2,MutInvadeMat,'DisplayName', 'Mutual Invasion','EdgeColor','k','FaceColor', 'k','FaceAlpha',0.5,'EdgeAlpha',0.5)
% title('Mutual Invasion')
% xlabel('mu_i')
% ylabel('\alpha_i')
% view(0,90)
% %  axis([10 Death1 50 60])
%  legend('Location','south','FontSize',16)

figure()

surf(Death2,alpha2,BoolMat1,'DisplayName', 'Sp i','EdgeColor','k','FaceColor', 'r','FaceAlpha',0.5,'EdgeAlpha',0.5)

hold on;

surf(Death2,alpha2,BoolMat2,'DisplayName', 'Sp j','EdgeColor','k','FaceColor', 'b','FaceAlpha',0.5,'EdgeAlpha',0.5)

hold on;
surf(Death2,alpha2,MutInvadeMat,'DisplayName', 'Mutual Invasion','EdgeColor','k','FaceColor', 'k','FaceAlpha',0.5,'EdgeAlpha',0.5)
title('Mutual Invasion')
xlabel('mu_i')
ylabel('\alpha_i')
% axis([0 100 0 100])
view(0,90)
 legend('Location','south','FontSize',16)

hold off


figure()
surf(Death2,alpha2,MutInvadeMat,'DisplayName', 'Mutual Invasion','EdgeColor','k','FaceColor', 'k','FaceAlpha',0.5,'EdgeAlpha',0.5)

hold on
surf(Death2,alpha2,MutInvadeMatAc,'DisplayName', 'Crit Con','EdgeColor','k','FaceColor', 'g','FaceAlpha',0.5,'EdgeAlpha',0.5)

title('Mutual Invasion and Critical Age Cond')
xlabel('mu_i')
ylabel('\alpha_i')
view(0,90)
%  axis([10 Death1 50 60])
 legend('Location','south','FontSize',16)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
           if InvType ==1
                xlswrite(sprintf('Matrix_Cons_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat1)
                xlswrite(sprintf('Matrix2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat2)
                xlswrite(sprintf('MutInvadeMatrix_Cons_muj_%g_bj_%g.csv',Death1,Birth1),MutInvadeMat)
                
                xlswrite(sprintf('Birth2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),Birth2)
                xlswrite(sprintf('Death2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),Death2)
           
           elseif InvType ==2

                %func eps
                 xlswrite(sprintf('Matrix_Func_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat1)
                xlswrite(sprintf('Matrix2_Func_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat2)
                xlswrite(sprintf('MutInvadeMatrix_Func_muj_%g_bj_%g.csv',Death1,Birth1),MutInvadeMat)
                
                xlswrite(sprintf('Birth2_Func_muj_%g_bj_%g.csv',Death1,Birth1),Birth2)
                xlswrite(sprintf('Death2_Func_muj_%g_bj_%g.csv',Death1,Birth1),Death2)
           end
%          
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeD)
fprintf('%f\n',InvType)

toc
[y,Fs] = audioread('tone.mp3');
sound(y,Fs)


% load train
% sound(y,Fs)