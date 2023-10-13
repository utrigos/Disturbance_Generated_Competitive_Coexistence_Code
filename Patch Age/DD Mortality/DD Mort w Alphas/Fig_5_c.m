tic;


        %________PARAMETER (a)______%
           Birth1 = 2.34; %resident
           Death1 = 0.4; %resident
           Death2 = 0.4;  %invader

            Birth2 = 10; %invader

            alpha1 = .75; %resident 
            alpha2 = 8; %invader
            %________PARAMETER (a)_______%
   

            tmax = 400; 
            amax = 80;


            gamma = 1;
            eps = 10^(-5);
            
            Na = 800;
            Nt = 12000;
            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);

            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma,alpha1,alpha2); 
            
            InitCon1 = n(:,end);

            InitCon2 = eps.*a.*exp(-a); %func eps
            
            
          [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma,alpha1,alpha2);  %ursula change
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state
            

            


               
       
            
            %--------------------------------------------------------------------------
            %%
            
                        fig7= figure();
            hold on
           p =  plot(a, n(:,end),'r', 'DisplayName','High Survival Species','LineWidth',2.0);
           p.LineStyle = '--';
            plot(a, m(:,end),'b','DisplayName','High Reproduction Species','LineWidth',2.0)
            
            legend show

            xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
            ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
            legend('FontSize',20,'Location','best','Interpreter', 'latex')

            set(gca,'fontname','times')
            
            hold off
            xlim([0 10])

            hold off;
            
          
clearvars;
%end


toc

