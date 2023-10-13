%tic

f = datetime('now');
disp(f);

mycount=8;

gamma =1; %fixed Param

    if mycount ==1 || mycount ==5
            %________PARAMETER (a)______%
            Birth1 = 15; %resident

            Death1 = 10;%resident
            Death2 = 10; 
            Alpha1 = 10;
            %________PARAMETER (a)_______%
            
    elseif mycount ==2 || mycount ==6        
            % % %________PARAMETER (b)______%
            Birth1 = 35; %resident

            Death1 = 12;   %resident
            Death2 = 12; 
            Alpha1 = 12;
            % % %________PARAMETER (b)_______%
            
    elseif mycount ==3 || mycount ==7        
            % %________PARAMETER (c)______%
            Birth1 = 35; %resident
            Birth2 = 35;

            Death1 = 16;   %resident
            Death2 = 16;
            Alpha1 = 8;
            % %________PARAMETER (c)_______%
            
    elseif mycount ==4 || mycount ==8       
            % %________PARAMETER (d)______%
            Birth1 = 35; %resident
            Birth2 = 35;

            Death1 = 20;   %resident
            Death2 = 20;
            Alpha1 = 5;
            % %________PARAMETER (d)_______%
    end

if mycount <6
    InvType = 1;
elseif mycount > 5 
    InvType =2;
end

Part =1;

StepSizeA = 1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeB = 1;

Alpha2 = Alpha1:StepSizeA:Alpha2+15; %I scale these linearly, but they can have any upper bound.
Birth2 = Birth1:StepSizeB:Birth2+40; %I scale these linearly, but they can have any upper bound.


La = length(Alpha2);
Lb = length(Birth2);


BoolMat1 = zeros(La,Lb);
BoolMat2 = zeros(La,Lb);

CFLBoolMat1 = zeros(La,Lb);
CFLBoolMat2 = zeros(La,Lb);

parfor i = 1:La
    for j = 1:Lb
        [BoolMat1(i,j),CFLBoolMat1(i,j)] = InvasionFunction(Birth1, Death1, Birth2(j), Death2, gamma, InvType,Alpha1,Alpha2(i));
        [BoolMat2(i,j),CFLBoolMat2(i,j)] = InvasionFunction(Birth2(j), Death2, Birth1, Death1, gamma, InvType,Alpha2(i),Alpha1);         
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
surf(Birth2,Alpha2,BoolMat1)
title('n_i invades n_j')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

figure()
surf(Birth2,Alpha2,BoolMat2)
title('n_j invades n_i')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

figure()
surf(Birth2,Alpha2,MutInvadeMat)
title('Mutual Invasion')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
           if InvType ==1
                xlswrite(sprintf('Matrix_Cons_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),BoolMat1)
                xlswrite(sprintf('Matrix2_Cons_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),BoolMat2)
                xlswrite(sprintf('MutInvadeMatrix_Cons_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),MutInvadeMat)
                 xlswrite(sprintf('CFLMat_Cons_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),CFLBoolMat1)
                
                xlswrite(sprintf('Birth2_Cons_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),Birth2)
                xlswrite(sprintf('Death2_Cons_bj_%g_bj_%g.csv',Birth1,Alpha1),Death2)
           
           elseif InvType ==2

                %func eps
                 xlswrite(sprintf('Matrix_Func_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),BoolMat1)
                xlswrite(sprintf('Matrix2_Func_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),BoolMat2)
                xlswrite(sprintf('MutInvadeMatrix_Func_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),MutInvadeMat)
                 xlswrite(sprintf('CFLMat_Func_bj_%g_bj_%g_Part_%g.csv',Birth1,Alpha1,Part),CFLBoolMat1)
                
                xlswrite(sprintf('Birth2_Func_bj_%g_bj_%g_Part_%g.csv',Birth1,Birth1,Part),Birth2)
                xlswrite(sprintf('Death2_Func_bj_%g_bj_%g.csv',Birth1,Birth1),Death2)
           end
         
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f = datetime('now');
disp(f);

fprintf('%g mesh\n',StepSizeA)
fprintf('%g\n',InvType)
fprintf('%g cfl val\n',CFLBoolMat1(1,1))
