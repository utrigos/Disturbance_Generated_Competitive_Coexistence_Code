%Numerical Coex Region overlaid with Theoretical Coexistence Region.
tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                       NUMERICAL COEXISTENCE CODE                     %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = 5;

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

if F <5
    InvType = 1; 
elseif F > 4
    InvType = 2; 
end


gamma =1; %fixed Param

StepSizeB = 5; %This determine how many points are checked in the parameter sweep. Smaller = more points
StepSizeD = 5;


Birth2 = Birth1:StepSizeB:30; %Mesh for Birth       and Death params. 
Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                     ANALYTICAL COEXISTENCE CODE                     %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    meshsize = 0.01;
    g=gamma;
    
    % %-------Param 0 ----------------
    bj=Birth1; 
    muj=Death1;
    
    %define the range of x (mi),y (ri - birth - bi) coordinates
    
    % mui=muj:.1*meshsize:8;
    % bi=bj:.36587*meshsize:30;
    
    mui=muj:meshsize:8;
    bi=bj:meshsize:30;
    
    
    %Making a Matrix of b_i (r_i) and m_i values
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
    surf(m,b,CritCondition,'DisplayName','crit cond','EdgeColor','none','FaceColor', 'g','FaceAlpha',0.2,'EdgeAlpha',0)
         hold on 
    %
     %----Func(Eps)-----
    % surf(m,b,Condition1,'DisplayName','\epsilon(a)','EdgeColor','none','FaceColor', 'r	','FaceAlpha',0.3)
    %    hold on
     %---- Constant Epsilon-----
%     surf(m,b,Condition,'DisplayName','cons \epsilon','EdgeColor','none','FaceColor', 'b','FaceAlpha',0.3)
%     hold on;
     %------feasibility
%     surf(m,b,feas,'DisplayName','feas','EdgeColor', 'none', 'FaceColor','[0.75, 0, 0.75]','FaceAlpha',0.3)
%      surf(m,b,feas,'DisplayName','Theoretical Mutual Invasion','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',0.3)
%          
%     hold on
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


     surf(m,b,feas,'DisplayName','Theoretical Mutual Invasion','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',0.3)
         
    hold on

    
    %-----------------------Main Plot End------------------------------
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                  NUMERICAL COEXISTENCE CODE END                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%                                                                      %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    

    axis([muj-.2 8 bj-.2 30])
    
    
     hold on 
     
     legend show
    

        str = sprintf('Mutual Invasion ,  %s = %g , %s = %g.','\mu_j',Death1,'b_j',Birth1);
    title(str,'FontSize',20);
    hold off;



    set(gca,'fontname','times')

xlabel('m_i , mortality sp i','FontSize',20)
ylabel('r_i , reproduction sp i','FontSize',20)
view(0,90)
%%
hold on 

%line for mi at mj
x = [muj, 8];
y = [bj, bj];
z= [1,1];

plot3(x,y,z,'color','r','DisplayName','m_i=m_j & r_i=r_j');

hold on 

%line for ri = rj
x1 = [muj, muj];
y1 = [bj, 30+bj];
z1= [1,1];

plot3(x1,y1,z1,'color','r','HandleVisibility','off');
%%
legend('Location','northwest','FontSize',20)
hold on 

axis([muj-.05 8 bj-.2 30])
    
clearvars;

f = datetime('now');
disp(f);


toc;
