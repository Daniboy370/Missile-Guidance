%% --------------------------- Missile Parameters ------------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global tF rho_v rho_w M_d T_m Vc tau N K K_dth dt tout resolution

% ------------------- Initialize Simulation ------------------- %
MP = 1; NMP = -1; Dyn_sgn = [1 -1];
tF = 5;                     % Simulation Duration
resolution = 5;            % Level of manuever division

for j=1:2
    % ------------------ MD Vs. set of Moment values --------------- %
%     M_d_min = Dyn_sgn(j)*40;
%     M_d_max = Dyn_sgn(j)*800;
%     M_d_i = linspace(M_d_min, M_d_max, resolution); % Moment  
    % ------------------ MD Vs. set of tau values ----------------- %
    tau_min = 0.005;
    tau_max = 0.5;
    tau_i = linspace(tau_min, tau_max, resolution); % tau
    % ------------------ MD Vs. set of Vc values ------------------ %
%     Vc_min = 2;
%     Vc_max = 4;
%     Vc_i = logspace(Vc_min, Vc_max, resolution); % Vc
    % ------------------ MD Vs. set of T/m values ----------------- %
%     T_m_min = 50;
%     T_m_max = 500;
%     T_m_i = linspace(T_m_min, T_m_max, resolution); % T_m
    % ------------------ MD Vs. set of N values ------------------- %
%     N_min = 2;
%     N_max = 10;
%     N_i = linspace(N_min, N_max, resolution); % tau
    % --------------------- Adjoint Execution --------------------- %
    parameters(Dyn_sgn(j));     % j==1 (MP)  j==2 (NMP)
    for i=1:resolution
        tau = tau_i(i);
        sim('System_Adjoint');
        % ------------ Worst Target Manuever ------------ %
        %         vec_w(j,i).Data = m_T_worst.Data;
        % ------------ MD Vs. bounded noise ------------- %
        %       vec_w(j,i).Data = m_b_n_w.Data;
        %         MD_max(j,i) = vec_w(j,i).Data(end);
        % -------------- Delta deflection --------------- %
        %       vec_T(i,:,j).Data = rad2deg( m_delta.Data );
        % ---------------- Miss T/M ratio --------------- %
        %       vec_T(i,:,j).Data = m_b_n_w.Data ;
        %       vec_T(i,:,j).Data = rad2deg( m_delta.Data ) ;
        % ------------------ N constant ----------------- %
                vec_T(i,:,j).Data = rad2deg( m_delta.Data );
        %                 vec_opt(j,i).Data = m_b_n_opt.Data;
        % --------- Bounded Manuever & Noise MD --------- %
        %         vec_bn(j,i).Data = m_b_n_w.Data;
    end
    % ------------------ Adjoint Execution + Plot 3D ------------------ %
    hold on;
    tout = m_T_worst.Time;
    v_len = ones(1, length(tout) );
%     for i=1:resolution
%         plot3( tout, tau_i(i)*v_len, vec_T(i,:).Data, '-', 'LineWidth', 2);
%     end
end

%%
hold on;
for i=1:resolution
    plot3( tout, tau_i(i)*v_len, vec_T(i,:,1).Data, 'k-', 'LineWidth', 2);
    plot3( tout, tau_i(i)*v_len, vec_T(i,:,2).Data, 'b-', 'LineWidth', 2); 
end

view([-75 13]); % set(gca,'Ydir','reverse');
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',12,'FontWeight','bold');
ind(1) = title( '$\delta$ Deflection Vs. $\tau$' );
ind(2) = ylabel('$\tau$ [sec]'); % \frac{1}{sec^2}
ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = zlabel('$\delta$ $[^\circ]$');
set(ind, 'Interpreter', 'latex', 'fontsize', 22);
% legend('MP', 'NMP');
% ylim([M_d_max -M_d_max ]); 
%%
KK = legend('MP', 'NMP');
set(KK, 'Interpreter', 'latex', 'fontsize', 18)
zlim([-10 15]); % For the MD analysis

%% ---------------- Settled Miss Distance Vs. Bounded Noise --------------- %
% close all;
% semilogx(rho_i, MD_max(1,:), 'b-', 'LineWidth', 2);
% hold on;
% semilogx(rho_i, MD_max(2,:), 'r-', 'LineWidth', 2);
%
% ind(1) = title( 'Settled Miss Distance Vs. Bounded Noise', 'fontsize', 16 );
% ind(2) = ylabel('MD [m]');
% ind(3) = xlabel('$\rho_w [\frac{m}{sec^2}]$');
% ind(4) = legend('MP', 'NMP');
% set(ind, 'Interpreter', 'latex', 'fontsize', 14);
% xlim([1e-7 1e-2]); grid on;