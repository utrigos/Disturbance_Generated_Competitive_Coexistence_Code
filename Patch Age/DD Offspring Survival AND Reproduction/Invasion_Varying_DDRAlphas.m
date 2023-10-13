tic;

part = 1; %selects parameters


%%

f = datetime('now');
disp(f);

ralph = 1; %invader alpha
step = 2; %multiplies Na and Nt
%%

if part ==1
%         %________PARAMETER (a)______%
                % Successional Niche
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 46.5; %resident
             Death1 = 3;   %resident

             Salpha1 = 1;
             Salpha2 = 1;
             Ralpha1 = 1;
             Ralpha2 = ralph;
%         %________PARAMETER (a)_______%

elseif part ==2
%         %________PARAMETER (a)______%
                % Successional Niche but invader is higher at low ages
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 4.5; %resident
             Death1 = 1;   %resident

             Salpha1 = 1;
             Salpha2 = 1;
             Ralpha1 = 1;
             Ralpha2 = ralph;
%         %________PARAMETER (a)_______%

elseif part ==3
%         %________PARAMETER (a)______%
                % NOT Successional Niche 
             Birth2 = 19; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident

             Salpha1 = 1;
             Salpha2 = 1;
             Ralpha1 = 0;
             Ralpha2 = ralph;
%         %________PARAMETER (a)_______%

elseif part ==4
%         %________PARAMETER (a)______%
                % NOT Successional Niche DD Seed only
             Birth2 = 18; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 5.6; %resident
             Death1 = 1;   %resident

             Salpha1 = 1;
             Salpha2 = 1;
             Ralpha1 = 0;
             Ralpha2 = ralph;
%         %________PARAMETER (a)_______%

elseif part ==5
%         %________PARAMETER (a)______%
                % Successional Niche but invader is higher at low ages
             Birth2 = 90; %invader
             Death2 = 7;  %invader
            % 
             Birth1 = 4.5; %resident
             Death1 = 1;   %resident

             Salpha1 = 1;
             Salpha2 = 1;
             Ralpha1 = 1;
             Ralpha2 = ralph;
%         %________PARAMETER (a)_______%

end
            tmax = 400; 
            amax = 80;

            gamma = 1;
            eps = 10^(-5);
            
            Na = 800.*step;
            Nt = 12000.*step;
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

                    dt = tmax/Nt;
                    t = 0:dt:tmax;
                

            Trapz1 =trapz(a,rho.*(SI./MUI).*(1-exp(-MUI.*a))).*ones(length(t),1);
            Trapz2 = trapz(a,rho./MUJ.*SJ.*(1-exp(-MUJ.*a))).*ones(length(t),1);


            %%
            fig7= figure();
            hold on
            plot(a, m(:,end),'b','DisplayName','invader (sp i) density','LineWidth',2.0)
            plot(a, n(:,end),'r', 'DisplayName','resident (sp j) density','LineWidth',2.0)
           

            legend show
            str = sprintf('Density %s = %g , %s = %g , %s = %g , %s = %g , %s = %g , %s = %g , %s = %g.','\mu_j',Death1,'b_j',Birth1,'\mu_i',Death2,'b_i',Birth2,'\gamma',gamma,'\alpha_R_r_e_s',Ralpha1,'\alpha_R_i_n_v',ralph);
            title(str,'FontSize',14);

            xlabel('Patch-Age Since Disturbance','FontSize',20)
            ylabel('Density','FontSize',20)
            legend('FontSize',20,'Location','best')
            xlim([0 10])
            hold off;




clearvars;



toc

