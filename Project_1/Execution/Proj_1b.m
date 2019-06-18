%% ----------------- K Sensitivity tests ----------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]); 
global tau M_d K K_dth T_m rho_v rho_w

tF = 1.5;
K_dth = 0.05;
MP = 1; NMP = -1;
K = 0.2
parameters(MP)
resolution = 30;
K_r=linspace(0.02, 0.8, resolution);

hold on;
for i=1:length(K_r)
    clear sim
    K = K_r(i);
    sim('Project_1');
    plot(sim.Time(2:end), sim.Data(2:end), '-');
%     vec(i,:) = sim.Data(2:end);
end
hold off;

        %% ***************** Span the Values ******************* % 

t=sim.Time(2:end);
A = nan( length(K_r), length(vec) );

for i=1:length(K_r)
    A(i,:) = vec(i,:);
end

set(gca, 'XTickLabel', t);
set(gca, 'YTickLabel', K_r);
surf(t, K_r , A);
%% **************************** Latex Graphs ****************************** %
ind(1) = title( 'Step Response Vs. $K(t)$', 'fontsize', 18 );
ind(2) = ylabel('Amplitude', 'fontsize', 14 );
ind(3) = xlabel('Time [sec]', 'fontsize', 14 );
% ind(4) = ylabel('K', 'fontsize', 14 );
set(ind, 'Interpreter', 'latex');