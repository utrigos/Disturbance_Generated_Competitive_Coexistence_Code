tic

f = datetime('now');
disp(f);



part =str2double(getenv('SLURM_ARRAY_TASK_ID'));  %the last number of the array (1,2,3 etc)


% Birth1 = 33.3; %fixed Param %resident
% Birth2 = 33.3;
% Death1 = 18.5; %fixed Param %resident
% Alpha1 = 7.6;


Birth1 = 33.3; %fixed Param %resident
Birth2 = 33.3;
Death1 = 18.5; %fixed Param %resident
Alpha1 = 7.6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%InvType = 1; %Ursula ADDED CODE CONSTANT INVASION

InvType = 2 ;%Ursula ADDED CODE FUNCTION INVASION


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gamma =2.5; %fixed Param
            
StepSizeA = 1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 1;


Alpha2 = 8:StepSizeA:18; %Mesh for Birth  and Death params. 

%if part ==1
%Death2 = 0:StepSizeD:2; %I scale these linearly, but they can have any upper bound.
%elseif part>1
%Death2 = 2*part-2+StepSizeD:StepSizeD:2*part; %I scale these linearly, but they can have any upper bound.
%end

Death2 = 2*part:StepSizeD:2*part+2-StepSizeD;

La = length(Alpha2);
Ld = length(Death2);

%% Mutual Invasion Block
BoolMat1 = zeros(La,Ld);
BoolMat2 = zeros(La,Ld);
cflval = zeros(La,Ld);

BoolMat1Results = zeros(La,Ld);
BoolMat2Results = zeros(La,Ld);

parfor i = 1:La
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j),cflval(i,j)] = InvasionFunction(Birth1, Death1, Birth2, Death2(j), gamma, InvType,Alpha1,Alpha2(i));
        [BoolMat2(i,j),AcBoolMat2(i,j),cflval(i,j)] = InvasionFunction( Birth2, Death2(j), Birth1, Death1, gamma, InvType,Alpha2(i),Alpha1);        
    end
    xlswrite(BoolMat1Results,BoolMat1);
    xlswrite(BoolMat2Results,BoolMat2);
    xlswrite(AcBoolMat1Results,AcBoolMat1);
    xlswrite(AcBoolMat2Results,AcBoolMat2);
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
%figure()
%surf(Death2,Alpha2,BoolMat1)
%title('n_i invades n_j')
%xlabel('mu_i')
%ylabel('\alpha_i')
%view(0,90)

%figure()
%surf(Death2,Alpha2,BoolMat2)
%title('n_j invades n_i')
%xlabel('mu_i')
%ylabel('\alpha_i')
%view(0,90)

%fig1 = figure()
%surf(Death2,Alpha2,MutInvadeMat)
%title('Mutual Invasion')
%xlabel('mu_i')
%ylabel('\alpha_i')
%view(0,90)


%fig2 =figure()
%surf(Death2,Alpha2,MutInvadeMat)
%hold on
%surf(Death2,Alpha2,MutInvadeMatAc)
%title('Mutual Invasion and Critical Age Cond')
%xlabel('mu_i')
%ylabel('\alpha_i')
%view(0,90)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
            if InvType ==1
                 xlswrite(sprintf('OG_Na_RichEx_Matrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 xlswrite(sprintf('OG_Na_RichEx_Matrix2_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 xlswrite(sprintf('OG_Na_RichEx_MutInvadeMatrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 xlswrite(sprintf('OG_Na_RichEx_MutInvadeMatrix-w_Ac_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 xlswrite(sprintf('OG_Na_RichEx_Alpha2_Cons_muj_%g_aj_%g_g_%g.csv',Death1,Alpha1,gamma),Alpha2)
                 xlswrite(sprintf('OG_Na_RichEx_Death2_Cons_muj_%g_aj_%g_g_%g_part_%g.csv',Death1,Alpha1,gamma,part),Death2)
            
            elseif InvType ==2
 
                 %func eps
                 xlswrite(sprintf('OG_Na_RichEx_Matrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 xlswrite(sprintf('OG_Na_RichEx_Matrix2_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 xlswrite(sprintf('OG_Na_RichEx_MutInvadeMatrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 xlswrite(sprintf('OG_Na_RichEx_MutInvadeMatrix-w-Ac_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 xlswrite(sprintf('OG_Na_RichEx_Alpha2_Func_muj_%g_alphaj_%g_g_%g.csv',Death1,Alpha1,gamma),Alpha2)
                 xlswrite(sprintf('OG_Na_RichEx_Death2_Func_muj_%g_alphaj_%g_g_%g_part_%g.csv',Death1,Alpha1,gamma,part),Death2)
            end
          
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Saving Mutual Invasion Fig START         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %if InvType ==1
                %     saveas(fig1,sprintf('MutualCoexRegConsEps_muj_%g_aj_%g_Parallel_%g_mesh_DD_Seed.png',Birth1,Alpha1,StepSizeD))
                %elseif InvType==2
                %     saveas(fig1,sprintf('MutualCoexRegFuncEps_muj_%g_aj_%g_Parallel_%g_mesh_DD_Seed.png',Birth1,Alpha1,StepSizeD))
                %end
                
            %    if InvType ==1
            %         saveas(fig2,sprintf('MutualCoexRegConsEps-w-Ac_muj_%g_aj_%g_Parallel_%g_mesh_DD_Seed.png',Birth1,Alpha1,StepSizeD))
            %    elseif InvType==2
            %         saveas(fig2,sprintf('MutualCoexRegFuncEps-w-Ac_muj_%g_aj_%g_Parallel_%g_mesh_DD_Seed.png',Birth1,Alpha1,StepSizeD))
            %    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Saving Mutual Invasion Fig end          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeD)
fprintf('%f\n',InvType)
fprintf('%g cfl val\n',cflval(1,1))

toc
exit;

% load train
% sound(y,Fs)