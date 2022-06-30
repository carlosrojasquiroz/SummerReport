function sim=figureresults(p,d,v,f,frcsim)
Warm=[234, 84, 85]/255;
DarkBlue=[134 184 235]/255;
%---------------------------------------------------------------------------------------------------------------------------
zdefT=min((1-f.chiTopt0)*mean(v.z),v.z);
zdefN=min((1-f.chiNopt0)*mean(v.z),v.z);
zLossT=(zdefT-v.z)./v.z;
zLossN=(zdefN-v.z)./v.z;
%---------------------------------------------------------------------------------------------------------------------------
figure(1)
plot(v.z, zdefT,'LineWidth',3.5,'Color',Warm);
hold on
plot(v.z, zdefN,'LineWidth',3.5,'Color',DarkBlue);
grid on;
c=gca;
c.FontSize=20; 
xlim([v.z(1) v.z(end)]);
xlabel('$z$','FontSize',20,'Interpreter','latex')
ylabel('$z^{i,d}(z)$','FontSize',20,'Interpreter','latex')
legend('Tradable','Nontradable','FontSize',18,'Location','Best','interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Figures', 'CF01.eps');
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
figure(2)
plot(v.z, zLossT,'LineWidth',3.5,'Color',Warm);
hold on
plot(v.z, zLossN,'LineWidth',3.5,'Color',DarkBlue);
grid on;
c=gca;
c.FontSize=20; 
xlim([v.z(1) v.z(end)]);
xlabel('$z$','FontSize',20,'Interpreter','latex')
ylabel('$\frac{z^{i,d}(z)-z}{z}$','FontSize',20,'Interpreter','latex')
legend('Tradable','Nontradable','FontSize',18,'Location','Best','interpreter','latex')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Figures', 'CF02.eps');
ax=gcf;
exportgraphics(ax, filename);
%---------------------------------------------------------------------------------------------------------------------------
p.chi1_T= f.chiTopt0;
p.chi1_N= f.chiNopt0;
[v.idB,v.idD,v.q]=vfi(p,v);
sim=simulation(p,v);
v.DeltaSim0=estimationsim(p,sim);
sim.idB0=v.idB;
sim.idD0=v.idD;
sim.q0=v.q;
sim.DeltaSim0=v.DeltaSim0;
%---------------------------------------------------------------------------------------------------------------------------
p.chi1_T= f.chiTopt4;
p.chi1_N= f.chiNopt4;
[v.idB,v.idD,v.q]=vfi(p,v);
r2=simulation(p,v);
v.DeltaSim4=estimationsim(p,r2);
%---------------------------------------------------------------------------------------------------------------------------
TT=-d.Nhorz:1:d.Nhorz;
irf=d.DeltaHat(1,:);
stdev=d.StdevDelta(1,:);
irf2=[v.DeltaSim0(1,:); v.DeltaSim4(1,:); frcsim.DeltaSim0(1,:)];
visualize2(TT,irf,stdev,irf2,'TradableResults.eps','TradableBar.eps',3,0)
%
irf=d.DeltaHat(2,:);
stdev=d.StdevDelta(2,:);
irf2=[v.DeltaSim0(2,:); v.DeltaSim4(2,:); frcsim.DeltaSim0(2,:)];
visualize2(TT,irf,stdev,irf2,'NontradableResults.eps','NontradableBar.eps',4,0)
%
irf=d.DeltaHat(3,:);
stdev=d.StdevDelta(3,:);
irf2=[v.DeltaSim0(3,:); v.DeltaSim4(3,:); frcsim.DeltaSim0(3,:)];
visualize2(TT,irf,stdev,irf2,'GDPResults.eps','GDPBar.eps',5,0)
%
irf=d.DeltaHat(4,:);
stdev=d.StdevDelta(4,:);
irf2=[v.DeltaSim0(4,:); v.DeltaSim4(4,:); frcsim.DeltaSim0(4,:)];
visualize2(TT,irf,stdev,irf2,'ConsumptionResults.eps','ConsumptionBar.eps',6,0)
%
irf=d.DeltaHat(5,:);
stdev=d.StdevDelta(5,:);
irf2=[v.DeltaSim0(5,:); v.DeltaSim4(5,:); frcsim.DeltaSim0(5,:)];
visualize2(TT,irf,stdev,irf2,'RERResults.eps','RERBar.eps',7,1)
%
irf=d.DeltaHat(6,:);
stdev=d.StdevDelta(6,:);
irf2=[v.DeltaSim0(6,:); v.DeltaSim4(6,:); frcsim.DeltaSim0(6,:)];
visualize2(TT,irf,stdev,irf2,'NXResults.eps','NXBar.eps',8,1)
%---------------------------------------------------------------------------------------------------------------------------
end