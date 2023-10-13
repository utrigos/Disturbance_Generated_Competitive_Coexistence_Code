tic; %timing

f = datetime('now');
disp(f);


            tmax = 400;  
            amax = 20; 
            
            Na = 400; %These control accuracy of scheme. The OneSpecies function will print out a CFL value.
            Nt = 12000; %This value estimates the true CFL condition. Just make sure this value << 1.

            
            StepSizeB = 0.1; %This determine how many points are checked in the parameter sweep. Smaller = more points
            StepSizeD = 0.1; 
            
            %________PARAMETER (a)______%
%             Birth1 = 2.34; %resident
%             Death1 = 0.4;   %resident
            %________PARAMETER (a)_______%
            
            % % %________PARAMETER (b)______%
            Birth1 = 5.6; %resident
            Death1 = 0.6;   %resident
            % % %________PARAMETER (b)_______%
            
            % %________PARAMETER (c)______%
            % Birth1 = 6.8; %resident
            % Death1 = 0.7;   %resident
            % %________PARAMETER (c)_______%
            
            % %________PARAMETER (d)______%
            % Birth1 = 7.65; %resident
            % Death1 = 0.95;   %resident
            % %________PARAMETER (d)_______%
            
            
            
            gamma =1; %fixed Param
            
            da = amax/Na;
            a = (0:da:amax)';
            
            initcon = 2.*exp(-2*a);
            
            eps = 10^(-5); %Initial size for invader. Also used as extinction check tolerence.
            
            Birth2 = Birth1:StepSizeB:30; %Mesh for Birth and Death params. 
            Death2 = Death1:StepSizeD:8; %I scale these linearly, but they can have any upper bound.
            
            
            %=====================================
            Matrix = zeros(length(Birth2),length(Death2)); % These will store the results of the simulations
            Matrix2 = zeros(length(Birth2),length(Death2));
            
            n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma); %species j
            
            InitCon1 = n(:,end);
            
            InitCon2 = eps.* ones(length(a),1);
            InvType =1;

            
            rho =gamma.*exp(-gamma.*a); % rho at steady-state

            for i = 1:length(Birth2)
                for j = 1:length(Death2)
                    [n,m,R1,R2] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2(i),Death2(j),gamma);
                    if R1 >1 && R2>1
                        Matrix2(i,j) =1;
                    end
                    
                    if sum(da*rho.*m(:,end)) > eps
                        if sum(da*rho.*n(:,end))> eps
                            Matrix(i,j) = 1;
                        else
                            Matrix(i,j) = 2;
                        end
                    else
                        continue
                    end
                end
            end
            
            Matrix(Matrix == 0) = NaN; 
            Matrix(Matrix ~=1) = NaN;
            Matrix2(Matrix2 ==0) = NaN;



            
            
            %-----------------This is the Main Plot We Are Interested In----------- 
            
            fig1 = figure();
             surf(Death2,Birth2,Matrix,'DisplayName','Coex Region Cons Eps')
             %title('Invasion Parameter Sweep')
             xlabel('\mu_i')
             ylabel('b_i')
             view(0,90)
             
             hold on;
             % %line for mui at muj
             x = [Death1,Death1];
             y = [Birth1, 30];
             %z = [1,1];
             
             plot(x,y,'color','red','DisplayName','\mu_i=\mu_j & b_i=b_j');
             
             hold on 
             
             %line for bi = bj
             x1 = [Death1, 8 ];
             y1 = [Birth1, Birth1];
             %z1= [1,1];
             
             plot(x1,y1,'color','red','HandleVisibility','off');
             
             hold on 
             
             legend show
             
             if InvType==1
                str = sprintf('Coex Region w Cons %s ,  %s = %g , %s = %g  .','\epsilon','\mu_j',Death1,'b_j',Birth1);
             elseif InvType==2
                str = sprintf('Coex Region %s (a) ,  %s = %g , %s = %g .','\epsilon','\mu_j',Death1,'b_j',Birth1);
             end
            
%             
%             hold off
%             
%             %%In this figure you will see two regions. In one, both species seem to
%             %%coexist (blue on my version of MATLAB) and in the other the invader 
%             %%takes the resident (yellow on my version). If you would like to remove the
%             %%yellow region, uncomment out the line "Matrix(Matrix ~=1) = NaN;"
%             
%             %-----------------------Main Plot End------------------------------
            

f = datetime('now');
disp(f);
fprintf('%g mesh\n',StepSizeB)

toc;


