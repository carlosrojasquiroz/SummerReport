function visualize2(time,irf,stdev,irf2,name,name2,nF,Indica)
LI=irf-1.96*stdev;
LS=irf+1.96*stdev;
Warm=[234, 84, 85]/255;
Green=[33, 158, 50]/255;
Orange=[246,120, 40]/255;
LightBlue=[192 228 255]/255;
Gray=[65, 65,65]/255;
[~,Nc]=size(irf);
Nhorz=(Nc-1)/2;
%---------------------------------------------------------------------------------------------------------------------------
% Chart
%---------------------------------------------------------------------------------------------------------------------------
figure(nF)
a1=plot(time,irf,'-o','LineWidth',3.5,'Color',Warm);
hold on;
grid on;
a2=plot(time,LI,'--','LineWidth',2.5,'Color',LightBlue,'HandleVisibility','off');
a3=plot(time,LS,'--','LineWidth',2.5,'Color',LightBlue,'HandleVisibility','off');
b1=plot(time,irf2(1,:),'-o','LineWidth',3.5,'Color',Green);
b2=plot(time,irf2(2,:),'-o','LineWidth',3.5,'Color',Orange);
b3=plot(time,irf2(3,:),'-.','LineWidth',2.5,'Color',Gray);
c=line(xlim,[0,0],'Color', 'k', 'LineWidth', 2,'HandleVisibility','off');
if Indica==0
ylim([-25 15]);
end
xline(0,'Color', 'k', 'LineWidth', 2,'HandleVisibility','off');
d=gca;
d.FontSize=20; 
xlabel('Crisis year + T','FontSize',20)
ylabel('log deviation from trend (%)','FontSize',20)
uistack(a2,'top')
uistack(a3,'top')
uistack(a1,'top')
uistack(b1,'top')
uistack(b2,'top')
uistack(b3,'top')
uistack(c,'top')
xticks(-Nhorz:1:Nhorz)
legend('Auxiliary model','$\hat{\delta}_{d,0}$','$\hat{\delta}_{d,4}$','$\chi^T=\chi^N$','interpreter','latex','Location','best')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Figures', name);
ax=gcf;
exportgraphics(ax, filename);

figure(nF+1)
e=bar(time,[irf2(1,:)-irf; irf2(2,:)-irf; irf2(3,:)-irf]);
e(1).FaceColor = Green;
e(2).FaceColor = Orange;
e(3).FaceColor = Gray;
grid on;
line(xlim,[0,0],'Color', 'k', 'LineWidth', 2,'HandleVisibility','off');
xline(0,'Color', 'k', 'LineWidth', 2,'HandleVisibility','off');
f=gca;
f.FontSize=20; 
xlabel('Crisis year + T','FontSize',20)
ylabel('deviations','FontSize',20)
xticks(-Nhorz:1:Nhorz)
legend('$\hat{\delta}_{d,0}$','$\hat{\delta}_{d,4}$','$\chi^T=\chi^N$','interpreter','latex','Location','best')
filename=fullfile('/Users/carlosrojasquiroz/Desktop/Summer Report/Master/Figures', name2);
ax=gcf;
exportgraphics(ax, filename);
close all;