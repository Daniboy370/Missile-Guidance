%% ----------------- K Sensitivity tests ----------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global tau M_d K K_dth T_m rho_v rho_w

%%
hold on;
for j=1:2
    tF = 0.5;
    MP = 1; NMP = -1;
    % ------------- Initialize Cell array ------------- %
    s_turn = [MP NMP];
    sgn = s_turn(j);
    parameters( sgn );
    resolution = 25;
    K_r_min = 0.01*sgn;
    K_r_max = 0.8*sgn;
    K_r = linspace(K_r_min, K_r_max, resolution);
    
    for i=1:resolution
        clear sim
        K = K_r(i);
        sim('Sense_K');
        vec(i,:) = sim.Data;
    end
    
    % --------------- Span the Manifold ---------------- %
    tout = sim.Time;
    A = nan( length(K_r), length(vec) );
    for i=1:length(K_r)
        A(i,:) = vec(i,:);
    end
    
    surf(tout, K_r , A, 'LineStyle', ':', 'FaceAlpha', 0.7);
end
set(gca, 'XTickLabel', tout);
set(gca, 'YTickLabel', K_r );
set(gca,'YMinorTick','on');
set(gca, 'YDir', 'reverse');
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto');
set(gca, 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
view([-25 27]); box on; grid on;
ylim([-abs(K_r_max) abs(K_r_max)])

% K_r_max = 0.2;
% ylim([-abs(K_r_max) abs(K_r_max)])
% zlim([-0.5 3.5])

%% **************************** Latex Graphs ****************************** %
ind(1) = title( ['Step Response Vs. K $\quad (|K_{\dot{\theta}}| = $' num2str(-K_dth) ')']) ;
ind(2) = xlabel('Time [sec]');
ind(3) = ylabel('K');
ind(4) = zlabel('Step Response');
set(ind, 'Interpreter', 'latex', 'fontsize', 14 );