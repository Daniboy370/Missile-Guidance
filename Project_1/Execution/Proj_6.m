%% --------------------------- Missile Parameters ------------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global rho_v tF M_d T_m rho_w Vc tau N K K_dth dt tout resolution

% ---------------------- Initialize Simulation --------------------- %
MP = 1; NMP = -1;
tF = 6;                                        % Simulation Duration
resolution = 6;                                 % Level of manuever division
rho_v = 10;                                     % Target Acc. Bound [m/sec2]

% ------------------------ Adjoint Execution ----------------------- %
parameters(NMP);                                 % j==1 (MP)  j==2 (NMP)
dlambda = 0.018;                                % I.C. d_LOS
X_20 = dlambda*Vc*tF;                           % I.C. Vel = dlam*Vc*tF
MD = 1; step_res = 2;
show_acc = 0;     show_miss = 1;

rho_cr = N*Vc*dlambda;
mu = rho_v:20:100;

for i=1:length(mu)
    rho_u = mu(i);
    % ----------------- Execution with Saturation ------------------ %
    flag = show_miss; sim('System_Loop_6');
    vec_miss(i,:)      = Miss.Data;
    vec_u(i,:)         = Acc.Data;
    
    % --------------- Execution without Saturation ----------------- %
    flag = show_acc;  sim('System_Loop_6');
    vec_miss_WO(i,:)   = Miss.Data;
    vec_u_WO(i,:)      = Acc.Data;
    tout = tF - Miss.Time;
end

% -------------------------- Plot graphs -------------------------- %
figure(1); show_Lables_6(tout, vec_miss, vec_miss_WO, show_miss);
figure(2); show_Lables_6(tout, vec_u, vec_u_WO, show_acc );

%% ---------------- Miss Distance 3D plot ---------------- %
%         v_len = length(m_b_n_w.Time);
%         hold on; subplot(2,1,1);
%         plot3(tout, K*ones(1,v_len), vec_w(j,i).Data, '--', 'LineWidth', 2.5);
%         show_Labels(MD);
%         set(gca,'YMinorTick','on');
%         set(gca, 'YDir', 'reverse');
%         % ---------------- Step Response 3D plot ---------------- %
%         hold on; subplot(2,1,2);
%         plot3(tout, K*ones(1,v_len), vec_step(j,i).Data, '-', 'LineWidth', 2.5);
%         show_Labels(step_res);
%         vec_s(j,i).Data = m_step.Data;
%         vec_b(j,i).Data = m_T_opt.Data;
%         vec(j,i).Data = m_b_n_w.Data;

%% for i=1:2
%     subplot(2,1,i);
%     aa = get(gca,'XTickLabel');
%     set(gca,'XTickLabel', aa, 'FontName','Times','fontsize',18)
% end
%
% set(gca,'YMinorTick','on');
% set(gca, 'YDir', 'reverse');

%%
% tout = m_T_worst.Time;
% MP = 1; NMP = 2;
% Proj_step_timing(vec_w, vec_b, NMP);
%
% % ------------------ Adjoint Execution + Plot 3D ------------------ %
% tout = m_T_worst.Time;
% v_len = ones(1, length(m_T_worst.Time) );
%
% hold on;
% for j=1:1
%     for i=1:resolution
% %         Z(:,i,j) = vec_w(j,i).Data;
% %         plot3(Dyn_sgn(j)*v_len, tout, vec_w(j,i).Data, 'k--', 'LineWidth', 1.5);
%         plot(tout, vec_w(j,i).Data, 'k--', 'LineWidth', 1.5);
%     end
% end
% view([90 0]);
% %% -------------------- Surface Spanning over 3D -------------------- %
% % hold on;
% % A = [Z(:,1,1) Z(:,1,2)];
% % surf(1:-2:-1, tout, A, 'LineStyle', ':', 'FaceAlpha', 0.25, 'EdgeColor', [.7 .7 .7]);
% % B = [Z(:,end,1) Z(:,end,2)];
% % surf(1:-2:-1, tout, B, 'LineStyle', ':', 'FaceAlpha', 0.10, 'EdgeColor', [.7 .7 .7]);