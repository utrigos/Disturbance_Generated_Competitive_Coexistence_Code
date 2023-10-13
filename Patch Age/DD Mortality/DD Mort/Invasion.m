tic;

f = datetime('now');
disp(f);



% for mycount = 6:9
mycount = 6;

tmax = 400; 
amax = 80;

    if mycount ==1 || mycount ==6
            %________PARAMETER (a)______%
            Birth1 = 2.34; %resident
            Death1 = 0.4;   %resident

            Birth2 = 25;
            Death2 = 8.3;

            %________PARAMETER (a)_______%
            
    elseif mycount ==2 || mycount ==7        
            % % %________PARAMETER (b)______%
            Birth1 = 5.6; %resident
            Death1 = 1;   %resident

            Birth2 = 33;
            Death2 =7.3;
            % % %________PARAMETER (b)_______%
            
    elseif mycount ==3 || mycount ==8        
            % %________PARAMETER (c)______%
             Birth1 = 6.8; %resident
             Death1 = 2;   %resident

             Birth2 = 32.5;
             Death2 = 11.2;
            % %________PARAMETER (c)_______%
            
    elseif mycount ==4 || mycount ==9       
            % %________PARAMETER (d)______%
             Birth1 = 9; %resident
             Death1 = 2;   %resident
             
             Birth2 = 33.8;
             Death2 = 8.3;
            % %________PARAMETER (d)_______%
    end

if mycount <6
    InvType = 1;
elseif mycount > 5 
    InvType =2;
end



            gamma = 1;
            eps = 10^(-5);
            
            Na = 800;
            Nt = 12000;

            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);
            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma);
            

            InitCon1 = n(:,end);
    if InvType ==1
            InitCon2 = eps.* ones(length(a),1); %cons epsilon

    elseif InvType ==2
            InitCon2 = eps.*a.*exp(-a); %func eps
    end
            
            
           
            [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma); 
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state
            
            
             MUN = DeathFunction1(a,n(:,end),m(:,end),rho(:,end),Death1);
             MUM = DeathFunction2(a,m(:,end),n(:,end),rho(:,end),Death2);
            
             MUI = MUN(1);
             MUJ = MUM(1);
            
 
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
                    
            
            
            
            %-----------fixed parameters equilibrium distribution-----------------------

            
            
            % %------
%             Trapz1 =trapz(a,rho.*(SI./MUI).*(1-exp(-MUI.*a))).*ones(length(t),1);
%             Trapz2 = trapz(a,rho./MUJ.*SJ.*(1-exp(-MUJ.*a))).*ones(length(t),1);
%             plot(t,Trapz1,'r--','DisplayName','resident (sp j) Total Eq Dens - Theo ','LineWidth',2.0)
%             plot(t,Trapz2,'b--','DisplayName','introduced sp (sp i) Total Eq Dens - Theo ','LineWidth',2.0)
            
            
            % %-----------fixed parameters equilibrium distribution-----------------------
            
            legend('FontSize',20,'Location','best')
                    legend show
            
            str = sprintf('Total Density over Time,  %s = %g , %s = %g , %s = %g, %s = %g , %s = %g .','\mu_j',Death1,'b_j',Birth1,'\mu_i',Death2,'b_i',Birth2,'\gamma',gamma);
            title(str,'FontSize',18);

            xlabel('time','FontSize',20)
            ylabel('Species','FontSize',20)
            
            hold off;
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %      2D plot of total density of invader over time end        %
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
            
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
            %          New Figure end              %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            


clearvars;

toc
