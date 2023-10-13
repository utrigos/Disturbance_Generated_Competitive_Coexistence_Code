

%% Theoretical
% meshsize = .009; %highest possible
meshsize = 0.01;

% for g= 0:3:24;
g = 12;
i =5;

% for i = 1:4;
    if i ==1
        muj=10;
        aj=10;
        bj=35;
        bi=35;
    elseif i ==2
        muj=12;
        aj=12;
        bj=35;
        bi=35;
    elseif i==3
        muj=16;
        aj=8;
        bj=35;
        bi=35;
    elseif i==4
        muj=20;
        aj=5;
        bj=35;
        bi=35;
    elseif i==5
        muj = 18.5;
        aj=7.6;
        bi=33.3;
        bj=33.3;
    elseif i==6
        muj = 12;
        aj=12;
        bi=35;
        bj=35;
    end


%define range of alpha and m values
alphaend = 20;
mstart =0;

alphai=aj:meshsize:60;
mi=mstart:meshsize:muj;
%-------Param 3 ----------------


%Making a Matrix of m_i and alpha_i values
[m,a] = meshgrid(mi,alphai);



%% -------start feasbility ----------------
Sij= ((1/2).*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(bj+(-1).*g+(-1).*muj).*(g+muj).^(-1).*(g+m+muj).^(-1).*(2.*g+m+muj).*(g+2.*muj))<(a.^(-1).*aj);
%  original
Sji= (a.^(-1).*aj)<(2.*bi.*bj.^(-1).*(bi+(-1).*g+(-1).*m).^(-1).*(g+m).*(g+2.*m).^(-1).*(bj+(-1).*g+(-1).*muj).*(g+m+muj).*(2.*g+m+muj).^(-1)); 

feas = Sij.*Sji;
if g==0
    feas(1,1)=1; %adding a false coexistence point for gamma = 0 to show coexistence in legend
end
feas(feas==0) = NaN;

%% -------end feasibiltity----------------

%% invasion (gives same graph as feasibility)
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

%%

fig1=figure();


%% pcolor start

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


       hold on
%% pcolor end

xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Reproduction Competition Sensitivity $\alpha_i$','FontSize',20,'Interpreter', 'latex')
set(gca,'YAxisLocation','right')
view(0,90)
%%

hold on 


 axis([0 muj aj aj+15])


hold on 

%line for mi at mj
x = [0,muj];
y = [aj, aj];
z= [1,1];

plot3(x,y,z,'--','color','k','DisplayName','$m_i=m_j$, $\alpha_i=\alpha_j$','LineWidth',1.5);

hold on 

%line for alphai = alphaj
x1 = [muj, muj];
y1 = [aj, alphaend+2];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
%%
legend('FontSize',20,'Location','northeast','Interpreter', 'latex')
hold off

axis([2.5 18.75 7.3 17])


