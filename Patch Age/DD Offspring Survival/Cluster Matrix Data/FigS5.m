tic

%% Theoretical
meshsize = 0.0005;
% meshsize = .01;

for g = 0:.1:.5
% g = 0.2; %.66
i =6;

% for i = 1:6
    if i ==1
        mj=2;
        mi=2;
        aj=1.5;
        rj=15;
    elseif i ==2
        mj=1;
        mi=1;
        aj=1;
        rj=5.6;
    elseif i==3
        mj=2;
        mi=2;
        aj=1;
        rj=6.8;
    elseif i==4
        mj=2;
        mi=2;
        aj=1;
        rj=9;
    elseif i==5
        mj = 18.5;
        mi = 18.5;
        aj=7.6;
        rj=33.3;
    elseif i==6
        mj = 1;
        mi = 1;
        aj=0.2;
        rj=5;
    end


%define range of alpha and r values
alphaend = aj+.15;
rend = rj+40;

alphai=aj:meshsize:alphaend;
ri=rj:meshsize:rend;
%-------Param 3 ----------------


%Making a Matrix of alpha and reproduction values
[r,a] = meshgrid(ri,alphai);

%% Invasion
AcjCon = ((a .*(g + mj - rj)) ./(a .*mj - (a - aj) .*(rj - g)))>(1);

AcjConNot = ((a .*(g + mj - rj)) ./(a .*mj - (a - aj) .*(rj - g)))<=(1);

RijFinite = ((-1).*g+(-1).*mi+aj.^(-1).*r.*rj.^(-1).*(a.*g+a.*mj+(-1).*a.*rj+ ...
  aj.*rj+(-1).*a.*(g+mj+(-1).*rj).*(a.*(g+mj+(-1).*rj).*(a.*mj+(-1) ...
  .*(a+(-1).*aj).*((-1).*g+rj)).^(-1)).^((g+(-1).*rj).^(-1).*rj)))>( ...
  0);

RijInfinite = ((-1).*g+(-1).*mi+r.*(1+(-1).*a.*aj.^(-1).*rj.^(-1).*((-1).*g+(-1) ...
  .*mj+rj)))>(0);

SpIInvFinite = AcjCon.*RijFinite;
SpIInvFinite(SpIInvFinite==0) = NaN;

SpIInvInfinite = AcjConNot.*RijInfinite;
SpIInvInfinite(SpIInvInfinite==0)=NaN;


Rji = ((-1).*g+(-1).*mj+a.^(-1).*r.^(-1).*(aj.*(g+mi)+(a+(-1).*aj).*r).* ...
  rj)>(0);

invFinite = SpIInvFinite.*Rji;
invFinite(invFinite==0) = NaN;

invInfinite = SpIInvInfinite.*Rji;
invInfinite(invInfinite==0) = NaN;



%%
%-------start Rvals ----------------

ineq3 = 1<2;

invRiFinite = SpIInvFinite.*ineq3;
invRiFinite(invRiFinite==0)=NaN;

invRiInfinite = SpIInvInfinite.*ineq3;
invRiInfinite(invRiInfinite==0)=NaN;

invRj = Rji.*ineq3;
invRj(invRj==0)=NaN;

invFinite = Rji.*SpIInvFinite;
invFinite(invFinite==0)=NaN;

invInfinite = Rji.*SpIInvInfinite;
invInfinite(invInfinite==0)=NaN;



fig1=figure();
%%


% 
%       surf(r,a,invRiInfinite,'HandleVisibility','off','EdgeColor', 'none', 'FaceColor','[0 0.4470 0.7410]','FaceAlpha',0.7)
%      hold on

%      surf(r,a,invRiFinite,'DisplayName','Species $i$ invades','EdgeColor', 'none', 'FaceColor','[0 0.4470 0.7410]','FaceAlpha',0.7)
%      hold on

%      surf(r,a,invRj,'DisplayName','Species $j$ invades','EdgeColor', 'none', 'FaceColor','[0.6350 0.0780 0.1840]','FaceAlpha',0.7)
%      hold on
      
%       surf(r,a,invFinite,'DisplayName','Coexistence','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',1)
%       hold on

%        surf(r,a,invInfinite,'HandleVisibility','off','EdgeColor', 'none', 'FaceColor','k','FaceAlpha',1)
%       hold on



      %% Using Pcolor

    spi =pcolor(r,a,-1*invRiFinite);
    spi.FaceAlpha = 0.7;
    spi.DisplayName ='Species $i$ invades';
    hold on;

    spj = pcolor(r,a,.1*invRj);
    spj.FaceAlpha = 0.7;
    spj.DisplayName ='Species $j$ invades';
    hold on;

    spj2 = pcolor(r,a,.1*invRiInfinite);
    spj2.FaceAlpha = 0.7;
    spj2.HandleVisibility='off';
    hold on;
    
    coex = pcolor(r,a,2*invFinite);
    coex.DisplayName ='Coexistence';
    hold on;

    coex2 = pcolor(r,a,2*invInfinite);
    coex2.HandleVisibility='off';
    hold on;
      
%-------end Rvals ----------------

xlabel('Reproduction $r_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Offspring Survival Competition Sensitivity $\alpha_i$','FontSize',15,'Interpreter', 'latex')

view(0,90)
%%

hold on 


%%
legend('FontSize',20,'Location','best','Interpreter', 'latex')

hold on 

if g==.66
    x = [12.5,rend];
    y = [.2598, .2598];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);
elseif g==.2
    x = [30.656,rend];
    y = [.2528, .2528];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);

elseif g==.3
    x = [22,rend];
    y = [.2543, .2543];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);

elseif g==.4
    x = [18,rend];
    y = [.2558, .2558];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);
elseif g==.5
    x = [15,rend];
    y = [.25725, .25725];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);
elseif g==2.5
    x = [7,rend];
    y = [.3333, .3333];
    z= [1,1];
    
    plot3(x,y,z,'color','[0 0.4470 0.7410 0.7]','HandleVisibility','off','LineWidth',1.3);


end
hold on 

%% numerical

if g ==0.5

            %___________________reading data from a CSV file________________________
    
                Matrix = readmatrix('Matrix_Func_muj_1_alphaj_0.02_g_0.5.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_1_alphaj_0.02_g_0.5.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_1_alphaj_0.02_g_0.5.csv');
                MutInvMatAc = readmatrix('MutInvadeMatrixAc_Func_muj_1_alphaj_0.02_g_0.5.csv');
                Birth2 = readmatrix('Birth2_Func_muj_1_alphaj_0.02_g_0.5.csv'); 
                Alpha2 = readmatrix('Alpha2_Func_bj_5_aj_0.2_gamma_0.5_muj_1.csv');
                InvType = 2;

  
% surf(Birth2,Alpha2,MutInvMat','DisplayName','Mutual Invasion');%,'EdgeColor','[0.4940, 0.1840, 0.5560]','FaceColor', 'b','FaceAlpha',0.3)

    numcoex = pcolor(Birth2,Alpha2,5*MutInvMat');
    numcoex.DisplayName ='Mutual Invasion';
    hold on;

  %% end numerical
% 
    cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0; 0 0 1];
    colormap(cmap)

    shading flat

hold on 

end

%line for ri at rj
x = [rj,rend];
y = [aj, aj];
z= [1,1];

plot3(x,y,z,'--','color','k','DisplayName','$r_i=r_j$, $\alpha_i=\alpha_j$','LineWidth',1.5);

hold on 

%line for alphai = alphaj
x1 = [rj, rj];
y1 = [aj, alphaend];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);

hold off


end
toc
