Birth1 = 33.3; %fixed Param %resident
Birth2 = 33.3;
Death1 = 18.5; %fixed Param %resident
Alpha1 = 7.6;
gamma = 2.5;

BoolMat1 = [1,1;1,1];


Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

for partA = 12:0.1:12.6
for job = 1:18
    
    part = job*.1;
    partM = part+2.4; 

    StepSizeA = 0.1;
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


%     disp(Death2)
%     disp(Alpha2)

    AlphabetIndex = round((partA-12)*10)/2+1;
    FolName = Alphabet(AlphabetIndex);


    folder_string = sprintf("%s%d",FolName,job);
    
        fprintf('alpha2 %f,job %g,FolName %s, folder_string %s \n \n',partA,job,FolName,folder_string);
    
%     disp(folder_string)
%     fprintf('%s %f %f \n \n',folder_string,partA,job)


    mkdir(folder_string)

    file_name = fullfile(folder_string,sprintf('%s_16Na_RichEx_Matrix_Func_muj_%g_bj_%g_g_%g_aj_%g.csv',folder_string,Death1,Birth1,gamma,Alpha1));
            writematrix(BoolMat1,file_name);        

end
end