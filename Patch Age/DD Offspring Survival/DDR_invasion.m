tic;

f = datetime('now');
disp(f);

% F = 5; % param sets


for F = 2:2 
    if F ==2
%         %________PARAMETER (a)______%
             Birth2 = 30.2; %invader
             Death2 = 1;  %invader
            % 
             Birth1 = 5; %resident
             Death1 = 1;   %resident

             alpha1 = 0.2;
             alpha2 = 0.301;
%             %________PARAMETER (a)_______%
    elseif F==3
%             % % %________PARAMETER (b)______%
             Birth2 = 18; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident

             alpha1 = 1;
             alpha2 = 1;
%             % % %________PARAMETER (b)_______%
    elseif F==4
%             % %________PARAMETER (c)______%
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 4.5; %resident
             Death1 = 1;   %resident

             alpha1 = 1;
             alpha2 = 1;
%             % %________PARAMETER (c)_______%
    elseif F==5
%             % %________PARAMETER (d)______%
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 =4.5; %resident
             Death1 = 1;   %resident

             alpha1 = 1;
             alpha2 = 1;
%             % %________PARAMETER (d)_______%
% 
    
    end

            tmax = 400; 
            amax = 80;

            gamma = 0.5;
            eps = 10^(-6);
            InvType = 2;
            
            Na = 800;
            Nt = 12000;
            da = amax/Na;
            a = 0:da:amax;
            initcon = 2.*exp(-2*a);

            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma,alpha1,alpha2);
            
            
            InitCon1 = n(:,end);
            InitCon2 = eps.*a.*exp(-a); %func eps
           
            
            
            [n,m,SI,SJ] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,InvType,gamma,alpha1,alpha2); %ursula change
            disp(SI);
            disp(SJ);
            
            rho =gamma.*exp(-gamma.*a'); % rho at steady-state
            
            
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
            
            
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %         New figure start            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%
            fig7= figure();
            hold on
            plot(a, n(:,end),'r', 'DisplayName','High Survival Species','LineWidth',2.0)
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
            %          New Figure Rainey end              %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
            %--------------------------------------------------------------------------

            


clearvars;
end

toc

