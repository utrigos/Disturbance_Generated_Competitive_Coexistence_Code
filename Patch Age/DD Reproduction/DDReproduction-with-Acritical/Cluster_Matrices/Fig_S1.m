tic
            %___________________reading data from a CSV file________________________
for mycount= 5:8
% mycount = 6;

StepSizeB =0.1;
gamma =1;

             %________PARAMETER (a)______%
             if mycount ==1
                Birth1 = 2.34; %resident
                Death1 = 0.4;   %resident
    
                Matrix = readmatrix('Matrix_Cons_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_0.4_bj_2.34_mesh_0.1.csv');
                MutInvMatAc = readmatrix('AcMat_Cons_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                InvType = 1;

             elseif mycount ==5
                Birth1 = 2.34; %resident
                Death1 = 0.4;   %resident
                Matrix = readmatrix('Matrix_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                MutInvMatAc = readmatrix('AcMat_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Func_muj_0.4_bj_2.34_mesh_0.1_DD_Seed.csv');
                InvType = 2;
            %________PARAMETER (a)_______%

            % % %________PARAMETER (b)______%
             elseif mycount ==2
                Birth1 = 5.6; %resident
                Death1 = 1;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_1_bj_5.6_mesh_0.1.csv');
                MutInvMatAc = readmatrix('AcMat_Cons_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                InvType = 1;

             elseif mycount ==6
                Birth1 = 5.6; %resident
                Death1 = 1;   %resident
                Matrix = readmatrix('Matrix_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                MutInvMatAc = readmatrix('AcMat_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Func_muj_1_bj_5.6_mesh_0.1_DD_Seed.csv');
                InvType = 2;
            % % %________PARAMETER (b)_______%

            % %________PARAMETER (c)______%  
             elseif mycount==3
                Birth1 = 6.8; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_2_bj_6.8_mesh_0.1.csv');
                MutInvMatAc = readmatrix('AcMat_Cons_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                InvType = 1;

             elseif mycount ==7
                Birth1 = 6.8; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                MutInvMatAc = readmatrix('AcMat_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Func_muj_2_bj_6.8_mesh_0.1_DD_Seed.csv');
                InvType = 2;       
            % %________PARAMETER (c)_______%

            % %________PARAMETER (d)______%    
             elseif mycount==4
                Birth1 = 9; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_2_bj_9_mesh_0.1.csv');
                MutInvMatAc = readmatrix('AcMat_Cons_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_2_bj_9_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                InvType = 1;
             elseif mycount==8
                Birth1 = 9; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                MutInvMatAc = readmatrix('AcMat_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                Birth2 = readmatrix('Birth2_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv'); 
                Death2 = readmatrix('Death2_Func_muj_2_bj_9_mesh_0.1_DD_Seed.csv');
                InvType = 2;
             end
            % %________PARAMETER (d)_______%
    


            %___________________reading data from a CSV file________________________

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

    SpI = Sij.*ineq3;
    SpI(SpI==0)=NaN;


    SpJ = Sji.*ineq3;
    SpJ(SpJ==0)=NaN;


%-----------------This is the Main Plot We Are Interested In----------- 

fig = figure();
% 

%% One Species critical conditions
% surf(m,b,CritCondition,'DisplayName','crit cond 1 sp','EdgeColor','none','FaceColor', 'g','FaceAlpha',0.2,'EdgeAlpha',0)
%      hold on 
%%    
h = gobjects(3, 1);

% if InvType ==1
%     %surf(Death2,Birth2,MutInvMat, 'DisplayName', 'Coex Region with Cons \epsilon')
%     surf(Death2,Birth2,MutInvMatAc, 'DisplayName', 'Positive Reproduction','EdgeColor','none','FaceColor', '[0 0.4470 0.7410]','FaceAlpha',0.3)
%         hold on;
%     %surf(m,b,Condition,'DisplayName','cons \epsilon theor','EdgeColor','none','FaceColor', 'b','FaceAlpha',0.3,'EdgeAlpha',0.5)
%     %    hold on;
%     surf(m,b,feas,'DisplayName','Analytical Mutual Invasion','EdgeColor', 'none', 'FaceColor','[0.6350 0.0780 0.1840]','FaceAlpha',0.9,'EdgeAlpha',1)
%          hold on
% elseif InvType ==2
 h(1) = surf(Death2,Birth2,MutInvMatAc, 'DisplayName', 'Positive Reproduction','EdgeColor','none','FaceColor', '[0.4660 0.6740 0.1880]','FaceAlpha',0.3);
hold on
  h(2)=  surf(m,b,feas,'DisplayName','Analytical Coexistence','EdgeColor', 'k', 'FaceColor','k','FaceAlpha',0.5,'EdgeAlpha',0.5);
         hold on
 h(3)=   surf(Death2,Birth2, MutInvMat, 'DisplayName', 'Numerical Coexistence','EdgeColor','[0, 0.4470, 0.7410]','FaceColor','[0 0.4470 0.7410]','FaceAlpha',1,'EdgeAlpha',1);
% end


%%
xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Reproduction $r_i$','FontSize',20,'Interpreter', 'latex')
view(0,90)


hold on;
 % %line for mui at muj
 x = [Death1,Death1];
 y = [Birth1, 30];

 
h(4) =plot(x,y,'--','color','k','DisplayName','$r_i=r_j$, $m_i=m_j$','LineWidth',1.5);
 
 hold on 
 
 %line for bi = bj
 x1 = [Death1, 8];
 y1 = [Birth1, Birth1];

 
 plot(x1,y1,'--','color','k','HandleVisibility','off','LineWidth',1.5);

 axis([Death1-.2 8+.05 Birth1-.45 30])
 
legend(h([2 3 1 4]),'Location','northeast','FontSize',20,'Interpreter', 'latex')
    set(gca,'fontname','Helvetica')


    hold on
    
    grid on
    view(0,90)
    
    hold off



toc;
end
