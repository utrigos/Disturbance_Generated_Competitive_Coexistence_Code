tic

f = datetime('now');
disp(f);


%______________________POOL SETUP____________________________
%NP = 1;    %LOCAL PARALLEL POOL

%%%%  Initialize the Umich Cluster profiles   %POOL FROM JOB
setupUmichClusters

%%%%  We get from the environment the number of processors     %POOL FROM JOB
% NP = str2num(getenv('SLURM_NTASKS'));
NP = 8;

thePool = parpool('local', NP); %to start parallel pool
%______________________POOL SETUP____________________________

Part =str2double(getenv('SLURM_ARRAY_TASK_ID'));  %the last number of the array (1,2,3 etc)

mycount = 6;

    if mycount ==1 || mycount ==5
            %________PARAMETER (a)______%
            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            Death2 = 0.4;
            Alpha1 = 0.2; 
            %________PARAMETER (a)_______%
            
    elseif mycount ==2 || mycount ==6        
            % % %________PARAMETER (b)______%
            Birth1 = 5; %resident
            Death1 = 1;   %resident
            Death2 = 1;   %resident
            Alpha1 = 0.2;
            % % %________PARAMETER (b)_______%
            
    elseif mycount ==3 || mycount ==7        
            % %________PARAMETER (c)______%
             Birth1 = 6.8; %resident
             Death1 = 2;   %resident
             Death2 = 2;   %resident
             Alpha1 = 0.2;
            % %________PARAMETER (c)_______%
            
    elseif mycount ==4 || mycount ==8        
            % %________PARAMETER (d)______%
             Birth1 = 9; %resident
             Death1 = 2;   %resident
             Death2 = 2;   %resident
             Alpha1 = 0.2;
            % %________PARAMETER (d)_______%
    end

if mycount <5
    InvType = 1;
elseif mycount > 4
    InvType =2;
end

gamma =0.5; %fixed Param

StepSizeB = 0.005; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 0.1;
StepSizeA = 0.005;

disp(sprintf('%g reproduction',Birth1))
disp(sprintf('%g mortality',Death1))
disp(sprintf('%g mesh',StepSizeB))
disp(sprintf('%f invasion type', InvType))

alphaend = Alpha1 +.15;
%birthend = Birth1+40;

if Part ==1
    Birth2 = Birth1:StepSizeB:Birth1+10; %Mesh for Birth and Death params.
elseif Part >1
    Birth2 = Birth1+(Part-1)*10+StepSizeB:StepSizeB:Birth1+Part*10
end
    
%Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.
Alpha2 = Alpha1:StepSizeA:alphaend; %Mesh 


Lb = length(Birth2);
%Ld = length(Death2);
La = length(Alpha2);

BoolMat1 = zeros(La,Lb);
BoolMat2 = zeros(La,Lb);
cflval = zeros(La, Lb);
AcBoolMat1=zeros(La,Lb);
AcBoolMat2=zeros(La,Lb);

parfor i = 1:La
    for j = 1:Lb
        %[BoolMat1(i,j),AcBoolMat1(i,j),cflval(i,j)] = InvasionFunction(Birth1, Death1, Birth2(i), Death2(j), gamma, InvType,Alpha1,Alpha2); % varying birth and death
        %[BoolMat2(i,j),AcBoolMat2(i,j),cflval(i,j)] = InvasionFunction( Birth2(i), Death2(j), Birth1, Death1, gamma, InvType,Alpha1,Alpha2);%varying birth and death
        
        [BoolMat1(i,j),AcBoolMat1(i,j),cflval(i,j)] = InvasionFunction(Birth1, Death1, Birth2(j), Death2, gamma, InvType,Alpha1,Alpha2(i)); % varying birth and alpha
        [BoolMat2(i,j),AcBoolMat2(i,j),cflval(i,j)] = InvasionFunction(Birth2(j),Death2, Birth1, Death1, gamma, InvType,Alpha2(i),Alpha1);%varying birth and alpha
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

%%
    
%_______________________________________________________________________________________
%_______________________________________________________________________________________

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


FolName = sprintf('DDOS_Gamma_%g_Alphaj_%g_Birthj_%g',gamma,Alpha1,Birth1);

 folder_string = sprintf("%s%d",FolName);
    
 mkdir(folder_string)
        
         %___________________transferring data into a CSV file________________________
            
            if InvType == 1
                xlswrite(sprintf('Matrix_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat1)
                xlswrite(sprintf('Matrix2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),BoolMat2)
                xlswrite(sprintf('MutInvadeMatrix_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),MutInvadeMat)
                
                xlswrite(sprintf('Birth2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Birth2)
                xlswrite(sprintf('Death2_Cons_muj_%g_bj_%g_mesh_%g_DD_REC.csv',Death1,Birth1,StepSizeB),Death2)
            elseif InvType ==2
               file_name = fullfile(folder_string,sprintf('Matrix_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1,Part));
                    writematrix(BoolMat1,file_name);
               file_name = fullfile(folder_string,sprintf('Matrix2_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1,Part));
                    writematrix(BoolMat2,file_name);
               file_name = fullfile(folder_string,sprintf('MutInvadeMatrix_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1,Part));
                    writematrix(MutInvadeMat,file_name);
               file_name = fullfile(folder_string,sprintf('MutInvadeMatrix_Ac_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1,Part));
                    writematrix(MutInvadeMatAc,file_name);
               file_name = fullfile(folder_string,sprintf('Birth2_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1,Part));
                    writematrix(Birth2,file_name);
               file_name = fullfile(folder_string,sprintf('Alpha2_Func_bj_%g_aj_%g_gamma_%g_muj_%g_Part_%g.csv',Birth1,Alpha1,gamma,Death1));
                    writematrix(Alpha2,file_name);
            end
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


delete(thePool) %to end parallel pool

f = datetime('now');
disp(f);

disp(sprintf('%g reproduction',Birth1))
%disp(sprintf('%g mortality',Death1))
disp(sprintf('%g alpha j', Alpha1))
disp(sprintf('%g mesh',StepSizeA))
disp(sprintf('%f invasion type', InvType))


toc

exit