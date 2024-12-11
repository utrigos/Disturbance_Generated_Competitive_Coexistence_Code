tic;

f = datetime('now');
disp(f);


for F = 3:3
    %% fig 2,3 (UPDATED SEP 4 2024)
    if F==1
%             % %________PARAMETER (2b)______%
             Birth2 = 19.5; %invader  
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident 
             Death1 = 1;   %resident

             gamma = 1;

             Salpha1 = 1; % reproduction alpha resident
             Salpha2 = 1;  % reproduction alpha invader

             Ralpha1 = 0; % offspring survival alpha resident
             Ralpha2 = 0;  % offspring survival alpha invader
%             % %________PARAMETER (2b)_______%
    elseif F==2
%             % %________PARAMETER (2d)______%
             Birth2 = 30; %invader  
             Death2 = 4;  %invader
            % 
             Birth1 = 30; %resident 
             Death1 = 10;   %resident

             gamma = 2.5;

             Salpha1 = .735; % reproduction alpha resident
             Salpha2 = 1;  % reproduction alpha invader

             Ralpha1 = 0; % offspring survival alpha resident
             Ralpha2 = 0;  % offspring survival alpha invader
%             % %________PARAMETER (2d)_______%
 elseif F==3
%             % %________PARAMETER (3b)______%
             Birth2 = 35; %invader  
             Death2 = 1;  %invader
            % 
             Birth1 = 5; %resident 
             Death1 = 1;   %resident

             gamma = 1;

             Salpha1 = 0; % reproduction alpha resident
             Salpha2 = 0;  % reproduction alpha invader

             Ralpha1 = 0.2; % offspring survival alpha resident
             Ralpha2 = 0.325;  % offspring survival alpha invader
%             % %________PARAMETER (3b)_______%


    end

            tmax = 400; 
            amax = 80;
    
            eps = 10^(-5);
            
            Na = 800;
            Nt = 12000;
            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);

            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma,Salpha1,Salpha2,Ralpha1,Ralpha2);
            
            InitCon1 = n(:,end);
            InitCon2 = eps.*a.*exp(-a); %func eps
            
            
            [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma,Salpha1,Salpha2,Ralpha1,Ralpha2); %ursula change
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state
            
            
             MUN = DeathFunction1(a,n(:,end),m(:,end),rho(:,end),Death1);
             MUM = DeathFunction2(a,m(:,end),n(:,end),rho(:,end),Death2);
            
             MUI = MUN(1);
             MUJ = MUM(1);
            


%% Looking for where 1-ni-nj = 0 for critical age value
Q =1 -Ralpha2*m(:,end)-Ralpha2*n(:,end);
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
        
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %                   Fig 5 a b            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if F == 1
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

   elseif F == 2
            %%
            fig7= figure();
            hold on
           p =  plot(a, n(:,end),'r', 'DisplayName','Robust Reproduction Species','LineWidth',2.0);
           p.LineStyle = '--';
            plot(a, m(:,end),'b','DisplayName','Higher Survival Species','LineWidth',2.0)
            
            legend show

            xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
            ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
            legend('FontSize',20,'Location','best','Interpreter', 'latex')

            set(gca,'fontname','times')
            
            hold off
            xlim([0 10])

            hold off;

      elseif F == 3
            %%
            fig7= figure();
            hold on
           p =  plot(a, n(:,end),'r', 'DisplayName','Robust Offspring Survival Species','LineWidth',2.0);
           p.LineStyle = '--';
            plot(a, m(:,end),'b','DisplayName','Higher Reproduction Species','LineWidth',2.0)
            
            legend show

            xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
            ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
            legend('FontSize',20,'Location','best','Interpreter', 'latex')

            set(gca,'fontname','times')
            
            hold off
            xlim([0 10])

            hold off;

  

   end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %          Fig 5 a b end             %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
           

clearvars;
end

toc


% % Past Parameters
%   elseif F==4
% %             % %________PARAMETER (4b)______%
%              Birth2 = 14; %invader  
%              Death2 = 8;  %invader
%             % 
%              Birth1 = 2.34; %resident 
%              Death1 = 0.4;   %resident
% 
%              gamma = 1;
% 
%              Salpha1 = 1; % reproduction alpha resident
%              Salpha2 = 1;  % reproduction alpha invader
% 
%              Ralpha1 = 0; % offspring survival alpha resident
%              Ralpha2 = 0;  % offspring survival alpha invader
% %             % %________PARAMETER (4b)_______%
%  elseif F==5
% %             % %________PARAMETER (4d)______%
%              Birth2 = 12; %invader  
%              Death2 = 0.4;  %invader
%             % 
%              Birth1 = 2.34; %resident 
%              Death1 = 0.4;   %resident
% 
%              gamma = 1;
% 
%              Salpha1 = 0; % reproduction alpha resident
%              Salpha2 = 0;  % reproduction alpha invader
% 
%              Ralpha1 = 0.75; % offspring survival alpha resident
%              Ralpha2 = 2;  % offspring survival alpha invader
% %             % %________PARAMETER (4d)_______%
%   elseif F==6
% %             % %________PARAMETER (4d)______%
%              Birth2 = 12; %invader  
%              Death2 = 0.4;  %invader
%             % 
%              Birth1 = 2.34; %resident 
%              Death1 = 0.4;   %resident
% 
%              gamma = 1;
% 
%              Salpha1 = 0; % reproduction alpha resident
%              Salpha2 = 0;  % reproduction alpha invader
% 
%              Ralpha1 = 0.75; % offspring survival alpha resident
%              Ralpha2 = 2;  % offspring survival alpha invader
% %             % %________PARAMETER (4d)_______%
%        
% %             % % %________PARAMETER (a)______%
%              Birth2 = 18; %invader      
%              Death2 = 7;  %invader
%             % 
%              Birth1 = 5.6; %resident
%              Death1 = 1;   %resident
% 
%              Salpha1 = 1; % reproduction alpha resident
%              Salpha2 = 1; % reproduction alpha invader
% 
%              Ralpha1 = 0; % offspring survival alpha resident
%              Ralpha2 = 0; % offspring survival alpha invader
% 
%              gamma = 1;
% %             % % %________PARAMETER (a)_______%
%     %% fig 4b
%     elseif F==2
% %             % %________PARAMETER (b)______%
%              Birth2 = 90; %invader  %fig 4b
%              Death2 = 7;  %invader
%             % 
%              Birth1 = 4.5; %resident
%              Death1 = 1;   %resident
% 
%              Salpha1 = 1; % reproduction alpha resident
%              Salpha2 = 1;  % reproduction alpha invader
% 
%              Ralpha1 = 1; % offspring survival alpha resident
%              Ralpha2 = 3;  % offspring survival alpha invader
% %             % %________PARAMETER (b)_______%
%     %% editing fig 4a birth2 from 18 to 20.
%     %% high reproduction species is more abundant.
%     elseif F==3
% %             % % %________PARAMETER (a)______%
%              Birth2 = 20; %invader %% high reproduction species is most abundant (fig 4a edited)
%              Death2 = 7;  %invader
%             % 
%              Birth1 = 5.6; %resident
%              Death1 = 1;   %resident
% 
%              Salpha1 = 1; % reproduction alpha resident
%              Salpha2 = 1; % reproduction alpha invader
% 
%              Ralpha1 = 0; % offspring survival alpha resident
%              Ralpha2 = 0; % offspring survival alpha invader
% %             % % %________PARAMETER (a)_______%
% %% editing fig 4b birth2 from 90 to 120 and Death2 from 7 to 3.
% %% high reproduction species is more abundant.
%     elseif F==4
%             % %________PARAMETER (c)______%
%              Birth2 = 45; %invader %% high reproduction species is most abundant (fig 4b edited)
%              Death2 = 1;  %invader
%             % 
%              Birth1 = 5; %resident
%              Death1 = 1;   %resident
% 
%              Salpha1 = 0; % reproduction alpha resident
%              Salpha2 = 0;  % reproduction alpha invader
% 
%              Ralpha1 = 0.2; % offspring survival alpha resident
%              Ralpha2 = 0.3;  % offspring survival alpha invader
% %             % %________PARAMETER (c)_______%
%     elseif F==5
% %             % %________PARAMETER (b)______%
%              Birth2 = 20; %invader  
%              Death2 = 5.5;  %invader
%             % 
%              Birth1 = 2.34; %resident 
%              Death1 = 0.4;   %resident
% 
%              Salpha1 = 1; % reproduction alpha resident
%              Salpha2 = 1;  % reproduction alpha invader
% 
%              Ralpha1 = 0; % offspring survival alpha resident
%              Ralpha2 = 0;  % offspring survival alpha invader
% %             % %________PARAMETER (b)_______%
%  elseif F == 4
%             %%
%             fig7= figure();
%             hold on
%            p =  plot(a, n(:,end),'r', 'DisplayName','High Survival Species','LineWidth',2.0);
%            p.LineStyle = '--';
%             plot(a, m(:,end),'b','DisplayName','High Reproduction Species','LineWidth',2.0)
%             
%             legend show
% 
%             xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
%             ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
%             legend('FontSize',20,'Location','best','Interpreter', 'latex')
% 
%             set(gca,'fontname','times')
%             
%             hold off
%             xlim([0 10])
% 
%             hold off;
% 
%    elseif F==5
%           %%
%             fig7= figure();
%             hold on
%            p =  plot(a, n(:,end),'r', 'DisplayName','Robust Adult Survival Species','LineWidth',2.0);
%            p.LineStyle = '--';
%             plot(a, m(:,end),'b','DisplayName','Higher Reproduction Species','LineWidth',2.0)
%             
%             legend show
% 
%             xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
%             ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
%             legend('FontSize',20,'Location','best','Interpreter', 'latex')
% 
%             set(gca,'fontname','times')
%             
%             hold off
%             xlim([0 10])
% %             ylim([0 1])
% 
%             hold off;
% elseif F==6
%           %%
%             fig7= figure();
%             hold on
%            p =  plot(a, n(:,end),'r', 'DisplayName','Robust Adult Survival Species','LineWidth',2.0);
%            p.LineStyle = '--';
%             plot(a, m(:,end),'b','DisplayName','Higher Reproduction Species','LineWidth',2.0)
%             
%             legend show
% 
%             xlabel('Patch Age $a$','FontSize',20,'Interpreter', 'latex')
%             ylabel('Density $n_i(a)$','FontSize',20,'Interpreter', 'latex')
%             legend('FontSize',20,'Location','best','Interpreter', 'latex')
% 
%             set(gca,'fontname','times')
%             
%             hold off
%             xlim([0 10])
% %             ylim([0 1])
% 
%             hold off;
