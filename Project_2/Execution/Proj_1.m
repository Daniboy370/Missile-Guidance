%% ----------------- Differential Game ----------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);

global uc rho_w rho_u rho_v M_d T_m tau N K K_dth Vc dt Ts
Dyn_sgn = [1 -1];
tF = 1.5; t = linspace(0, tF, tF/0.001);
count = 1;


% resolution = 10;
%     mu = 0.25;
%     mu_r = linspace(0.1, 1, resolution);
%     rho_u = rho_v/mu_r(i);
%     sim('Optimal_a');
%     vec_m(i,:) = sim_m.Data;

% uc = logspace(0,2,5);
uc = 1:10:60;

for j = 1:2
    parameters(Dyn_sgn(j));
    for i = 1:length(uc)
        G = tf([K 0 K*M_d],[tau (1+K) K_dth*M_d K*M_d]);
        Srv = tf([1 0 0],[1 0 M_d]);
        vec_s(j).Data(i,:) = step(uc(i)*(1/240)*G*Srv, t );
    end
end

close all;
hold on; grid on;
for j = 1:2
    for i = 1:length(uc)
        plot3(t, uc(i)*ones(1500,1), uc(i)*vec_s(1).Data(i,:)*57.3, 'b', 'LineWidth', 2.5);
        plot3(t, uc(i)*ones(1500,1), uc(i)*vec_s(2).Data(i,:)*57.3, 'r', 'LineWidth', 2.5);
    end
end

xlim([0 tF]); ylim([uc(1) uc(end)]); zlim([-40 40]); 
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 17);
set(gca, 'YDir', 'reverse');
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto');
set(gca, 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
ind(1) = title('$\delta$ vs. $u_c$ vs. $t_{go}$') ;
ind(2) = xlabel('$t_{go}$ [sec]');
ind(3) = zlabel('$\delta$ [$^{\circ}$]');
ind(4) = ylabel('$u_c$');
ind(5) = legend('MP', 'NMP');
view([-58 15]);
% set(gca,'yscale','log'); 
set(gca,'XTickLabel', a, 'fontsize', 22);
set(ind, 'Interpreter', 'latex', 'fontsize', 20 );


%% ------------ Extracting values for later --------------- %
close all;
for i = 1:resolution
    [max_m(i), t_loc(i)] = max( vec_m(i,:) );
end

grid on; box on;
plot(t_loc*0.01, max_m, 'o--','LineWidth', 2);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14);
ind(1) = title('$m^*$ vs. $t_{go}^s$') ;
ind(2) = xlabel('$t_{go}^s$ [sec]');
ind(3) = ylabel('$\hat{m}$');
set(ind, 'Interpreter', 'latex', 'fontsize', 25 );
