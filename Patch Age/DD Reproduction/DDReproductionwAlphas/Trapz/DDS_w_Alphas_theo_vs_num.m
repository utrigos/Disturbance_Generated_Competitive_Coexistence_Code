%mycount = 1; % Cons Eps for Numerical
mycount = 2; %Func Eps for Numerical

for g = 0:1:12

%% Theoretical
% meshsize = .009; %highest possible
meshsize = 0.01;
% g = 6;
muj=18.5;
aj=7.6;
bj=33.3;
bi=33.3;

%define range of alpha and mu values
alphaend = 22;
mustart =0;

alphai=aj:meshsize:alphaend;
mui=mustart:meshsize:muj;
%-------Param 3 ----------------


%Making a Matrix of Beta_i and Delta_i values
[m,a] = meshgrid(mui,alphai);
%[m,a,b] = meshgrid(mui,alphai,bi);


%%
%-------start feasbility ----------------
Sij= ((1/2).*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(bj+(-1).*g+(-1).*muj).*(g+muj).^(-1).*(g+m+muj).^(-1).*(2.*g+m+muj).*(g+2.*muj))<(a.^(-1).*aj);
%  original
Sji= (a.^(-1).*aj)<(2.*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(g+m).*(g+2.*m).^(-1).*(bj+(-1).*g+(-1).*muj).*(g+m+muj).*(2.*g+m+muj).^(-1)); 

feas = Sij.*Sji;
feas(feas==0) = NaN;

%-------end feasibiltity----------------
%%
Rij = (2.*a.^(-1).*aj.*bi.^(-1).*bj.*(bi+(-1).*g+(-1).*m).*(bj+(-1).*g+(-1).*muj).^(-1).*(g+muj).*(g+m+muj).*(2.*g+m+muj).^(-1).*(g+2.*muj).^(-1))>(1);

Rji = (2.*a.*aj.^(-1).*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(g+m).*(g+2.*m).^(-1).*(bj+(-1).*g+(-1).*muj).*(g+m+muj).*(2.*g+m+muj).^(-1))>(1);

inv = Rij.*Rji;
inv(inv==0) = NaN;
%%
%-------start Rvals ----------------

ineq3 = 1<2;

feasSi = Sij.*ineq3;
feasSi(feasSi==0)=NaN;

feasSj = Sji.*ineq3;
feasSj(feasSj==0)=NaN;

invRi = Rij.*ineq3;
invRi(invRi==0)=NaN;

invRj = Rji.*ineq3;
invRj(invRj==0)=NaN;

%-----One sp crit condition-----
aci = (1+(-2).*bi.*(bi+(-1).*g+(-1).*m).^(-1).*m.*(g+2.*m).^(-1))<=(0);
acj = (1+(-2).*bj.*(bj+(-1).*g+(-1).*muj).^(-1).*muj.*(g+2.*muj).^(-1))<=(0);
%-----One sp crit condition-----
%%

CritCondition = aci.*acj;
CritCondition(CritCondition==0)=NaN;

critSi = Sij.*CritCondition;
critSi(critSi==0)=NaN;

critSj = Sji.*CritCondition;
critSj(critSj==0)=NaN;

critFeas = feas.*CritCondition;
critFeas(critFeas==0)=NaN;

%%

fig1=figure();
%%
% %% 

% % 
% %%
% %
%  %------feasibility
%  surf(m,a,feas,'HandleVisibility','off','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',0.7)
%      hold on
      surf(m,a,feasSi,'DisplayName','Sp $i$ wins','EdgeColor', 'none', 'FaceColor','[0 0.4470 0.7410]','FaceAlpha',0.7)
     hold on
      surf(m,a,feasSj,'DisplayName','Sp $j$ wins','EdgeColor', 'none', 'FaceColor','[0.6350 0.0780 0.1840]','FaceAlpha',0.7)
     hold on
      surf(m,a,feas,'DisplayName','Coexistence','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',1)
%     hold on
%       surf(m,a,CritCondition,'DisplayName','Crit Cond','EdgeColor','none','FaceColor', '[0.27 0.72 0.2]','FaceAlpha',0.5,'EdgeAlpha',0)
%     
     
%% Figure for talk

%      surf(m,a,critSi,'DisplayName','Sp i invades','EdgeColor', 'none', 'FaceColor','[0, 0.4470, 0.7410]','FaceAlpha',0.5)
%      hold on
%       surf(m,a,critSj,'DisplayName','Sp j invades','EdgeColor', 'none', 'FaceColor','[0.9290, 0.6940, 0.1250]','FaceAlpha',0.5)
%      hold on
%       surf(m,a,critFeas,'DisplayName','Theo Mutual Inv','EdgeColor', 'none', 'FaceColor','[0.4940 0.1840 0.5560]','FaceAlpha',0.7)
     
%%

     %---------------------------------------------------------comparing epsilon-------------------------------------------------
%plot(6,10.5,'.')
%%

% hold on 

%-------end Rvals ----------------

%%
%changes font
set(gca,'fontname','times')
%endchanges font


xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Reproduction Competition Sensitivity $\alpha_i$','FontSize',20,'Interpreter', 'latex')
set(gca,'YAxisLocation','right')
view(0,90)
%%

hold on 

%-------Param 0 ----------------
%title('Invasion + Feas Conds (& critical value cond) \mu_j=0.4, b_j=2.34, \gamma=0.2.','FontSize',16)
%-------Param 0 ----------------

 axis([mustart muj+.5 aj-.5 alphaend])

%str = sprintf('Invasion & Feas Conds (and crit cond) when  %s = %g , %s = %g , %s = %g .','\mu_j',muj,'b_j',bj,'\gamma',g);
% str = sprintf('S_i_j and S_j_i>0 (and crit cond) when  %s = %g , %s = %g , %s = %g .','\mu_j',muj,'b_j',bj,'\gamma',g);
% str = sprintf('Theo & Num Mutual Inv w  %s = %g , %s = %g , %s = %g, %s = %g .','\mu_j',muj,'b_j',bj,'\gamma',g,'\alpha_j', aj);
str = sprintf('Density-Dependent Reproduction');
title(str,'FontSize',20,'Interpreter', 'latex');
%-------Param 0 ----------------
%% Theoretical End


% %% Numerical
% 
% 
% 
%              %________PARAMETER (a)______%
%              if mycount ==1
%                 Birth1 = bj; %fixed Param %resident
%                 Birth2 = bi;
%                 Death1 = muj; %fixed Param %resident
%                 Alpha1 = aj;
%     
%                 Matrix = readmatrix('Matrix_Cons_muj_18.5_bj_33.3.csv');
%                 Matrix2 = readmatrix('Matrix2_Cons_muj_18.5_bj_33.3.csv');
%                 MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_18.5_bj_33.3.csv');
%                 MutInvMatWAc = readmatrix('MutInvadeMatrix-w_Ac_Cons_muj_18.5_bj_33.3.csv');
%                 Alpha2 = readmatrix('Alpha2_Cons_muj_18.5_aj_7.6.csv'); 
%                 Death2 = readmatrix('Death2_Cons_muj_18.5_aj_7.6.csv');
%                 InvType = 1;
% 
%              elseif mycount ==5
%                 Birth1 = bj; %fixed Param %resident
%                 Birth2 = bi;
%                 Death1 = muj; %fixed Param %resident
%                 Alpha1 = aj;
% 
%                 Matrix = readmatrix('Matrix_Func_muj_18.5_bj_33.3.csv');
%                 Matrix2 = readmatrix('Matrix2_Func_muj_18.5_bj_33.3.csv');
%                 MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_18.5_bj_33.3.csv');
%                 MutInvMatWAc = readmatrix('MutInvadeMatrix-w-Ac_Func_muj_18.5_bj_33.3.csv');
%                 Alpha2 = readmatrix('Alpha2_Func_muj_18.5_alphaj_7.6.csv'); 
%                 Death2 = readmatrix('Death2_Func_muj_18.5_alphaj_7.6.csv');
%                 InvType = 2;
%             %________PARAMETER (a)_______%
%              end
% 
% % surf(Death2,Alpha2,Matrix,'DisplayName','Num - Sp i','EdgeColor','k','FaceColor', 'r','FaceAlpha',.5,'EdgeAlpha',.7)
% % hold on
% % 
% % surf(Death2,Alpha2,Matrix2,'DisplayName','Num - Sp j','EdgeColor','k','FaceColor', 'b','FaceAlpha',1,'EdgeAlpha',0.7)
% % hold on
% 
% surf(Death2,Alpha2,MutInvMat,'DisplayName','Num - Invasion','EdgeColor', 'none', 'FaceColor','[0.8500 0.3250 0.0980]','FaceAlpha',1)
% % hold on
% 
% % surf(Death2,Alpha2,MutInvMatWAc,'DisplayName','Num - Critical Con','FaceColor', '[0.27 0.72 0.2]','FaceAlpha',0.5,'EdgeAlpha',0)
% 
% 
% %% Numerical End



%saveas(fig1,sprintf('AnaInvFuncCoexReg_Muj_%g_Bj_%g.png',muj,bj))
saveas(fig1,sprintf('Theo_and_Num_DD_Seed_w_Alphas_Muj_%g_Bj_%g_All.png',muj,bj))
% saveas(fig1,sprintf('AnaInvConsCoexReg_Muj_%g_Bj_%g.png',muj,bj))
%saveas(fig1,sprintf('AnaInvConsEpsCoexReg_Muj_%g_Bj_%g_All.png',muj,bj))
%saveas(fig1,sprintf('FuncEps_Muj_%g_Bj_%g.png',muj,bj))


hold on 

%line for deli at delj
x = [0,muj];
y = [aj, aj];
z= [1,1];

plot3(x,y,z,'--','color','k','DisplayName','$m_i=m_j$, $b_i=b_j$','LineWidth',1.5);

hold on 

%line for alphai = alphaj
x1 = [muj, muj];
y1 = [aj, alphaend];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
%%
legend('FontSize',20,'Interpreter', 'latex')
hold off

end
