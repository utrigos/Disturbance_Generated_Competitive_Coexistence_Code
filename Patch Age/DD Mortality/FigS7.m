ri = 10;
Ni = 100;
mi = 0.1;
ai = 1;

a = 0:.001:1;
y = (1/2).*(((-1)+exp(1).^(a.*(mi.*(mi+4.*Ni.*ri)).^(1/2))).*mi+(1+ ...
  exp(1).^(a.*(mi.*(mi+4.*Ni.*ri)).^(1/2))).*(mi.*(mi+4.*Ni.*ri)).^( ...
  1/2)).^(-1).*(((-1)+exp(1).^(a.*(mi.*(mi+4.*Ni.*ri)).^(1/2))).*( ...
  mi+4.*Ni.*ri)+(1+exp(1).^(a.*(mi.*(mi+4.*Ni.*ri)).^(1/2))).*(mi.*( ...
  mi+4.*Ni.*ri)).^(1/2));

fig1 = figure()
plot(a,y,'LineWidth',2)

view(0,90)
grid off

set(gca,'fontname','times')

xlabel('Patch-Age $a$', 'FontSize',20, 'Interpreter','latex')
ylabel('Density of Species $i$', 'FontSize',20,'Interpreter','latex')
hold off

axis([0 1 0 101])