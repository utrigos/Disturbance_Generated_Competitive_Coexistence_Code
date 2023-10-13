tic

f = datetime('now');
disp(f);



for part = 3:5


Birth1 = 33.3; %fixed Param %resident
Birth2 = 33.3;
Death1 = 18.5; %fixed Param %resident
Alpha1 = 7.6;


InvType = 2; %Invasion type


gamma =2.5; %fixed Param
            
StepSizeA = .1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = .1;


Alpha2 = 15:StepSizeA:22; %Mesh for Birth       and Death params. 

if part ==1
Death2 = 0:StepSizeD:2; %I scale these linearly, but they can have any upper bound.
elseif part>1
Death2 = 2*part-2+StepSizeD:StepSizeD:2*part; %I scale these linearly, but they can have any upper bound.
end

La = length(Alpha2);
Ld = length(Death2);

%% Mutual Invasion Block
BoolMat1 = zeros(La,Ld);
BoolMat2 = zeros(La,Ld);

parfor i = 1:La
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j)] = InvasionFunction(Birth1, Death1, Birth2, Death2(j), gamma, InvType,Alpha1,Alpha2(i));
        [BoolMat2(i,j),AcBoolMat2(i,j)] = InvasionFunction( Birth2, Death2(j), Birth1, Death1, gamma, InvType,Alpha2(i),Alpha1);        
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





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
            if InvType ==1
                 xlswrite(sprintf('Matrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 xlswrite(sprintf('Matrix2_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 xlswrite(sprintf('MutInvadeMatrix_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 xlswrite(sprintf('MutInvadeMatrix-w_Ac_Cons_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 xlswrite(sprintf('Alpha2_Cons_muj_%g_aj_%g_g_%g.csv',Death1,Alpha1,gamma),Alpha2)
                 xlswrite(sprintf('Death2_Cons_muj_%g_aj_%g_g_%g_part_%g.csv',Death1,Alpha1,gamma,part),Death2)
            
            elseif InvType ==2
 
                 %func eps
                 xlswrite(sprintf('Matrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat1)
                 xlswrite(sprintf('Matrix2_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),BoolMat2)
                 xlswrite(sprintf('MutInvadeMatrix_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMat)
                 xlswrite(sprintf('MutInvadeMatrix-w-Ac_Func_muj_%g_bj_%g_g_%g_aj_%g_part_%g.csv',Death1,Birth1,gamma,Alpha1,part),MutInvadeMatAc)
                 
                 xlswrite(sprintf('Alpha2_Func_muj_%g_alphaj_%g_g_%g.csv',Death1,Alpha1,gamma),Alpha2)
                 xlswrite(sprintf('Death2_Func_muj_%g_alphaj_%g_g_%g_part_%g.csv',Death1,Alpha1,gamma,part),Death2)
            end
          
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeD)
fprintf('%f\n',InvType)

toc

end
