clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global tau M_d K K_d K_dth T_m rho_v rho_w dt Ts

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
    K_r_min = 0.1*sgn;
    K_r_max = 10*sgn;
    k = 0.0001;
    M_d_r = linspace(10, 1000, resolution);
    
    for i=1:resolution
        clear sim
        M_d = M_d_r(i);
        sim('Optimal');
        vec(i,:) = sim.Data;
    end
    % --------------- Span the Manifold ---------------- %
    tout = sim.Time;
    A = nan( length(M_d_r), length(vec) );
    for i=1:length(M_d_r)
        A(i,:) = vec(i,:);
    end
    surf(tout, M_d_r*sgn , A, 'LineStyle', ':', 'FaceAlpha', 0.7);
end

%%
set(gca, 'XTickLabel', tout);
set(gca, 'YTickLabel', M_d_r );
set(gca,'YMinorTick','on');
set(gca, 'YDir', 'reverse');
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto');
set(gca, 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
view([-25 27]); box on; grid on;
ylim(M_d_r(end)*[-1 1])
xlim([0 tF]);

% **************************** Latex Graphs ****************************** %
ind(1) = title('Navigation Constant vs. $M_{\delta}$') ;
ind(2) = xlabel('Time [sec]');
ind(3) = ylabel('$M_{\delta}$');
ind(4) = zlabel('$N^*$');
set(ind, 'Interpreter', 'latex', 'fontsize', 28 );