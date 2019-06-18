%% ---------------------- Find t_f per given d_lmbda ---------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
syms t_go

d_lmbda = 0.022;    lambda_0 = deg2rad(0);   D_rho = 5*10; 
r0 = 1.5e4;          dr0 = -1280;

r = r0*[cos(lambda_0) sin(lambda_0)]; 
dr = [dr0*cos(lambda_0)-r0*d_lmbda*sin(lambda_0), ...
    dr0*sin(lambda_0)+r0*d_lmbda*cos(lambda_0)];

Eq_jump  = 0.25*D_rho^2*t_go^4 - (dr0.^2+(r0*d_lmbda).^2)*t_go^2 - 2*(r0*dr0')*t_go - r0.^2;
Eqn_sol  = double( solve(Eq_jump == 0, t_go) );
real_sol = (Eqn_sol( abs( imag(Eqn_sol)) < 1e-3));
tf       = min( real_sol( real_sol > 0 ) ); tf = real(tf);

% ----------------- Define t as symbolic variable ----------------- %
syms t real
r_t  = ( (tf-t)*((tf+t)*r + (tf*t)*dr) )/tf^2;   %  R(t) - Range symbolic
dr_t = (   2*t*r - tf*(tf-2*t)*dr  )/tf^2;   % dR(t) - Range rate symbolic
% ----------- Inline Function - Allows Plugging vectors ----------- %
R_t  = inline( norm(r_t) );
dR_t = inline( norm(dr_t) );
T = linspace(0, tf)';   tgo = tf - T;

% -------------------- Load the Simulink graphs ------------------- %
% load('7_vec_r_018'); load('7_vec_dr_018'); load('7_vec_Vc_018'); 
load('7_vec_r_022'); load('7_vec_dr_022'); load('7_vec_Vc_022');

%% ------------------------- Plot Results ------------------------- %
close all; 
figure; grid on; hold on;
plot(tgo, R_t(T), '-', 'LineWidth', 3.5);
plot(tf - linspace(0,tf,length(vec_R)), vec_R, 'g--', 'LineWidth', 3.5);

ind(1) = title( '$r(t)$ vs. Time' );
ind(2) = ylabel('Range [m]');
ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = legend('$r(t)$', '$r_8(t)$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

%% ------------------------ Optimal Closing Velocity ----------------------- %
figure; grid on; hold on;
plot(tgo, dR_t(T), 'b-', 'LineWidth', 3.5);
plot(tgo(1:end-1), R_t(T(1:end-1))./tgo(1:end-1), 'r-', 'LineWidth', 3.5);
plot(tf - linspace(0,tf,length(vec_R)),tf - vec_dR, 'g--',tf - linspace(0,tf,length(vec_R)), vec_Vc, 'k--', 'LineWidth', 3.5);

ind(1) = title( '$\dot{r}$ and $V_c$ vs. $t_{go}$' );
ind(2) = ylabel('Velocity [m/s]');
ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = legend('$|\dot{r}|$', '$V_c$', '$|\dot{r}|_8$', '$(V_c)_8$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);
% ylim([-500 1500]);