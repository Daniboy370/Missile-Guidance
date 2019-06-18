%% ----------------- Differential Game ----------------- %
close all;
clc; clear all; set(0,'defaultfigurecolor',[1 1 1]);
global rho_u rho_v M_d T_m tau N K K_dth Vc dt Ts

load('t_go_m'); load('max_m');          % Saved values from previous run
col = ['r'; 'g'; 'b'; 'c'; 'm'; 'y'];

tF = 1.5;
parameters(1);
% mu_r = linspace(0.1, 0.5, resolution);
mu_r = 0.1:0.1:0.7; mu_r(4) = [];
mu_len = length(mu_r);
vec_n = zeros(mu_len, tF/0.01);
jj = [1.35 1.25 1.15 1.05 0.95 0.75];

hold on;
for j=1:length(jj)
    for i=1:mu_len
        mu = mu_r(i);
        rho_u = rho_v/mu_r(i);
        t_go = t_go_m(i);
        m = max_m(i)*jj(j);
        sim('Optimal_b');
        plot(tout, sim_N.Data, col(i), 'LineWidth', 2);
        %     vec_n_len = length(sim_N.Data);
        %     vec_n(i,1:vec_n_len) = sim_N.Data';
    end
end

hold on; grid on;
% plot(dt:dt:tF, vec_n, '-', 'LineWidth', 2);
% plot(t_go_m, max_m, 'o-', 'LineWidth', 2);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 16);
ind(1) = title('$N^*$ vs. $t_{go}$') ;
ind(2) = xlabel('$t_{go}$ [sec]');
ind(3) = ylabel('$N^*$');
% ylim([-500 500]);
set(ind, 'Interpreter', 'latex', 'fontsize', 25 );
ylim([-1000 1000]);