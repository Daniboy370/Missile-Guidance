%% --------------------------- Missile Parameters ------------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global rho_v rho_v_max tF M_d T_m rho_w Vc tau N K K_dth dt tout resolution

% ---------------------- Initialize Simulation --------------------- %
MP = 1; NMP = -1; Dyn_sgn = [1 -1];
tF = 3;                     % Simulation Duration
resolution = 5;             % Level of manuever division
rho_v = 10;                 % Target Acc. Bound [m/sec2]
rho_v_max = 20;             % Upper  Acc. Bound [m/sec2]

rho_i = linspace(rho_v, rho_v_max, resolution);

% ------------------------ Adjoint Execution ----------------------- %
hold on;
for j=1:2
    parameters(Dyn_sgn(j));     % j==1 (MP)  j==2 (NMP)
    for i=1:resolution
        rho_v = rho_i(i);
        sim('System_Adjoint');
        vec_w(j,i).Data = m_T_worst.Data;
%         vec_s(j,i).Data = m_step.Data;
        vec_b(j,i).Data = m_T_opt.Data;
%         vec(j,i).Data = m_b_n_w.Data;
    end
end
%%
tout = m_T_worst.Time;
MP = 1; NMP = 2;
% Proj_step_timing(vec_w, vec_b, NMP);

%% ------------------ Adjoint Execution + Plot 3D ------------------ %
tout = m_T_worst.Time;
v_len = ones(1, length(m_T_worst.Time) );

hold on;
for j=1:2
    for i=1:resolution
        Z(:,i,j) = vec_w(j,i).Data;
        plot3(Dyn_sgn(j)*v_len, tout,  vec_w(j,i).Data, 'k--', 'LineWidth', 1.5);
    end
end

% -------------------- Surface Spanning over 3D -------------------- %
hold on;
A = [Z(:,1,1) Z(:,1,2)];
surf(1:-2:-1, tout, A, 'LineStyle', ':', 'FaceAlpha', 0.25, 'EdgeColor', [.7 .7 .7]);
B = [Z(:,end,1) Z(:,end,2)];
surf(1:-2:-1, tout, B, 'LineStyle', ':', 'FaceAlpha', 0.10, 'EdgeColor', [.7 .7 .7]);
view([60 20]);

% -------------------------- Latex Graphs -------------------------- %
configaration = {'NMP'; 'MP'};
set(gca,'xtick', -1:2:1, 'xticklabel', configaration, 'fontsize', 12);
ind(1) = title( 'Miss Distance Vs. Bounded Target Manuever', 'fontsize', 16 );
ind(2) = xlabel('Phase sign [$\pm$]');
ind(3) = ylabel('$t_{go}$ [sec]');
ind(4) = zlabel('Miss Distance [m]');
set(ind, 'Interpreter', 'latex', 'fontsize', 14);
