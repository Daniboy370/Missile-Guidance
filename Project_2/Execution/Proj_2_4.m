%% --------------------------- Missile Parameters ------------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global tF rho_v rho_w M_d T_m Vc tau N K K_dth dt tout resolution
%%
% load('traj_unsat');
% ------------------- Initialize Simulation ------------------- %
MP = 1; NMP = -1; Dyn_sgn = [1 -1];
tF = 4;                     % Simulation Duration

for j=1:2
    parameters(Dyn_sgn(j));
    R_0 = Vc*tF;
    sim('Lambda_4');
    vec_m_1(j,:) = MD.data;
    tout = m_delta.Time;
end
% ------------------------ Miss Distance ------------------------ %
figure(2); grid on; hold on;% close all;
% semilogy(tout, vec_m_1, '-', 'LineWidth', 2);
plot(tout, vec_m_1, '-', 'LineWidth', 2);
grid on; %ylim([1e-2 1e6]); xlim([0 inf])
ind(1) = title( 'Miss Distance vs. $t_{go}$' );
ind(2) = ylabel('Miss Distance [m]'); % \frac{1}{sec^2}
ind(3) = xlabel('$Time$ [sec]');
ind(4) = legend('MP', 'NMP', '$MP_{sat}$', '$NMP_{sat}$');
set(gca,'XTickLabel', a, 'fontsize', 14);
a = get(gca,'XTickLabel');  
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

%% ------------------------- d_LOS rate -------------------------- %
figure(1); % close all; 
semilogy(tout, 33.79-57.29*d_sigma.Data, '-', 'LineWidth', 3);
% plot(tout, 57.29*d_sigma.Data, '-', 'LineWidth', 2);
grid on; % ylim([1 1e6]);
ind(1) = title( '$\dot{\sigma}$ vs. $t_{go}$' );
ind(2) = ylabel('$\dot{\sigma}$ [$\frac{deg}{sec}$]'); % \frac{1}{sec^2}
ind(3) = xlabel('$Time$ [sec]');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

%% ------------------------ Servo d_delta ------------------------ %
figure(3); hold on; % close all;
% semilogy(tout, -57.29*sigma.Data, '-', 'LineWidth', 2);
plot(tout, +57.29*m_delta.data, '-', 'LineWidth', 3);
plot(tout, -57.29*m_delta.data, '-', 'LineWidth', 3);

%%
grid on; hold on; box on;
plot(0:0.5:5, -5:1:5,'w');
plot(0:0.5:5, -5:1:5,'w');
ind(1) = title( '$\delta$ vs. $t_{go}$' );
ind(2) = ylabel('Parameter [...]');
ind(3) = xlabel('$Time$ [sec]');
ind(4) = legend('MP', 'NMP');
ind(5) = zlabel('Z Axis');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);
%%
ylim([-150 150]); 
plot(tout, 30*ones(length(tout),1), 'k--', 'LineWidth', 2)
plot(tout, -30*ones(length(tout),1), 'k--', 'LineWidth', 2)
%%
% view([-75 13]); % set(gca,'Ydir','reverse');
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',12,'FontWeight','bold');
% ind(1) = title( '$\delta$ Deflection Vs. $\tau$' );
% ind(2) = ylabel('$\tau$ [sec]'); % \frac{1}{sec^2}
% ind(3) = xlabel('$t_{go}$ [sec]');
% set(ind, 'Interpreter', 'latex', 'fontsize', 22);
