tic;

F = 2;

% Updated for Fig 4 on Sept 18 2024
% for F = 1:1
if F==1
        %________PARAMETER (4b)______%
           Birth1 = 2.34; %resident
           Death1 = 0.4; %resident

           Birth2 = 31; %invader
           Death2 = 10;  %invader

           alpha1 = 1; %resident 
           alpha2 = 1; %invader

           gamma = 1;
        %________PARAMETER (a)_______%

elseif F==2
        %________PARAMETER (4d)______%
           Birth1 = 2.34; %resident
           Death1 = 0.4; %resident

           Birth2 = 12; %invader
           Death2 = 0.4;  %invader

           alpha1 = .75; %resident 
           alpha2 = 10; %invader

           gamma =1;

           % If we change alpha1 from .75 to .77 we get the higher
           % reproducing species to be the most abundant.
        %________PARAMETER (b)_______%


end
            tmax = 400; 
            amax = 80;

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
if F==1                        
            hold on
           p =  plot(a, n(:,end),'r', 'DisplayName','High Survival Species','LineWidth',2.0);
%             p =  plot(a, n(:,end),'r', 'DisplayName','Robust Adult-Survival Species','LineWidth',2.0);
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
elseif F==2
                hold on
%            p =  plot(a, n(:,end),'r', 'DisplayName','High Survival Species','LineWidth',2.0);
            p =  plot(a, n(:,end),'r', 'DisplayName','Robust Adult-Survival Species','LineWidth',2.0);
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
end
          
clearvars;
% end


toc




% elseif F==3
% 
%          %________PARAMETER (c)______%
%            Birth1 = 2.34; %resident
%            Death1 = 0.4; %resident
%            Death2 = 0.4;  %invader
% 
%            Birth2 = 10; %invader
% 
%            alpha1 = .76; %resident 
%            alpha2 = 8; %invader
% 
%            % If we change alpha1 from .77 to .76 again the higher
%            % reproducing species dips to lower abundance.
%         %________PARAMETER (c)_______%
%    
% elseif F==4
%          %________PARAMETER (d)______%
%            Birth1 = 2.34; %resident
%            Death1 = 0.4; %resident
%           
%            Death2 = 8;  %invader %Low Reproducing more abundant
%            Birth2 = 25; %invader
% 
% %            Death2 = 6;  %invader %High reproducing more abundant
% %            Birth2 = 20; %invader
% 
% %            Death2 = 10;  %invader %Low Reproducing more abundant
% %            Birth2 = 30; %invader
% 
%            alpha1 = 1; %resident 
%            alpha2 = 1; %invader
% 
%            % If we change alpha1 and alpha2 to 1's and look at the
%            % coexistence region in fig2c.
%         %________PARAMETER (d)_______%
% 
%         elseif F==5
% 
%          %________PARAMETER (c)______%
%            Birth1 = 2.34; %resident
%            Death1 = 0.4; %resident
%            Death2 = 11;  %invader
% 
%            Birth2 = 32; %invader  %high survival label%
% 
%            alpha1 = 1; %resident 
%            alpha2 = 1; %invader
%         %________PARAMETER (c)_______%
