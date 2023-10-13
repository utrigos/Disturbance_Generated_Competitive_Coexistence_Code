
%% Theoretical
% meshsize = .009; %highest possible
meshsize = 0.01;

g = 2.5; %disturbance

mj=18.5; %death resident
aj=7.6; %alpha resident
bj=33.3; %birth resident
bi=33.3; %birth invader


%define range of alpha and m values
alphaend = 20;
mstart =0;

alphai=aj:meshsize:alphaend;
mi=mstart:meshsize:mj;
%-------Param 3 ----------------


%Making a Matrix of m_i and alpha_i values
[m,a] = meshgrid(mi,alphai);


%%
%-------start feasbility ----------------
Sij= ((1/2).*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(bj+(-1).*g+(-1).*mj).*(g+mj).^(-1).*(g+m+mj).^(-1).*(2.*g+m+mj).*(g+2.*mj))<(a.^(-1).*aj);
%  original
Sji= (a.^(-1).*aj)<(2.*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(g+m).*(g+2.*m).^(-1).*(bj+(-1).*g+(-1).*mj).*(g+m+mj).*(2.*g+m+mj).^(-1)); 

feas = Sij.*Sji;
feas(feas==0) = NaN;

%-------end feasibiltity----------------

ineq3 = 1<2;

feasSi = Sij.*ineq3;
feasSi(feasSi==0)=NaN;

feasSj = Sji.*ineq3;
feasSj(feasSj==0)=NaN;

%%

fig1=figure();
%%
 
    spi =pcolor(m,a,feasSi);
%     spi.FaceAlpha = 0.7;
    spi.DisplayName ='Species $i$ invades';
    hold on;
    
    spj = pcolor(m,a,2*feasSj);
%     spj.FaceAlpha = 0.7;
    spj.DisplayName ='Species $j$ invades';
    hold on;

    coex = pcolor(m,a,3*feas);
    coex.DisplayName ='Coexistence';
    hold on;


    cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
    colormap(cmap)

    shading flat

%%
%changes font
set(gca,'fontname','times')
%endchanges font


xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Sensitivity $\alpha_i$','FontSize',20,'Interpreter', 'latex')
set(gca,'YAxisLocation','right')
view(0,90)
%%

hold on 


 axis([0 19 7.6 30]);

%% Theoretical End



%% Numerical



             %________PARAMETER (a)______%

                Birth1 = bj; %fixed Param %resident
                Birth2 = bi;
                Death1 = mj; %fixed Param %resident
                Alpha1 = aj;

                Matrix = readmatrix('Matrix_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv');
                MutInvMatWAc = readmatrix('MutInvadeMatrixAc_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv');
                Alpha2 = readmatrix('Alpha2_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv'); 
                Death2 = readmatrix('Death2_Func_muj_18.5_alphaj_7.6_g_2.5_Na_16.csv');
                InvType = 2;
            %________PARAMETER (a)_______%

hold on

surf(Death2,Alpha2,MutInvMatWAc,'DisplayName','Positive Reproduction','FaceColor', '[0.4660 0.6740 0.1880]','FaceAlpha',0.7,'EdgeAlpha',0)
grid on
surf(Death2,Alpha2,MutInvMat,'DisplayName','Numerical Coexistence','FaceAlpha',0.7, 'FaceColor','m')
hold on


%% Numerical End


hold on 

%line for mi at mj
x = [0,mj];
y = [aj, aj];
z= [1,1];

plot3(x,y,z,'--','color','k','DisplayName','$r_i=r_j$, $m_i=m_j$','LineWidth',1.5);

hold on 

%line for alphai = alphaj
x1 = [mj, mj];
y1 = [aj, alphaend];
z1= [1,1];

 axis([2 18.6+.4 7.6-0.3 17])

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
%%
legend('FontSize',20,'Interpreter', 'latex')
hold off

