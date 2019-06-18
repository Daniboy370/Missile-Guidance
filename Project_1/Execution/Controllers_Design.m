%% ****************** System Design **************** %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global tau M_d K K_dth T_m rho_v rho_w

tF = 1.5;
MP = 1; NMP = -1;
sgn = MP;

parameters( sgn );
resolution = 8;
K_r_min = 0.01*sgn;
K_r_max = 0.3*sgn;
K_r = linspace(K_r_min, K_r_max, resolution);
   
% --------------- K Sensitivity --------------- %
A = tf([1 0 M_d],[tau 1 0 0]);
B = tf([K_dth*M_d 0], [1 0 M_d]);
G = feedback(A, B);

% ----------- Closed Loop Dynamics ------------ %

hold on;
for i=1:resolution
    G_OL = K_r(i)*G;
    G_CL = feedback(G_OL,1);
%     step(G_CL, tF );
    bode(G_OL);
end
hold off;

%% **************************** Latex Graphs ****************************** %
% ind(1) = title( 'MP - Step Response Vs. K $\quad (K_{\dot{\theta}} = 0.05)$') ;
% ind(2) = xlabel('Time [sec]');
% ind(3) = ylabel('Step Response');
% set(ind, 'Interpreter', 'latex', 'fontsize', 14 );
%% ------------- K_dth Sensitivity ------------- %
% A = tf( 1, [tau 1]);
% B = tf(M_d, [1 0]);
% rltool