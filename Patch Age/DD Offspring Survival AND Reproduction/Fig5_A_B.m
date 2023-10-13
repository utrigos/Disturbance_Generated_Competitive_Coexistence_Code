tic;

f = datetime('now');
disp(f);


for F = 1:2 
    if F==1
%             % % %________PARAMETER (b)______%
             Birth2 = 18; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident

             Salpha1 = 1; % reproduction alpha resident
             Salpha2 = 1; % reproduction alpha invader
             Ralpha1 = 0; % offspring survival alpha resident
             Ralpha2 = 0; % offspring survival alpha invader
%             % % %________PARAMETER (b)_______%
    elseif F==2
%             % %________PARAMETER (c)______%
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 4.5; %resident
             Death1 = 1;   %resident

             Salpha1 = 1; % reproduction alpha resident
             Salpha2 = 1;  % reproduction alpha invader
             Ralpha1 = 1; % offspring survival alpha resident
             Ralpha2 = 3;  % offspring survival alpha invader
%             % %________PARAMETER (c)_______%

    
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
        
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %                   Fig 5 a b            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
            fig7= figure();
            hold on
           p =  plot(a, n(:,end),'r', 'DisplayName','Robust Offspring Survival Species','LineWidth',2.0);
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
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %          Fig 5 a b end             %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
           

clearvars;
end

toc

