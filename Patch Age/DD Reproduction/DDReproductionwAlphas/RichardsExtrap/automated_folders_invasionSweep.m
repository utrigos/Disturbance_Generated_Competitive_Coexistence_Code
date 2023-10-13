tic

f = datetime('now');
disp(f);

for partA = 12:0.1:12.1
for job = 1:1
    
    part = job*.1;
    partM = part+2.4; 

% part =str2double(getenv('SLURM_ARRAY_TASK_ID'));  %the last number of the array (1,2,3 etc)

Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
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
            
StepSizeA = 0.1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 0.1;


if partM ==2.5
        Death2 = 2.5:StepSizeD:2.5+job/5-StepSizeD;
    elseif partM>2.5
        Death2 = 2.5+(job/5-0.2):StepSizeD:2.5+job/5-StepSizeD;
    end
    
if rem(partA*10,2)==0
        Alpha2 = partA:StepSizeA:partA+StepSizeA;
    else
        continue
    end

La = length(Alpha2);
Ld = length(Death2);

%% Mutual Invasion Block
BoolMat1 = zeros(La,Ld);
BoolMat2 = zeros(La,Ld);
cflval = zeros(La,Ld);

parfor i = 1:La
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j),cflval(i,j)] = InvasionFunction(Birth1, Death1, Birth2, Death2(j),gamma,InvType,Alpha1,Alpha2(i));
        [BoolMat2(i,j),AcBoolMat2(i,j),cflval(i,j)] = InvasionFunction(Birth2, Death2(j), Birth1, Death1,gamma,InvType,Alpha2(i),Alpha1);        
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

 AlphabetIndex = round((partA-12)*10)/2+1;
 FolName = Alphabet(AlphabetIndex);

 folder_string = sprintf("%s%d",FolName,job);
    
 mkdir(folder_string)

        
         %___________________transferring data into a CSV file________________________
            
            if InvType ==1
                 csvwrite(sprintf('%s_16Na_RichEx_Matrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 csvwrite(sprintf('%s_16Na_RichEx_Matrix2_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 csvwrite(sprintf('%s_16Na_RichEx_MutInvadeMatrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 csvwrite(sprintf('%s_16Na_RichEx_MutInvadeMatrix-w_Ac_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 csvwrite(sprintf('%s_16Na_RichEx_Alpha2_Cons_muj_%g_aj_%g_g_%g.csv',folder_string,Death1,Alpha1,gamma),Alpha2)
                 csvwrite(sprintf('%s_16Na_RichEx_Death2_Cons_muj_%g_aj_%g_g_%g_part_%g.csv',folder_string,Death1,Alpha1,gamma,part),Death2)
            
            elseif InvType ==2
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_Matrix_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(BoolMat1,file_name);
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_Matrix2_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(BoolMat2,file_name);
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_MutInvadeMat_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(MutInvadeMat,file_name);
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_MutInvadeMat-w-Ac_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(MutInvadeMatAc,file_name);
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_Alpha2_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(Alpha2,file_name);
            
            file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_Death2_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(Death2,file_name);
 
                 %func eps
                 %csvwrite(sprintf('L%g_16Na_RichEx_Matrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',part,Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 %csvwrite(sprintf('L%g_16Na_RichEx_Matrix2_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',part,Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 %csvwrite(sprintf('L%g_16Na_RichEx_MutInvadeMatrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',part,Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 %csvwrite(sprintf('L%g_16Na_RichEx_MutInvadeMatrix-w-Ac_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',part,Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 %csvwrite(sprintf('L%g_16Na_RichEx_Alpha2_Func_muj_%g_alphaj_%g_g_%g.csv',part,Death1,Alpha1,gamma),Alpha2)
                 %csvwrite(sprintf('L%g_16Na_RichEx_Death2_Func_muj_%g_alphaj_%g_g_%g_part_%g.csv',part,Death1,Alpha1,gamma,part),Death2)
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

end
end

toc
exit;

% load train
% sound(y,Fs)