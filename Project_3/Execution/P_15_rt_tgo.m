%% ------------------------- Tangency & t_go Jump ------------------------- %
close all; clear all; 
load('V_tgo_lmbda');    load('V_dlmbda');

syms t_go
D_rho = 5*10;       u_m = 100;
Eq_2 = 0.333*u_m*t_go.^2;   eq2 = inline(Eq_2);
% t_1 = 12.1226; t_2 = 36.975; R0 = eq2(t_1);
r = 1.3e4; v = -1700;
Eq_1 = abs(r + t_go.*v);    eq1 = inline(Eq_1);

t_cr2 = double( solve( Eq_1 == Eq_2, t_go ))
t_cr2 = t_cr2( t_cr2 > 0 );
t_go = linspace(0, 50, 300);

% ----------------------------- Plot Results ------------------------------ %
plot(t_go, eq1(t_go)+2e3, '-', t_go, eq2(t_go), '-', 'LineWidth', 2);
ind(1) = title( '$r(t)$ vs. Time' );
ind(2) = ylabel('Range [m]');
ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = legend('$\|r + t_{go} v\|$', '$\frac{1}{3} u_m t_{go}^2$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22); grid on;
