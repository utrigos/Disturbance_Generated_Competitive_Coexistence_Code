
%% Alpha / Mortality Trade-Off - New Code Oct 23, 2024
meshsize = 0.001;

        g = 0.5; %gamma
        mj = 2;
        aj=.95;
        ri=25;
        rj=25;
      
%% define range of alpha and mortality values
alphaend = aj+0.5;
mend = mj;
mstart = 0;

alphai=aj:meshsize:alphaend;
mi=mstart:meshsize:mend;
%% end define range of alpha and mortality values


%% Making a Matrix of alpha and mortality values
[m,a] = meshgrid(mi,alphai);

%% Invasion Conditions

%Species i invades sp j. Eqn s[20]
IinvJ = ((-1).*g+(-1).*m+a.*aj.^(-1).*ri.*(a.^(-1).*((-1).*g+(-1).*mj+rj).^(-1).*((-1).*a.*m+(a+(-1).*aj).*((-1).*g+rj))).^(ri.*((-1).*g+ri).^(-1))+ri.*(1+(-1).*a.*aj.^(-1).*rj.^(-1).*((-1).*g+(-1).*mj+rj)))>(1); 

%Species j invades sp i. Eqn s[21]
JinvI = ((-1).*g+(-1).*mj+(1+(-1).*a.^(-1).*aj.*ri.^(-1).*((-1).*g+(-1).*m+ri)).*rj)>(1);

%Where the critical condition is satisfied. (line 614)
CritCon = a.*aj.^(-1).*((-1).*g+rj).^(-1).*((-1).*g+(-1).*mj+rj)>1;

%% Setting up Inequalities

SpI = IinvJ.*CritCon;
SpI(SpI==0)=NaN; %where sp i can invade and the critical condition is satisfied.

SpJ = JinvI.*CritCon;
SpJ(SpJ==0)=NaN; %where sp j can invade and the critical condition is satisfied.

CoexMat = SpI.*SpJ;
CoexMat(CoexMat==0)=NaN;%mutual invasion and the critical condition is satisfied.

fig1=figure();

%% Graphing

spi= pcolor(m,a,SpI);
spi.DisplayName ='Species $i$ invades';
hold on

spj = pcolor(m,a,2*SpJ);
spj.DisplayName ='Species $j$ invades';
hold on

if g==0
 coexmat(1,1)=1; %adding false coexistence to force black on legend
end

%% Adjusting Colors

coex=pcolor(m,a,3*CoexMat);
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


