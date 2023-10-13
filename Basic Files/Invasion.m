tic;

tmax = 400;
amax = 20;

Birth2 = 20; %invader
Death2 = 6;
Birth1 = 2.34; %res
Death1 = 0.4;

gamma =0.2;
eps = 10^(-5);

Na = 400;
Nt = 12000;
da = amax/Na;
a = 0:da:amax;
initcon = 2.*exp(-2*a);

n = OneSpecies(Na,Nt,initcon,amax, tmax,Birth1,Death1,gamma);

InitCon1 = n(:,end);
InitCon2 = eps.* ones(length(a),1);


[n,m,R1,R2] = TwoSpecies(Na,Nt,amax,tmax,InitCon1,InitCon2,Birth1,Death1,Birth2,Death2,gamma);
toc