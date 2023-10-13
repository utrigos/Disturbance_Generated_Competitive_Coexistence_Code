tic

%% Theoretical
meshsize = 0.001;


for i=6:6  % Gives us different pictures from Fig S6

if i==1
     g = 0; %fig S6a
elseif i==2 
     g = 0.2; %fig S6b
elseif i==3
     g = 0.3; %fig S6c
elseif i==4
     g = 0.4; %fig S6d
elseif i==5
     g = 0.5; %fig 4b and S6e
elseif i==6
    g = 0.5;%Shows Numerical overlay %fig S5
elseif i==7
    g = 2.5; %fig S6f
end

        mj = 1;
        mi = 1;
        aj=0.2;
        rj=5;

      
%define range of alpha and r values
alphaend = aj+.15;
rend = rj+40;

alphai=aj:meshsize:alphaend;
ri=rj:meshsize:rend;
%-------Param 3 ----------------


%Making a Matrix of alpha and reproduction values
[r,a] = meshgrid(ri,alphai);

%% Invasion
AcjCon = ((a .*(g + mj - rj)) ./(a .*mj - (a - aj) .*(rj - g)))>(1); %checking when critical condition is satisfied

AcjConNot = ((a .*(g + mj - rj)) ./(a .*mj - (a - aj) .*(rj - g)))<=(1); %checking when critical condition is not satisfied

RijFinite = ((-1).*g+(-1).*mi+aj.^(-1).*r.*rj.^(-1).*(a.*g+a.*mj+(-1).*a.*rj+aj.*rj+(-1).*a.*(g+mj+(-1).*rj).*(a.*(g+mj+(-1).*rj).*(a.*mj+(-1).*(a+(-1).*aj).*((-1).*g+rj)).^(-1)).^((g+(-1).*rj).^(-1).*rj)))>(0); %when sp i invades and there is a finite cut-off

RijInfinite = ((-1).*g+(-1).*mi+r.*(1+(-1).*a.*aj.^(-1).*rj.^(-1).*((-1).*g+(-1).*mj+rj)))>(0); %when sp i invades and there is no finite cut-off

Rji = ((-1).*g+(-1).*mj+a.^(-1).*r.^(-1).*(aj.*(g+mi)+(a+(-1).*aj).*r).*rj)>(0); %when sp j invades

SpIInvFinite = AcjCon.*RijFinite; %sp i invades with a finite cut-off and the critical condition is satisfied

SpIInvInfinite = AcjConNot.*RijInfinite; %sp i invades without a finite cut-off and the critical condition is not satisfied
% 
invFinite = SpIInvFinite.*Rji; %mutual invasion with a finite cut-off and the critical condition is satisfied

invInfinite = SpIInvInfinite.*Rji; %mutual invasion without a finite cut-off where the critical condition is not satisfied


%%
%-------start Rvals ----------------

ineq3 = 1<2; %always true

invRj = Rji.*ineq3;
invRj(invRj==0)=NaN; %where sp j can invade (total)

spimat = SpIInvInfinite+SpIInvFinite;
spimat(spimat==0)=NaN; %where sp i can invade (total)

coexmat = invFinite+invInfinite;
coexmat(coexmat==0)=NaN;%mutual invasion (total)

fig1=figure();
%%

spi= pcolor(r,a,spimat);
spi.DisplayName ='Species $i$ invades';
hold on

spj = pcolor(r,a,2*invRj);
spj.DisplayName ='Species $j$ invades';
hold on

if i==1
 coexmat(1,1)=1; %adding false coexistence to force black on legend
end

coex=pcolor(r,a,3*coexmat);
coex.DisplayName ='Coexistence';
hold on
 cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
 colormap(cmap)

shading flat
%% numerical

if i==6

            %___________________reading data from a CSV file________________________
    
                Matrix = readmatrix('Matrix_Func_muj_1_alphaj_0.02_g_0.5.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_1_alphaj_0.02_g_0.5.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_1_alphaj_0.02_g_0.5.csv');
                MutInvMatAc = readmatrix('MutInvadeMatrixAc_Func_muj_1_alphaj_0.02_g_0.5.csv');
                Birth2 = readmatrix('Birth2_Func_muj_1_alphaj_0.02_g_0.5.csv'); 
                Alpha2 = readmatrix('Alpha2_Func_bj_5_aj_0.2_gamma_0.5_muj_1.csv');
                InvType = 2;

  
surf(Birth2,Alpha2,MutInvMat','DisplayName','Mutual Invasion','EdgeColor','[0.75, 0, 0.75]','FaceColor', 'b','FaceAlpha',0.3)

% numcoex = pcolor(Birth2,Alpha2,4*MutInvMat');
% numcoex.FaceAlpha = 0.7;
% numcoex.DisplayName='Numerical Mutual Invasion';

hold on 

end


% if i<6 || i==7
%     cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
% elseif i==6
%     cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0; 0.3010, 0.7450, 0.9330];
% end
% colormap(cmap)
% 
% shading flat
%%

xlabel('Reproduction $r_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Offspring Survival Competition Sensitivity $\alpha_i$','FontSize',15,'Interpreter', 'latex')

view(0,90)
%%

hold on 


%%
legend('FontSize',20,'Location','southeast','Interpreter', 'latex')

hold on 




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

axis([4 45 0.195 0.35]) 

toc
end