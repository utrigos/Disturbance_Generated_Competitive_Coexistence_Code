
            %___________________reading data from a CSV file________________________

            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            Death2 = 0.4; 
            Alpha1 = 0.75;
            InvType = 2;

            gamma = 1.25;
    
                Matrix = readmatrix('Matrix_Func_bj_2.34_alphaj_0.75_g_1.25.csv');
                Matrix2 = readmatrix('Matrix2_Func_bj_2.34_alphaj_0.75_g_1.25.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_bj_2.34_alphaj_0.75_g_1.25.csv');
                Birth2 = readmatrix('Birth2_Func_bj_2.34_alphaj_0.75_g_1.25.csv'); 
                Alpha2 = readmatrix('Alpha2_Func_bj_2.34_alphaj_0.75_g_1.25.csv');
                InvType = 2;
    


            %___________________reading data from a CSV file________________________



%-----------------This is the Main Plot We Are Interested In----------- 

fig1 = figure();
% surf(Alpha2,Birth2,Matrix,'DisplayName','Species $i$ invades','EdgeColor','none','FaceColor', '[0 0.4470 0.7410]','FaceAlpha',0.7)
% hold on
% surf(Alpha2,Birth2,Matrix2,'DisplayName','Species $j$ invades','EdgeColor','none','FaceColor', '[0.6350 0.0780 0.1840]','FaceAlpha',0.7)
% hold on
% surf(Alpha2,Birth2,MutInvMat,'DisplayName','Coexistence','EdgeColor','k','FaceColor', 'k','FaceAlpha',0.7)
% hold on

%% pcolor start

    spi =pcolor(Alpha2,Birth2,-1*Matrix);
    spi.FaceAlpha = 0.7;
    spi.DisplayName ='Species $i$ invades';
    hold on;
    
    spj = pcolor(Alpha2,Birth2,.1*Matrix2);
    spj.FaceAlpha = 0.7;
    spj.DisplayName ='Species $j$ invades';
    hold on;
    
    coex = pcolor(Alpha2,Birth2,2*MutInvMat);
    coex.DisplayName ='Coexistence';
    hold on;

    cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
    colormap(cmap)

    shading flat

%% pcolor end

xlabel('Mortality Competition Sensitivity $\alpha_i$','Interpreter', 'latex','FontSize',20)
ylabel('Reproduction $r_i$','Interpreter', 'latex','FontSize',20)
view(0,90)


 hold on;
   % %line for alphai at alphaj
   x = [Alpha1,Alpha1];
   y = [Birth1, Birth1+14];

   plot(x,y,'--','color','k','DisplayName','$\alpha_i=\alpha_j$, $r_i=r_j$','LineWidth',1.5);
             
   hold on 
             
   %% line for ri = rj
   x1 = [Alpha1, Alpha1+10 ];
   y1 = [Birth1, Birth1];
             
   plot(x1,y1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
 
   axis([Alpha1-.2 Alpha1+10 Birth1-.2 Birth1+14])


 
legend('FontSize',20,'Location','northeast','Interpreter', 'latex')

