

meshsize = .01;
g=0.1; %Change Gamma (disturbance) here

ai = 1;
aj = 1;
mycount = 2;
%%
% -------Param 0 ----------------


if mycount ==1
    rj=2.34; 
    mj=0.4;
    
elseif mycount ==2
    rj=5.6;
    mj=1;

elseif mycount ==3
    rj=6.8; 
    mj=2;

elseif mycount ==4
    rj=9; 
    mj=2;
end


mi=mj:meshsize:8;
ri=rj:meshsize:30;

tic;
%Making a Matrix of r_i and m_i values
[r,m] = meshgrid(ri,mi);
%%

%%
%-------start feasbility ----------------
Sij= r > (2*rj.*(m+g).*(g+mj).*(m+g+mj))./(rj.*g.*(m-mj)+(g+mj).*(m+2*g+mj).*(g+2*mj));
Sji= r < (rj.*(m+g).*(2*m+g).*(m+2*g+mj))./(rj.*g.*(m-mj)+2.*(m+g).*(g+mj).*(m+g+mj));

 feas = Sij.*Sji;
 if g==0
     feas(1,1)=1;
 end
 feas(feas==0) = NaN;

%-------end feasibiltity----------------
%%
%-------start no patch dynamics----------------
NPDi = (ai.*r.*(r+(-1).*m).^(-1))<(aj.*rj.*(rj+(-1).*mj).^(-1));
NPDj = (aj.*rj.*(rj+(-1).*mj).^(-1))<(ai.*r.*(r+(-1).*m).^(-1));
ineqNPD = (r.*ai.*(r+(-1).*m).^(-1))>(0);
%-------end no patch dynamics----------------

%%
%-------start Rvals ----------------

ineq3 = 1<2;

% ----constant epsilon----
  Rij = ((1/2).*r.^(-1).*(g+m).^(-1).*(2.*r.*(g+m)+(-1).*(r+(-1).*g+(-1).*m).*(g+2.*m)))>(rj.^(-1).*(g+mj));
  Rji = ((1/2).*rj.^(-1).*(g+mj).^(-1).*(2.*rj.*(g+mj)+(-1).*(rj+(-1).*g+(-1).*mj).*(g+2.*mj)))>(r.^(-1).*(g+m));
% ----constant epsilon----

 % -----epsilon(a)-------
 Ri =(rj+(-1).*g+(-1).*mj+(-1/2).*r.^(-1).*rj.*(r+(-1).*g+(-1).*m).*(g+m).^(-1).*(g+2.*m).*(g+m+mj).^(-1).*(2.*g+m+mj))>(0);
 Rj = (r+(-1).*g+(-1).*m+(-1/2).*r.*rj.^(-1).*(rj+(-1).*g+(-1).*mj).*(g+mj).^(-1).*(g+m+mj).^(-1).*(2.*g+m+mj).*(g+2.*mj))>(0);
% ------epsilon(a)-----
%%

%-----crit condition-----
aci = (1+(-2).*m.*(g+2.*m).^(-1).*r.*((-1).*g+(-1).*m+r).^(-1))<=(0);
acj = (1+(-2).*rj.*(rj+(-1).*g+(-1).*mj).^(-1).*mj.*(g+2.*mj).^(-1))<=(0);
%-----crit condition-----
%%
%-----trace stability---------
tr = ((1/2).*rj.^(-1).*((g+mj).*(g+2.*mj).^(-1)).^(-1/2).*((-1).*rj.*(g+2.*m).*((g+mj).*(g+2.*mj).^(-1)).^(1/2)+((g+m).^(-1).*(g+2.*m).*(g+mj).*(g+2.*mj).^(-1).*(2.*r.^2.*(g+m).*(g+2.*m).^(-1).*(g+mj).*(g+2.*mj)+(-4).*r.*rj.*(r+(-1).*g+(-1).*m).*(g+m+mj).^(-1).*(2.*g+m+mj).*(g+2.*mj)+2.*rj.^2.*(4.*((-1).*r+g+m).^2+r.*g.*m.^(-1).*(g+m).*(g+2.*m).^(-1).*(2.*(g+m).*(g+2.*m)+(-1).*r.*(2.*g+3.*m)).*(g+mj).^(-1)+2.*r.*g.*(r+(-1).*g+(-1).*m).*m.^(-1).*(g+2.*m).*(g+m+mj).^(-1)))).^(1/2)+(-1).*2.^(1/2).*rj.*((g+m).^( -1).*(g+2.*m).*(g+mj).*(g+2.*mj).^(-1)).^(1/2).*abs((-1).*r+g+m)+(-1).*2.^(1/2).*rj.*abs((-1).*rj+g+mj)))<(0);
%-----trace stability---------

%-----determinant stability--------
det = ((-1/2).*g.*(1+g.*(g+2.*m).^(-1)).^(-1/2).*abs((-1).*r+g+m)+(-1).*(1+g.*(g+2.*m).^(-1)).^(-1/2).*mj.*abs((-1).*r+g+m)+(-1).*2.^(-1/2).*(1+g.*(g+2.*m).^(-1)).^(-1/2).*((g+mj).^(-1).*((-1).*rj+g+mj).^2.*(g+2.*mj)).^(1/2).*abs((-1).*r+g+m)+2.^(-1/2).*r.^(-1).*(1+g.*(g+2.*m).^(-1)).^(-1/2).*((g+m).^(-1).*(g+mj).^(-1).*(g+m+mj).^(-1).*(rj.^2.*(g+m).^2.*(g+2.*m).*(g+mj).*(g+m+mj)+2.*r.*rj.*(g+m).*(g+2.*m).*((-1).*rj+g+mj).*(2.*g+m+mj).*(g+2.*mj)+r.^2.*(4.*(g+m).*(g+mj).^2.*(g+m+mj).*(g+2.*mj)+(-2).*rj.*(g+mj).*(g+2.*mj).*(4.*g.^2+4.*m.*(m+mj)+3.*g.*(3.*m+mj))+rj.^2.*(5.*g.^3+8.*m.*mj.*(m+mj)+g.^2.*(11.*m+12.*mj)+g.*(4.*m.^2+25.*m.*mj+5.*mj.^2))))).^(1/2).*abs((-1).*r+g+m)+(1/2).*((g+m).^(-1).*(g+2.*m)).^(1/2).*((g+m).*(g+2.*m)).^(1/2).*(1+g.*(g+2.*mj).^(-1)).^(-1/2).*abs((-1).*rj+g+mj)+(-1/2).*rj.^(-1).*((g+m).^(-1).*(g+2.*m)).^(1/2).*(1+g.*(g+2.*mj).^(-1)).^(-1/2).*(2.*r.^2.*(g+m).*(g+2.*m).^(-1).*(g+mj).*(g+2.*mj)+(-4).*r.*rj.*(r+(-1).*g+(-1) .*m).*(g+m+mj).^(-1).*(2.*g+m+mj).*(g+2.*mj)+2.*rj.^2.*(4.*((-1).*r+g+m).^2+r.*g.*m.^(-1).*(g+m).*(g+2.*m).^(-1).*(2.*(g+m).*(g+2.*m)+(-1).*r.*(2.*g+3.*m)).*(g+mj).^(-1)+2.*r.*g.*(r+(-1).*g+(-1).*m).*m.^(-1).*(g+2.*m).*(g+m+mj).^(-1))).^(1/2).*abs((-1).*rj+g+mj)+2.^(-1/2).*((g+m).^(-1).*(g+2.*m)).^(1/2).*(1+g.*(g+2.*mj).^(-1)).^(-1/2).*abs((-1).*r+g+m).*abs((-1).*rj+g+mj))>(0);
%-----determinant stability--------


fi=Ri.*ineq3;
fj=Rj.*ineq3;

fi(fi==0)=NaN;
fj(fj==0)=NaN;

CritCondition = aci.*acj;
CritCondition(CritCondition==0)=NaN;

TrDetCon = tr.*det;
TrDetCon(TrDetCon==0)=NaN;

TrCon = tr.*ineq3;
DetCon = det.*ineq3;

TrCon(TrCon==0)=NaN;
DetCon(DetCon==0)=NaN;

%%

fig1=figure();
%%

% surf(m,r,fj,'DisplayName','Species $i$ invades','EdgeColor','none','FaceColor', '[0 0.4470 0.7410]','FaceAlpha',0.7,'EdgeAlpha',0)
%     hold on 
% surf(m,r,fi,'DisplayName','Species $j$ invades','EdgeColor','none','FaceColor', '[0.6350 0.0780 0.1840]','FaceAlpha',0.7,'EdgeAlpha',0)
%     hold on 
% surf(m,r,feas,'DisplayName','Coexistence','EdgeColor', 'none', 'FaceColor','k')

%%


%% pcolor start
    spi =pcolor(m,r,fj);
%     spi.FaceAlpha = 0.7;
    spi.DisplayName ='Species $i$ invades';
    hold on;
    
    spj = pcolor(m,r,2*fi);
%     spj.FaceAlpha = 0.7;
    spj.DisplayName ='Species $j$ invades';
    hold on;
    

    coex = pcolor(m,r,3*feas);
    coex.DisplayName ='Coexistence';
    hold on;

    cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
    colormap(cmap)

    shading flat
%% pcolor end

hold on 


%%
set(gca,'fontname','times')
grid on

xlabel('Mortality $m_i$','FontSize',20,'Interpreter','latex')
ylabel('Reproduction $r_i$','FontSize',20,'Interpreter','latex')

view(0,90)
%%
hold on 

%line for mi at mj
x = [mj, 8];
y = [rj, rj];
z= [1,1];


plot3(x,y,z,'--','color','k','DisplayName','$r_i=r_j$, $m_i=m_j$','LineWidth',1.5);

hold on 

%line for ri = rj
x1 = [mj, mj];
y1 = [rj, 30+rj];
z1= [1,1];

plot3(x1,y1,z1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
%%
legend('Location','north','FontSize',20,'Interpreter', 'latex')
hold on 


axis([mj-.15 8+.05 rj-.45 30])

% plot(1.085,6,'.')
% plot(1.085,5.97,'.')

 legend('Location','northwest','Interpreter','latex')


toc;
hold off

