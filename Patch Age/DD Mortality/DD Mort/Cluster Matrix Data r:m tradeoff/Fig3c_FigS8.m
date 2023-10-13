%% DD MORT
tic
            %___________________reading data from a CSV file________________________
for mycount= 1:4
%  mycount = 4;

StepSizeB =0.5;
gamma =1;

             %________PARAMETER (a)______%
             if mycount ==1
                Birth1 = 2.34; %resident
                Death1 = 0.4;   %resident
    
                Matrix = readmatrix('Matrix_Cons_muj_0.4_bj_2.34.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_0.4_bj_2.34.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_0.4_bj_2.34.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_0.4_bj_2.34.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_0.4_bj_2.34.csv');
                InvType = 1;

             elseif mycount ==5
                Birth1 = 2.34; %resident
                Death1 = 0.4;   %resident
                Matrix = readmatrix('Matrix_Func_muj_0.4_bj_2.34.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_0.4_bj_2.34.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_0.4_bj_2.34.csv');
                Birth2 = readmatrix('Birth2_Func_muj_0.4_bj_2.34.csv'); 
                Death2 = readmatrix('Death2_Func_muj_0.4_bj_2.34.csv');
                InvType = 2;
            %________PARAMETER (a)_______%

            % % %________PARAMETER (b)______%
             elseif mycount ==2
                Birth1 = 5.6; %resident
                Death1 = 1;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_1_bj_5.6.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_1_bj_5.6.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_1_bj_5.6.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_1_bj_5.6.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_1_bj_5.6.csv');
                InvType = 1;

             elseif mycount ==6
                Birth1 = 5.6; %resident
                Death1 = 1;   %resident
                Matrix = readmatrix('Matrix_Func_muj_1_bj_5.6.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_1_bj_5.6.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_1_bj_5.6.csv');
                Birth2 = readmatrix('Birth2_Func_muj_1_bj_5.6.csv'); 
                Death2 = readmatrix('Death2_Func_muj_1_bj_5.6.csv');
                InvType = 2;
            % % %________PARAMETER (b)_______%

            % %________PARAMETER (c)______%  
             elseif mycount==3
                Birth1 = 6.8; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_2_bj_6.8.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_2_bj_6.8.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_2_bj_6.8.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_2_bj_6.8.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_2_bj_6.8.csv');
                InvType = 1;

             elseif mycount ==7
                Birth1 = 6.8; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Func_muj_2_bj_6.8.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_2_bj_6.8.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_2_bj_6.8.csv');
                Birth2 = readmatrix('Birth2_Func_muj_2_bj_6.8.csv'); 
                Death2 = readmatrix('Death2_Func_muj_2_bj_6.8.csv');
                InvType = 2;       
            % %________PARAMETER (c)_______%

            % %________PARAMETER (d)______%    
             elseif mycount==4
                Birth1 = 9; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Cons_muj_2_bj_9.csv');
                Matrix2 = readmatrix('Matrix2_Cons_muj_2_bj_9.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Cons_muj_2_bj_9.csv');
                Birth2 = readmatrix('Birth2_Cons_muj_2_bj_9.csv'); 
                Death2 = readmatrix('Death2_Cons_muj_2_bj_9.csv');
                InvType = 1;
             elseif mycount==8
                Birth1 = 9; %resident
                Death1 = 2;   %resident
                Matrix = readmatrix('Matrix_Func_muj_2_bj_9.csv');
                Matrix2 = readmatrix('Matrix2_Func_muj_2_bj_9.csv');
                MutInvMat = readmatrix('MutInvadeMatrix_Func_muj_2_bj_9.csv');
                Birth2 = readmatrix('Birth2_Func_muj_2_bj_9.csv'); 
                Death2 = readmatrix('Death2_Func_muj_2_bj_9.csv');
                InvType = 2;
            % %________PARAMETER (d)_______%

             end
  
            %___________________reading data from a CSV file________________________



%-----------------This is the Main Plot We Are Interested In----------- 

fig1 = figure();

%% pcolor start

    spi =pcolor(Death2,Birth2,-1*Matrix);
%     spi.FaceAlpha = 0.7;
    spi.DisplayName ='Species $i$ invades';
    hold on;
    
    spj = pcolor(Death2,Birth2,.1*Matrix2);
%     spj.FaceAlpha = 0.7;
    spj.DisplayName ='Species $j$ invades';
    hold on;
    
    coex = pcolor(Death2,Birth2,2*MutInvMat);
    coex.DisplayName ='Coexistence';
    hold on;

    cmap = [0 0.4470 0.7410; 0.6350 0.0780 0.1840; 0 0 0];
    colormap(cmap)

    shading flat

%% pcolor end

xlabel('Mortality $m_i$','FontSize',20,'Interpreter', 'latex')
ylabel('Reproduction $r_i$','FontSize',20,'Interpreter', 'latex')
view(0,90)

set(gca,'fontname','times')

hold on;
 % %line for mi at mj
 x = [Death1,Death1];
 y = [Birth1, 50];

 
 plot(x,y,'--','color','k','DisplayName','$r_i=r_j$, $m_i=m_j$ ','LineWidth',1.5);
 
 hold on 
 
 %line for ri = rj
 x1 = [Death1, 35];
 y1 = [Birth1, Birth1];

 
 plot(x1,y1,'--','color','k','HandleVisibility','off','LineWidth',1.5);
 
 hold on 

 axis([Death1-.2 12 Birth1-.4 35])
 
 legend('Location','southeast','FontSize',20,'Interpreter', 'latex')
 hold on 
 legend show


hold off


end
