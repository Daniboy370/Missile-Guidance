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

%% -------------------- Bifurcation - t_go vs. d_lmbda -------------------- %
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

%% --------------------- Bifurcation - Plot Restults ---------------------- %
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

%% --------------------- Bifurcation - dr vs. d_lmbda --------------------- %
clear all; close all;
syms d_lmbda t_go
r = 15000;         dr = -1280;      D_rho = 10*(10-5);
Eq_jump = 4*r^2*D_rho^4 - D_rho^2*dr^4 - 20*r^2*D_rho^2*dr^2*d_lmbda^2 + ...
    8*r^4*D_rho^2*d_lmbda^4 + 4*dr^6*d_lmbda^2 + 12*r^2*dr^4*d_lmbda^4 + ...
    12*r^4*dr^2*d_lmbda^6 + 4*r^6*d_lmbda^8;

syms dr
d_lmbda = linspace(0.00001,0.03);

for i = 1:500
    Eq_jump = 4*r^2*D_rho^4 - D_rho^2*dr^4 - 20*r^2*D_rho^2*dr^2*d_lmbda(i)^2 + ...
        8*r^4*D_rho^2*d_lmbda(i)^4 + 4*dr^6*d_lmbda(i)^2 + 12*r^2*dr^4*d_lmbda(i)^4 + ...
        12*r^4*dr^2*d_lmbda(i)^6 + 4*r^6*d_lmbda(i)^8;
    v_dr1 = double( solve( Eq_jump == 0, dr) );
    v_dr1 = real( v_dr1( abs( imag(v_dr1)) < 1e-3) );
    if isempty(v_dr1)
        return;
    end
    V_dr1(i,:) = v_dr1( v_dr1 > 0 );
end

%%
close all; hold on;
plot( d_lmbda(1:i-1)', V_dr1, 'Color', [0.1, 0.5, 1.0], 'LineWidth', 2.5);
plot(-d_lmbda(1:i-1)', V_dr1, 'Color', [0.1, 0.5, 1.0], 'LineWidth', 2.5);
ind(1) = title( '$\dot{r}$ vs. $\dot{\lambda}$' );
ind(2) = xlabel('$\dot{\lambda}$ [rad/sec]');
ind(3) = ylabel('$\dot{r}$ [m/sec]');
xlim([-0.03 0.03]); ylim([0 5000]); grid on;
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

%% ------------------------- Tangency & t_go Jump ------------------------- %
close all; clear all; 
load('V_tgo_lmbda');    load('V_dlmbda');  t_cr = 67;

syms t_go
D_rho = 5*10; 
Eq_2 = 0.5*D_rho*t_go.^2;   eq2 = inline(Eq_2);
t_1 = 12.1226; t_2 = 36.975; 
R0 = eq2(t_1);
r = 1.2e4; v = -1200;
Eq_1 = abs(r + t_go.*v);    eq1 = inline(Eq_1);

t_cr2 = double( solve( Eq_1 == Eq_2, t_go ))
t_cr2 = t_cr2( t_cr2 > 0 );

t_go = linspace(0, 50, 300);

%% ----------------------------- Plot Results ------------------------------ %
plot(t_go, eq1(t_go)+3e3, '-', t_go, eq2(t_go), '-', 'LineWidth', 2);
ind(1) = title( '$r(t)$ vs. Time' );
ind(2) = ylabel('Range [m]');
ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = legend('$\|r + t_{go} v\|$', '$\frac{1}{2} \Delta \rho \cdot t_{go}^2$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22); grid on;


%% ---------------------- Find t_f per given d_lmbda ---------------------- %
clear all; 
syms t_go
D_rho = 5*10; r = 1.5e4; v = -1280;
Eq_jump  = 0.25*D_rho^2*t_go^4 - (dr^2+(r*d_lmbda)^2)*t_go^2 - 2*(r*dr)*t_go - r^2;
Eqn_sol  = double( solve(Eq_jump == 0, t_go) );
real_sol = (Eqn_sol( abs( imag(Eqn_sol)) < 1e-3));
tf       = min( real_sol( real_sol > 0 ) ); tf = real(tf);

sim('Guidance_Loop');
vec_R  = R.data;
vec_dR = dR.data;
tout   = R.Time;
vec_Vc = vec_R./(tf-tout);
% vec_Vc = V_c.data;
% vec_lmbda = lmbda.data;

% --------------------------- Range Progression -------------------------- %
close all;
figure; grid on; hold on;
plot(tout, vec_R, '-', 'LineWidth', 2);
ind(1) = title( '$r(t)$ vs. Time' );
ind(2) = ylabel('Range [m]');
ind(3) = xlabel('Time [sec]');
ind(4) = legend('$r(t)$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

% ------------------------ Optimal Closing Velocity ----------------------- %
figure; grid on; hold on;
plot(tout, -vec_dR, '-', tout, vec_Vc, '-', 'LineWidth', 2);
ind(1) = title( '$\dot{r}$ and $V_c$ vs. Time' );
ind(2) = ylabel('Velocity [m/s]');
ind(3) = xlabel('Time [sec]');
ind(4) = legend('$-\dot{r}$', 'r/$t_{go}$');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);

%% --------------------- Scatter - Plot --------------------- %
s(1) = scatter( d_lmbda(1:i-1)', V_dr1(:,1), 'filled')
s(2) = scatter(-d_lmbda(1:i-1)', V_dr1(:,1), 'filled')
s(3) = scatter( d_lmbda(1:i-1)', V_dr1(:,2), 'filled')
s(4) = scatter(-d_lmbda(1:i-1)', V_dr1(:,2), 'filled')
s(5) = scatter( d_lmbda(1:i-1)', V_dr1(:,3), 'filled')
s(6) = scatter(-d_lmbda(1:i-1)', V_dr1(:,3), 'filled')

s.LineWidth = 0.6;
s.MarkerEdgeColor = [0.5, 0.67, 1.0];
s.MarkerFaceColor = [0 0.5 0.5];
