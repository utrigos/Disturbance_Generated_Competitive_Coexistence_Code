tic

%% Theoretical
% meshsize = 0.0005;
meshsize = .01;

        g = 0.66; 
        mj = 1;
        ai = 0.2;
        aj=0.2;
        rj=5;

%define range of alpha and mu values
% change to track on github testline
mend = mj+15;
rend = rj+40;

mi=mj:meshsize:mend;
ri=rj:meshsize:rend;
%-------Param 3 ----------------

%Making a Matrix of alpha and reproduction values
[r,m] = meshgrid(ri,mi);

%% Invasion
AcjCon = ((ai .*(g + mj - rj)) ./(ai .*mj - (ai - aj) .*(rj - g)))>(1);

AcjConNot = ((ai .*(g + mj - rj)) ./(ai .*mj - (ai - aj) .*(rj - g)))<=(1);

RijFinite = ((-1).*g+(-1).*m+aj.^(-1).*r.*rj.^(-1).*(ai.*g+ai.*mj+(-1).*ai.* ...
  rj+aj.*rj+(-1).*ai.*(g+mj+(-1).*rj).*(ai.*(g+mj+(-1).*rj).*(ai.* ...
  mj+(-1).*(ai+(-1).*aj).*((-1).*g+rj)).^(-1)).^((g+(-1).*rj).^(-1) ...
  .*rj)))>(0);

RijInfinite = ((-1).*g+(-1).*m+aj.^(-1).*r.*rj.^(-1).*(ai.*(g+mj)+((-1).*ai+aj) ...
  .*rj))>(0);

SpIInvFinite = AcjCon.*RijFinite;
SpIInvFinite(SpIInvFinite==0) = NaN;

SpIInvInfinite = AcjConNot.*RijInfinite;
SpIInvInfinite(SpIInvInfinite==0)=NaN;


Rji = ((-1).*g+(-1).*mj+ai.^(-1).*r.^(-1).*(aj.*(g+m)+(ai+(-1).*aj).*r) ...
  .*rj)>(0);

invFinite = SpIInvFinite.*Rji;
invFinite(invFinite==0) = NaN;

invInfinite = SpIInvInfinite.*Rji;
invInfinite(invInfinite==0) = NaN;


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

%%

fig1=figure();


h = gobjects(4, 1); %order of legends

%% THE PCOLOR CODE

h(1)= pcolor(m,r,invRiInfinite);
h(1).DisplayName ='Species $i$ invades';
hold on

h(2)= pcolor(m,r,2*(invRj));
h(2).DisplayName ='Species $j$ invades';
hold on

invFinite(1,1)=1; %adding false coexistence to force black on legend
h(3)=pcolor(m,r,3*(invFinite));
h(3).DisplayName ='Coexistence';
hold on

cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
colormap(cmap)
shading flat

%% END PCOLOR CODE




%-------end Rvals ----------------

ylabel('Reproduction $r_i$','FontSize',20,'Interpreter', 'latex')
xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')

view(0,90)
%%

hold on 

 axis([mj-.3 mend rj-1 rend])

hold on 

%line for bi at bj
y = [rj,rj];
x = [mj, mend];
z= [1,1];

h(4)=plot3(x,y,z,'--','color','k','DisplayName','$r_i=r_j$, $m_i=m_j$','LineWidth',1.5);

hold on 

%line for mi = mj
y1 = [rj, rend];
x1 = [mj, mj];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
%%
legend(h([1 2 3 4]),'FontSize',20,'Location','southeast','Interpreter', 'latex')

hold on 


toc
