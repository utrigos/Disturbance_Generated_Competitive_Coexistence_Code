tic;
% 
% f = datetime('now');
% disp(f);

for F = 5:5

    if F ==1
        %________PARAMETER (a)______%
           Birth2 = 11; %invader
           Death2 = 6;  %invader

            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
            %________PARAMETER (a)_______%
    elseif F==2
            % % %________PARAMETER (b)______%
             Birth2 = 20; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident
            % % %________PARAMETER (b)_______%
    elseif F==3
            % %________PARAMETER (c)______%
            Birth2 = 17; %invader
            Death2 = 7;  %invader
             
            Birth1 = 6.8; %resident
            Death1 = 2;   %resident
            % %________PARAMETER (c)_______%
    elseif F==4
            % %________PARAMETER (d)______%
            Birth2 = 21; %invader
            Death2 = 7;  %invader
            
            Birth1 = 9; %resident
            Death1 = 2;   %resident
            % %________PARAMETER (d)_______%
    elseif F==5
            % %________PARAMETER (d)______%
            Birth2 = 15; %invader
            Death2 = 6;  %invader
            
            Birth1 = 5.6; %resident
            Death1 = 1;   %resident
            % %________PARAMETER (d)_______%

     else
        break;
    end


            tmax = 400; 
            amax = 80;
            
           
            gamma = 1;
            eps = 10^(-5);
            
            Na = 800;
            Nt = 12000;
            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);
            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma);
            
            InitCon1 = n(:,end);
            InitCon2 = eps.* ones(length(a),1); %cons epsilon

            
            
            [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma); %ursula change
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state
            
            
             MUN = DeathFunction1(a,n(:,end),m(:,end),rho(:,end),Death1);
             MUM = DeathFunction2(a,m(:,end),n(:,end),rho(:,end),Death2);
            
             MUI = MUN(1);
             MUJ = MUM(1);
            


%% Looking for where 1-ni-nj = 0 for critical age value
Q =1 -m(:,end)-n(:,end);
J=Q<0;

try
k = find(J==1);
criticala = a(k(1));
        disp ('critical a is '); disp(criticala)
catch  
        disp('critical a does not exist.')
        critA = 1;
 end
%%
            %-----------------------------------------------------------
            


fig4 =figure();

            hold on
            numlines = 12; %number of lines to be graphed (needs to be even)

            for i = 1:numlines    % more or less if you need, do 1000*i for all i's to get the original code
%                 txt = ['t = ', num2str(i./30)];
                  plot(a,m(:,i)./m(600,i),'LineWidth',2.0,'HandleVisibility','off');%,'DisplayName',txt)          %scaled to 1
            end
            hold on
            
            %---------- array for colors, add up all the above for loops and set j = to that #---------
            
            j =numlines; g = 3; st =.95;
            leftcolors = zeros(j,g);

            for i= 1:j
                leftcolors(i,:) = [st (i-1)./j 0]; 
            end
%             for i= 1:j./2
%                 leftcolors(i,:) = [st (i-1)./j 0]; 
%             end

%             for i= j./2+1:j
%                 leftcolors(i,:) = [st (j-1)./j 0]; 
%             end
             
            colororder(leftcolors)

            hold on 

            y=[.1,1.6];
            x=[5,8];
            sz = 100;
%             N = 64;   % or whatever
%             Color1 = [ones(N,1),(N-1:-1:0)'/(N-1),zeros(N,1)];
            colormap(leftcolors)

         
%             s=scatter(x,y,sz,y,'filled','HandleVisibility','off');
            h = colorbar;

            h.Label.String = "Time";
            h.Label.Rotation = 270;
            h.Label.VerticalAlignment = "bottom";
            h.Label.FontSize = 20;
            h.Label.Interpreter = 'latex';
            
            %---------- array for colors--------------------------------------------------------------
            hold on
%  plot(a,m(:,12000)./m(600,12000),'g--','LineWidth',2.0,'HandleVisibility','off');%'DisplayName','invader at long times')
%   plot(a,n(:,12000)./n(600,12000),'b--','LineWidth',2.0,'DisplayName','resident at long times')
            
            
             %-----------fixed parameters equilibrium distribution-----------------------
            
%             plot(a,SI./MUI.*(1-exp(-MUI.*a))./(SI./MUI.*(1-exp(-MUI.*20))),'c.-','DisplayName','Resident Equibm Distrbn ') 
%             hold on
            
            plot(a,SJ./MUJ.*(1-exp(-MUJ.*a))./(SJ./MUJ.*(1-exp(-MUJ.*20))),'k--','DisplayName','Equilibrium Distribution ','LineWidth',2.0) 
             %-----------fixed parameters equilibrium distribution-----------------------
            
            axis([0 6 0 1.2]) 
            
            legend('FontSize',20,'Location','best','Interpreter', 'latex')
        
            
            xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
            ylabel('Scaled Invader Density','FontSize',20,'Interpreter', 'latex')
            
            hold off;
            
%             
%             %-------------------------------RAINEY CODE END-----------------------------------------
%             %                                                                                     
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of invader over time end        %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %--------------------------------------------------------------------------
%             
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of invader over time start      %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %-------------------------------RAINEY CODE START---------------------------------------
%             fig5 =figure();
%             
%             hold on
%             for i = 1:12     % more or less if you need
%                 txt = ['t = ', num2str(100*i./30)];
%                 plot(a,m(:,100*i),'DisplayName',txt,'LineWidth',2.0)                     %original density function
%                 %plot(a,m(:,100*i)./m(20,100*i),'DisplayName',txt)          %scaled to 1 
%             end
%             
%             hold on
%             for i = 1:12     % more or less if you need
%                 txt = ['t = ', num2str(1000*i./30)];
%                 plot(a,m(:,1000*i),'DisplayName',txt,'LineWidth',2.0)                     %original density function
%                 %plot(a,m(:,1000*i)./m(20,1000*i),'DisplayName',txt)          %scaled to 1 
%             end
%             hold on
%             %---------- array for colors, add up all the above for loops and set j = to that #---------
%             
%             j =24; g = 3; 
%             leftcolors = zeros(j,g);
%             for i= 1:j
%                 leftcolors(i,:) = [0 (i-1)/j 1]; 
%             end
%              
%             colororder(leftcolors)
%             %---------- array for colors--------------------------------------------------------------
%             
%              %-----------fixed parameters equilibrium distribution-----------------------
%             plot(a,SJ./MUJ.*(1-exp(-MUJ.*a)),'r.-','DisplayName','Invader Equibm Distrbn ')
%             hold on
%             
%             plot(a,SI./MUI.*(1-exp(-MUI.*a)),'g.-','DisplayName','Resident Equibm Distrbn ') 
%              %-----------fixed parameters equilibrium distribution-----------------------
%             
%             axis([0 2 0 .2]) 
%             %xlim([0 2])
%             legend show
%             
%             
%             str = sprintf('Invader dens w cons %s ,  %s = %g , %s = %g , %s = %g , %s = %g , %s = %g.','\epsilon','\mu_j',Death1,'b_j',Birth1,'\mu_i', Death2, 'b_i', Birth2,'\gamma',gamma);
%             %str = sprintf('Invader dens w %s (a) ,  %s = %g , %s = %g , %s = %g , %s = %g , %s=%g .','\epsilon','\mu_j',Death1,'b_j',Birth1,'\mu_i', Death2, 'b_i', Birth2,'\gamma',gamma);
%             title(str,'FontSize',16);
%              
%             xlabel('age')
%             ylabel('Invasive Species')
%             
%             hold off;
%             
%             
%             %-------------------------------RAINEY CODE END-----------------------------------------
%             %                                                                                     
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of invader over time end        %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %--------------------------------------------------------------------------
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of total density of invader over time start      %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %total density of invading species
%             
             fig6 = figure();
             set(gca,'fontname','times')
              hold on;
                    dt = tmax/Nt;
                    t = 0:dt:tmax;
                
                    plot(t, trapz(a,diag(rho)*m,1),'k','DisplayName','Introduced Sp (Sp $i$) Total Density $N_i$ - Num','LineWidth',2.0)        
%                     plot(t, trapz(a,diag(rho)*n,1),'m','DisplayName','resident (sp j) total density - Num','LineWidth',2.0)      
                    
            
            
            
            %-----------fixed parameters equilibrium distribution-----------------------
            % 
            % 
            % 
            
            %     ReproductionFunction2(a,nk,mk,rhok,b)
            
            
             %    DeathFunction2(a,nk,mk,rhok,mu)
            
            
            % %------
            Trapz1 =trapz(a,rho.*(SI./MUI).*(1-exp(-MUI.*a))).*ones(length(t),1);
            Trapz2 = trapz(a,rho./MUJ.*SJ.*(1-exp(-MUJ.*a))).*ones(length(t),1);
%             plot(t,Trapz1,'r--','DisplayName','resident (sp j) Total Eq Dens - Theo ','LineWidth',2.0)
%             plot(t,Trapz2,'k--','DisplayName','introduced sp (sp i) Total Eq Dens - Theo ','LineWidth',2.0)
            
            
            % %-----------fixed parameters equilibrium distribution-----------------------
            
             axis([0 10 0 11.*10^(-6)]) 
            xlabel('Time','FontSize',20,'Interpreter', 'latex')
            ylabel('Average Invader Density $N_i$','FontSize',20,'Interpreter', 'latex')
            
            hold off;
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of total density of invader over time end        %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
%             
            
            %------------------------------------------------------------------------
            
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %         New figure start            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
            fig7= figure();
            set(gca,'fontname','times')
            hold on
            plot(a, n(:,end),'m', 'DisplayName','resident (sp j) density - Num','LineWidth',2.0)
            plot(a, m(:,end),'c','DisplayName','introduced sp (sp i) density - Num','LineWidth',2.0)
            plot(a, SI./Death1 .*(1-exp(-Death1.*a)),'r--','DisplayName','resident (sp j) eq dens - Theo', 'LineWidth',2.0)
            plot(a, SJ./Death2 .*(1-exp(-Death2.*a)),'b--','DisplayName','introduced sp (sp i) eq dens - Theo','LineWidth',2.0)
            
            legend show

            str = sprintf('Density over age,  %s = %g , %s = %g , %s = %g, %s = %g , %s = %g .','\mu_j',Death1,'b_j',Birth1,'\mu_i',Death2,'b_i',Birth2,'\gamma',gamma);
            title(str,'FontSize',18);
            xlabel('age','FontSize',20)
            ylabel('Density','FontSize',20)
            legend('FontSize',20,'Location','south')

%              axis([0 20 0 1]);
            
            hold off;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %          New Figure end              %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
            %--------------------------------------------------------------------------


            


clearvars;
end

toc

