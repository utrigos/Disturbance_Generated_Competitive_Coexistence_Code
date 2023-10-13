tic

f = datetime('now');
disp(f);


%______________________POOL SETUP____________________________
%NP = 1;    %LOCAL PARALLEL POOL

%%%%  Initialize the Umich Cluster profiles   %POOL FROM JOB
setupUmichClusters

%%%%  We get from the environment the number of processors     %POOL FROM JOB
NP = str2num(getenv('SLURM_NTASKS'));

thePool = parpool('local', NP); %to start parallel pool
%______________________POOL SETUP____________________________

mycount = 6;

Salpha1=1; %reproduction competition coefficient for resident
Salpha2=1; %reproduction competition coefficient for invader
Ralpha1=0; %offspring survival competition coefficient for resident
Ralpha2=0; %offspring survival competition coefficient for invader



    if mycount ==1 || mycount ==5
            %________PARAMETER (a)______%
            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            %________PARAMETER (a)_______%
            
    elseif mycount ==2 || mycount ==6        
            % % %________PARAMETER (b)______%
            Birth1 = 5.6; %resident
            Death1 = 1;   %resident
            % % %________PARAMETER (b)_______%
            
    elseif mycount ==3 || mycount ==7        
            % %________PARAMETER (c)______%
             Birth1 = 6.8; %resident
             Death1 = 2;   %resident
            % %________PARAMETER (c)_______%
            
    elseif mycount ==4 || mycount ==8        
            % %________PARAMETER (d)______%
             Birth1 = 9; %resident
             Death1 = 2;   %resident
            % %________PARAMETER (d)_______%
    end

if mycount <5
    InvType = 1;
elseif mycount > 4
    InvType =2;
end

gamma =1; %fixed Param

StepSizeB = 0.1; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 0.1;


disp(sprintf('%g reproduction',Birth1))
disp(sprintf('%g mortality',Death1))
disp(sprintf('%g mesh',StepSizeB))
disp(sprintf('%f invasion type', InvType))

Birth2 = Birth1:StepSizeB:30; %Mesh for Birth and Death params. 
Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.

Lb = length(Birth2);
Ld = length(Death2);

BoolMat1 = zeros(Lb,Ld);
BoolMat2 = zeros(Lb,Ld);
cflval = zeros(Lb,Ld);

parfor i = 1:Lb
    for j = 1:Ld
        [BoolMat1(i,j),AcBoolMat1(i,j),cflval(i,j)]  = InvasionFunction(Birth1, Death1, Birth2(i), Death2(j), gamma, InvType,Salpha1,Salpha2,Ralpha1,Ralpha2);
        [BoolMat2(i,j),AcBoolMat2(i,j),cflval(i,j)] = InvasionFunction( Birth2(i), Death2(j), Birth1, Death1, gamma, InvType,Salpha2,Salpha1,Ralpha2,Ralpha1);        
    end
end

MutInvadeMat = double(BoolMat1&BoolMat2);


    BoolMat1(BoolMat1 == 0) = NaN; 
    %    %BoolMat1(BoolMat1 ~= 1) = NaN; 
    
    BoolMat2(BoolMat2 ==0) = NaN;
    %     %BoolMat2(BoolMat2 ~= 1) = NaN; 
    
    MutInvadeMat(MutInvadeMat ==0) = NaN;
    %    %MutInvadeMat(MutInvadeMat ~=1) = NaN;
    
    
        %% Critical Age Block
MutInvadeMatAc = double(AcBoolMat1&AcBoolMat2);                             

    AcBoolMat1(AcBoolMat1 == 0) = NaN; 
    %BoolMat1(BoolMat1 ~=1) = NaN;            %yellow region where invader does not survive

    AcBoolMat2(AcBoolMat2 ==0) = NaN;
    %BoolMat2(BoolMat2 ~=1) = NaN;            %yellow region where invader does not survive

    MutInvadeMatAc(MutInvadeMatAc ==0) = NaN;
    %MutInvaderMat(MutInvaderMat ~=1) = NaN;   %yellow region where invader does not survive

    
%_______________________________________________________________________________________


fig1 = figure()
surf(Death2,Birth2,MutInvadeMat)
title('Mutual Invasion')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

axis([Death1-.2 8 Birth1-.2 30])
%_______________________________________________________________________________________

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
            if InvType == 1
                csvwrite(sprintf('Matrix_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat1)
                csvwrite(sprintf('Matrix2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat2)
                csvwrite(sprintf('MutInvadeMatrix_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),MutInvadeMat)
                
                csvwrite(sprintf('Birth2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Birth2)
                csvwrite(sprintf('Death2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Death2)
            elseif InvType ==2
                 csvwrite(sprintf('Matrix_Func_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat1)
                csvwrite(sprintf('Matrix2_Func_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat2)
                csvwrite(sprintf('MutInvadeMatrix_Func_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),MutInvadeMat)
                
                csvwrite(sprintf('Birth2_Func_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Birth2)
                csvwrite(sprintf('Death2_Func_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Death2)
            end
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Saving Mutual Invasion Fig START         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if InvType ==1
                     saveas(fig1,sprintf('MutualCoexRegConsEps_muj_%g_bj_%g_Parallel_%g_mesh_DD_REC.png',Birth1,Death1,StepSizeB))
                elseif InvType==2
                     saveas(fig1,sprintf('MutualCoexRegFuncEps_muj_%g_bj_%g_Parallel_%g_mesh_DD_REC.png',Birth1,Death1,StepSizeB))
                end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Saving Mutual Invasion Fig end          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete(thePool) %to end parallel pool

f = datetime('now');
disp(f);

fprintf('%g cfl val\n',cflval(1,1))


toc

exit