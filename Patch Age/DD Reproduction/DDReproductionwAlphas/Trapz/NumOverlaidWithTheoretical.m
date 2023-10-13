%Numerical Coex Region overlaid with Theoretical Coexistence Region.
tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                       NUMERICAL COEXISTENCE CODE                     %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = 2;

    if F ==1 || F==5
        %________PARAMETER (a)______%
%            B2 = 10.6; %invader
%            D2 = 6;  %invader

            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            %________PARAMETER (a)_______%
    elseif F==2 || F==6
            % % %________PARAMETER (b)______%
%              B2 = 18; %invader
%              D2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident
            % % %________PARAMETER (b)_______%
    elseif F==3 || F==7
            % %________PARAMETER (c)______%
%             B2 = 17; %invader
%             D2 = 7;  %invader
%              
            Birth1 = 6.8; %resident
            Death1 = 2;   %resident
            % %________PARAMETER (c)_______%
    elseif F==4 || F==8
            % %________PARAMETER (d)______%
%             B2 = 21; %invader
%             D2 = 7;  %invader
            
            Birth1 = 9; %resident
            Death1 = 2;   %resident
            % %________PARAMETER (d)_______%
    
    end

% Birth1 = 2.34; %fixed Param %resident
% Death1 = 0.4; %fixed Param %resident

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if F <5
    InvType = 1; %Ursula ADDED CODE CONSTANT INVASION
elseif F > 4
    InvType = 2; %Ursula ADDED CODE FUNCTION INVASION
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%URSULA ADDED CODE START%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gamma =1; %fixed Param

StepSizeB = 0.2; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 0.2;


Birth2 = Birth1:StepSizeB:30; %Mesh for Birth       and Death params. 
Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                     THEORETICAL COEXISTENCE CODE                     %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    meshsize = 0.01;
    g=gamma;
    
    % %-------Param 0 ----------------
    bj=Birth1; 
    muj=Death1;
    
    %define the range of x (deltai),y (betai) coordinates
    
    % mui=muj:.1*meshsize:8;
    % bi=bj:.36587*meshsize:30;
    
    mui=muj:meshsize:8;
    bi=bj:meshsize:30;
    
    
    %Making a Matrix of Beta_i and Delta_i values
    [b,m] = meshgrid(bi,mui);
    
    
    %-------start feasbility ----------------
    Sij= b > (2*bj.*(m+g).*(g+muj).*(m+g+muj))./(bj.*g.*(m-muj)+(g+muj).*(m+2*g+muj).*(g+2*muj));
    Sji= b < (bj.*(m+g).*(2*m+g).*(m+2*g+muj))./(bj.*g.*(m-muj)+2.*(m+g).*(g+muj).*(m+g+muj));
    
     feas = Sij.*Sji;
     feas(feas==0) = NaN;
    
    %-------end feasibiltity----------------
    
    %-------start Rvals ----------------
    
    ineq3 = 1<2;
    
    % ----constant epsilon----
      Rij = ((1/2).*b.^(-1).*(g+m).^(-1).*(2.*b.*(g+m)+(-1).*(b+(-1).*g+(-1).*m).*(g+2.*m)))>(bj.^(-1).*(g+muj));
      Rji = ((1/2).*bj.^(-1).*(g+muj).^(-1).*(2.*bj.*(g+muj)+(-1).*(bj+(-1).*g+(-1).*muj).*(g+2.*muj)))>(b.^(-1).*(g+m));
    % ----constant epsilon----
    
     % -----epsilon(a)-------
     Ri =(bj+(-1).*g+(-1).*muj+(-1/2).*b.^(-1).*bj.*(b+(-1).*g+(-1).*m).*(g+m).^(-1).*(g+2.*m).*(g+m+muj).^(-1).*(2.*g+m+muj))>(0);
     Rj = (b+(-1).*g+(-1).*m+(-1/2).*b.*bj.^(-1).*(bj+(-1).*g+(-1).*muj).*(g+muj).^(-1).*(g+m+muj).^(-1).*(2.*g+m+muj).*(g+2.*muj))>(0);
    % ------epsilon(a)-----
    
    %-----crit condition-----
    
    aci = (1+(-2).*m.*(g+2.*m).^(-1).*b.*((-1).*g+(-1).*m+b).^(-1))<=(0);
    acj = (1+(-2).*bj.*(bj+(-1).*g+(-1).*muj).^(-1).*muj.*(g+2.*muj).^(-1))<=(0);
    
    %-----crit condition-----
    
    Condition = Rij.*Rji;
    Condition(Condition==0)=NaN;
    
    Condition1 = Ri.*Rj;
    Condition1(Condition1==0)=NaN;
    
    CritCondition = aci.*acj;
    CritCondition(CritCondition==0)=NaN;
    
    
    %---------------------------------------------------------comparing epsilon-------------------------------------------------
    % surf(m,b,CritCondition,'DisplayName','crit cond','EdgeColor','none','FaceColor', 'g','FaceAlpha',0.2,'EdgeAlpha',0)
    %      hold on 
    %
     %----Func(Eps)-----
    % surf(m,b,Condition1,'DisplayName','\epsilon(a)','EdgeColor','none','FaceColor', 'r	','FaceAlpha',0.3)
    %    hold on
     %---- Constant Epsilon-----
%     surf(m,b,Condition,'DisplayName','cons \epsilon','EdgeColor','none','FaceColor', 'b','FaceAlpha',0.3)
%     hold on;
     %------feasibility
%     surf(m,b,feas,'DisplayName','feas','EdgeColor', 'none', 'FaceColor','[0.75, 0, 0.75]','FaceAlpha',0.3)
     surf(m,b,feas,'DisplayName','Theoretical Mutual Invasion','EdgeColor', 'none', 'FaceColor','[0.75, 0, 0.75]','FaceAlpha',0.3)
         
    hold on
    %---------------------------------------------------------comparing epsilon-------------------------------------------------
    
    
    set(gca,'fontname','times')
    
    view(0,90)
    
    hold on 
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                     THEORETICAL COEXISTENCE CODE END                                 %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

Lb = length(Birth2);
Ld = length(Death2);

BoolMat1 = zeros(Lb,Ld);
BoolMat2 = zeros(Lb,Ld);

parfor i = 1:Lb
    for j = 1:Ld
        BoolMat1(i,j) = InvasionFunction(Birth1, Death1, Birth2(i), Death2(j), gamma, InvType);
        BoolMat2(i,j) = InvasionFunction( Birth2(i), Death2(j), Birth1, Death1, gamma, InvType);        
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

fig1 = figure();
surf(Death2,Birth2,MutInvadeMat)
title('Mutual Invasion')
xlabel('mu_i')
ylabel('b_i')
view(0,90)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices start            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         %___________________transferring data into a CSV file________________________
            
%            if InvType ==1
%                 xlswrite(sprintf('Matrix_Cons_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat1)
%                 xlswrite(sprintf('Matrix2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat2)
%                 xlswrite(sprintf('MutInvadeMatrix_Cons_muj_%g_bj_%g.csv',Death1,Birth1),MutInvadeMat)
%                 
%                 xlswrite(sprintf('Birth2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),Birth2)
%                 xlswrite(sprintf('Death2_Cons_muj_%g_bj_%g.csv',Death1,Birth1),Death2)
%            
%            elseif InvType ==2
% 
%                 %func eps
%                  xlswrite(sprintf('Matrix_Func_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat1)
%                 xlswrite(sprintf('Matrix2_Func_muj_%g_bj_%g.csv',Death1,Birth1),BoolMat2)
%                 xlswrite(sprintf('MutInvadeMatrix_Func_muj_%g_bj_%g.csv',Death1,Birth1),MutInvadeMat)
%                 
%                 xlswrite(sprintf('Birth2_Func_muj_%g_bj_%g.csv',Death1,Birth1),Birth2)
%                 xlswrite(sprintf('Death2_Func_muj_%g_bj_%g.csv',Death1,Birth1),Death2)
%            end
         
        %___________________transferring data into a CSV file________________________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Saving Matrices end             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% f = datetime('now');
% disp(f);

% toc

% load train
% sound(y,Fs)
    
    %-----------------------Main Plot End------------------------------
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                  NUMERICAL COEXISTENCE CODE END                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    

    axis([muj-.2 8 bj-.2 30])
    
    
     hold on 
     
     legend show
    
%     if InvType ==1
%         str = sprintf('Coex Region w Cons %s ,  %s = %g , %s = %g .','\epsilon','\mu_j',Death1,'b_j',Birth1);
%     elseif InvType==2
%         str = sprintf('Coex Region %s (a) ,  %s = %g , %s = %g.','\epsilon','\mu_j',Death1,'b_j',Birth1);
%     end
%     title(str,'FontSize',16);
%     
%     if InvType==1
%         saveas(fig1,sprintf('NumVSTheoConsEps_Muj_%g_Bj_%g_mesh_%g.png',muj,bj,StepSizeB))
%     elseif InvType==2
%         saveas(fig1,sprintf('NumVSTheoFuncEps_Muj_%g_Bj_%g_mesh_%g.png',muj,bj,StepSizeB))
%     end

        str = sprintf('Mutual Invasion ,  %s = %g , %s = %g.','\mu_j',Death1,'b_j',Birth1);
    title(str,'FontSize',16);
    hold off;
    
clearvars;

f = datetime('now');
disp(f);

%load handel
load train
sound(y,Fs)

toc;
