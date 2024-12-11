
%% Alpha / Mortality Trade-Off - New Code Oct 23, 2024
meshsize = 0.001;


        g = 1; %gamma
        mj = 2;
        aj=.95;
        r=25;

%% define range of alpha and mortality values
alphaend = aj+0.25;
mend = mj;
mstart = 0;

alphai=aj:meshsize:alphaend;
mi=mstart:meshsize:mend;
%% end define range of alpha and mortality values


%% Making a Matrix of alpha and mortality values
[m,a] = meshgrid(mi,alphai);

%% Invasion Conditions

%Species i invades sp j with acritical. Eqn s[20] (Expression from Mathematica file "2023_0909_density_dependent_offsrping_survival_with_critical_patch_age_cutoff_KEYcalcs", NOT typo in PDF)
IinvJ = ((-1).*m+aj.^(-1).*(a.*mj+(-1).*(a+(-1).*aj).*((-1).*g+r)).*(1+(-1).*(a.*(g+mj+(-1).*r).*(a.*mj+(-1).*(a+(-1).*aj).*((-1).*g+r)).^(-1)).^((-1).*g.*((-1).*g+r).^(-1))))>(0);

%Species i invades sp j without acritical.
IinvJnoAc = (aj.^(-1).*(a.*g+a.*mj+(-1).*a.*r+aj.*r))-mi-g>(0);

%Species j invades sp i. Eqn s[21]
JinvI = (a.^(-1).*(aj.*m+(-1).*a.*mj+(a+(-1).*aj).*((-1).*g+r)))>(0);

%Where the critical condition is satisfied. (line 614)
CritCon = a.*aj.^(-1).*((-1).*g+r).^(-1).*((-1).*g+(-1).*mj+r)>1;

%Where the critical condition is NOT satisfied. (line 614)
NoCritCon = a.*aj.^(-1).*((-1).*g+r).^(-1).*((-1).*g+(-1).*mj+r)<=1;

%% Setting up Inequalities

SpI = IinvJ.*CritCon; %where sp i can invade and the critical condition is satisfied.

SpINoACrit = IinvJnoAc.*NoCritCon; %where sp i can invade and the critical condition is not satisfied.

AcCoex = JinvI.*SpI; %mut invasion and the critical condition is satisfied.

NoAcCoex = JinvI.*SpINoACrit; %mutual invasion and the critical condition is not satisfied.

%%
ineq3 = 1<2; %always true

invRj = JinvI.*ineq3;
invRj(invRj==0)=NaN; %where sp j can invade (total)

spimat = SpI+SpINoACrit;
spimat(spimat==0)=NaN; %where sp i can invade (total)

coexmat = AcCoex+NoAcCoex;
coexmat(coexmat==0)=NaN;%mutual invasion (total)


fig1=figure();

%% Graphing

spi= pcolor(m,a,spimat);
spi.DisplayName ='Species $i$ invades';
hold on

spj = pcolor(m,a,2*invRj);
spj.DisplayName ='Species $j$ invades';
hold on

if g==0
 coexmat(1,1)=1; %adding false coexistence to force black on legend
end

%% Adjusting Colors

coex=pcolor(m,a,3*coexmat);
coex.DisplayName ='Coexistence';
hold on
 cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
 colormap(cmap)

shading flat

%% Labels and Legend

xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Offspring Survival Competition Sensitivity $\alpha_i$','FontSize',15,'Interpreter', 'latex')

view(0,90)

hold on 

legend('FontSize',20,'Location','best','Interpreter', 'latex')

hold on 



%% Graphing Starting Lines at "Axes"

%line for mi at mj
x = [mstart,mend];
y = [aj, aj];
z= [1,1];

plot3(x,y,z,'--','color','k','DisplayName','$m_i=m_j$, $\alpha_i=\alpha_j$','LineWidth',1.5);

hold on 

%line for alphai = alphaj
x1 = [mstart, mstart];
y1 = [aj, alphaend];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);

hold off


%% Setting up Viewing Axes

axis([mstart mend aj alphaend]) 


