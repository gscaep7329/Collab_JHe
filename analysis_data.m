% ------------------------------------------------------------------------
% xfguan, 12/21/2019
% log-linear model fitting
% ------------------------------------------------------------------------

clc; clearvars; close all;

d{1} = xlsread('data.xlsx','Sheet2','H3:I10'); 
d{2} = xlsread('data.xlsx','Sheet2','H11:I18');
d{3} = xlsread('data.xlsx','Sheet2','H19:I26');

% model y = b*x^a --> log-linear, ln(y) = ln(b)+a*ln(x)
p = zeros(3,2);
xi = linspace(0, 0.06, 100);
yi = cell(3,1);
for i=1:3
    p(i,:) = polyfit(log(d{i}(:,2)), log(d{i}(:,1)), 1);
    yi{i} = exp(polyval(p(i,:), log(xi)));
end
% linear scale (a,b) --> p(:,1), exp(p(:,2))
ab = [p(:,1), exp(p(:,2))];
lh = plot(d{1}(:,2),d{1}(:,1),'ok',xi, yi{1},'-k',...
    d{2}(:,2),d{2}(:,1),'sr',xi, yi{2},'-r', ...
    d{3}(:,2),d{3}(:,1),'^b',xi, yi{3},'-b');
set(lh,'linewidth',1.5);
lh = legend('AC13','AC13-fit','AC16','AC16-fit','SMA','SMA-fit');
set(lh,'location','northwest');
grid on;
xlabel('Energy (PJ)');
ylabel('Cummulative cracks per unit area (mm/mm^2)');


