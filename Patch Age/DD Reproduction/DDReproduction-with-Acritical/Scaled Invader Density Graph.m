tic;


for F = 1:1

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
             
            colororder(leftcolors)

            hold on 

            y=[.1,1.6];
            x=[5,8];
            sz = 100;
            colormap(leftcolors)


            h = colorbar;

            h.Label.String = "Time";
            h.Label.Rotation = 270;
            h.Label.VerticalAlignment = "bottom";
            h.Label.FontSize = 20;
            
            %---------- array for colors--------------------------------------------------------------
            hold on

             %-----------fixed parameters equilibrium distribution-----------------------
            
            plot(a,SJ./MUJ.*(1-exp(-MUJ.*a))./(SJ./MUJ.*(1-exp(-MUJ.*20))),'k--','DisplayName','Equilibrium Distribution ','LineWidth',2.0) 
             %-----------fixed parameters equilibrium distribution-----------------------
            
            axis([0 6 0 1.2]) 
            
            legend('FontSize',20,'Location','best')
         
          set(gca,'fontname','times')
            
            xlabel('Patch Age a','FontSize',20)
            ylabel('Scaled Invader Density','FontSize',20)
            
            hold off;
            

            %%
             fig6 = figure();
             set(gca,'fontname','times')
              hold on;
                    dt = tmax/Nt;
                    t = 0:dt:tmax;
                
                    plot(t, trapz(a,diag(rho)*m,1),'k','DisplayName','introduced sp (sp i) total density - Num','LineWidth',2.0)        

            Trapz1 =trapz(a,rho.*(SI./MUI).*(1-exp(-MUI.*a))).*ones(length(t),1);
            Trapz2 = trapz(a,rho./MUJ.*SJ.*(1-exp(-MUJ.*a))).*ones(length(t),1);

             axis([0 10 0 11.*10^(-6)]) 
            xlabel('Time','FontSize',20)
            ylabel('Average Invader Density N_i','FontSize',20)
            
            hold off;


clearvars;
end


toc

