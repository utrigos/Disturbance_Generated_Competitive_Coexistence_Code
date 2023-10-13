tic;

f = datetime('now');
disp(f);


tmax = 400; 
amax = 80;


            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident
%
            Birth2 = 2.4;
            Death2 = 0.4;
            
            alpha1 = 0.75;
            alpha2 = 0.8;
       


    InvType =2;



            gamma = 1;
            eps = 10^(-5);
            
            Na = 800;
            Nt = 12000;

            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);
            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma,alpha1,alpha2);
            

            InitCon1 = n(:,end);
    if InvType ==1
            InitCon2 = eps.* ones(length(a),1); %cons epsilon

    elseif InvType ==2
            InitCon2 = eps.*a.*exp(-a); %func eps
    end
            

            [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma,alpha1,alpha2); %ursula change
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state
            
            
             MUN = DeathFunction1(a,n(:,end),m(:,end),rho(:,end),Death1,alpha1,alpha2);
             MUM = DeathFunction2(a,m(:,end),n(:,end),rho(:,end),Death2,alpha1,alpha2);
            
             MUI = MUN(1);
             MUJ = MUM(1);
            
            %-----------------------------------------------------------
            %-----------------------------------------------------------
     %--------------------------------------------------------------------------
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
                
                    plot(t, trapz(a,diag(rho)*m,1),'c','DisplayName','introduced sp (sp i) total density - Num','LineWidth',2.0)        
                    plot(t, trapz(a,diag(rho)*n,1),'m','DisplayName','resident (sp j) total density - Num','LineWidth',2.0)      
                    
            
            
         
            
            legend('FontSize',20,'Location','best')
                    legend show
            
          str = sprintf('Total Density over Time,  %s = %g , %s = %g , %s = %g, %s = %g , %s = %g .','\mu_j',Death1,'b_j',Birth1,'\mu_i',Death2,'b_i',Birth2,'\gamma',gamma);
            title(str,'FontSize',18);
             %axis([0 2 0 20.*10^(-6)]) 
            xlabel('time','FontSize',20)
            ylabel('Species','FontSize',20)
            
            hold off;
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of total density of invader over time end        %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
%             
            
            %------------------------------------------------------------------------
            
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %         New figure Rainey start            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
            fig7= figure();
            set(gca,'fontname','times')
            hold on
            plot(a, n(:,end),'m', 'DisplayName','resident (sp j) density - Num','LineWidth',2.0)
            plot(a, m(:,end),'c','DisplayName','introduced sp (sp i) density - Num','LineWidth',2.0)
%             plot(a, SI./Death1 .*(1-exp(-Death1.*a)),'r--','DisplayName','resident (sp j) eq dens - Theo', 'LineWidth',2.0)
%             plot(a, SJ./Death2 .*(1-exp(-Death2.*a)),'b--','DisplayName','introduced sp (sp i) eq dens - Theo','LineWidth',2.0)
            
            legend show

            str = sprintf('Density over age,  %s = %g , %s = %g , %s = %g, %s = %g , %s = %g .','\mu_j',Death1,'b_j',Birth1,'\mu_i',Death2,'b_i',Birth2,'\gamma',gamma);
            title(str,'FontSize',18);
            xlabel('age','FontSize',20)
            ylabel('Density','FontSize',20)
            legend('FontSize',20,'Location','south')

%              axis([0 20 0 1]);
            xlim([0 10])
            hold off;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %          New Figure Rainey end              %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            


clearvars;

toc
