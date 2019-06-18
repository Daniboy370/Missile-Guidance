%% ------------------------------ Project_3 ------------------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
% ---------------------- Find t_f per given d_lmbda ---------------------- %
g = 9.81;           dt  = 0.01;
r0 = 15000;         dr0 = -1280;
d_lmbda  = 0.022;   lmbda_0 = rad2deg(0);
rho_u = 10*g;       rho_w = 5*g;
D_rho    = rho_u-rho_w;                 N = (2/(1-rho_w/rho_u));
vx_0 = dr0*cos(lmbda_0);     vy_0 = dr0*sin(lmbda_0);
rx_0 =  r0*cos(lmbda_0);     ry_0 =  r0*sin(lmbda_0);

% -------------------- Bifurcation - t_go vs. d_lmbda -------------------- %
clear all; close all
syms t_go
D_rho = 5*10; r = 1.5e4; dr = -1230;
d_lmbda = linspace(0.00001, 0.04, 35)';

for i = 1:500
    Eq_jump = 0.25*D_rho^2*t_go^4 - (dr^2+(r*d_lmbda(i))^2)*t_go^2 - 2*(r*dr)*t_go - r^2;
    v_dr1 = double( solve( Eq_jump == 0, t_go) );
    v_dr1 = real( v_dr1( abs( imag(v_dr1)) < 1e-3) );
    if isempty(v_dr1)
        return;
    end
    V_dr1(i,:) = v_dr1( v_dr1 > 0 );
end

% --------------------- Bifurcation - Plot Restults ---------------------- %
close all; hold on;
Color = [0.5 0.67 1.0];
scatter( d_lmbda(1:i-1)', V_dr1(:,1), 'filled', 'MarkerFaceColor', Color );
scatter(-d_lmbda(1:i-1)', V_dr1(:,1), 'filled', 'MarkerFaceColor', Color );
scatter( d_lmbda(1:i-1)', V_dr1(:,2), 'filled', 'MarkerFaceColor', Color );
scatter(-d_lmbda(1:i-1)', V_dr1(:,2), 'filled', 'MarkerFaceColor', Color );
scatter( d_lmbda(1:i-1)', V_dr1(:,3), 'filled', 'MarkerFaceColor', Color );
scatter(-d_lmbda(1:i-1)', V_dr1(:,3), 'filled', 'MarkerFaceColor', Color );

ind(1) = title( '$t_{go}$ vs. $\dot{\lambda}$' );
ind(2) = xlabel('$\dot{\lambda}$ [rad/sec]');
ind(3) = ylabel('$t_{go}$ [sec]');
grid on; a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
