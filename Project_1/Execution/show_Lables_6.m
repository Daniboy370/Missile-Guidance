function show_Lables_6(t, y_sat, y_unsat, flag)
hold on;
if flag == 1
    ind(1) = title( 'Miss Distance Vs. Time (NMP)');
    ind(2) = xlabel( 'Time [sec]');
    ind(3) = ylabel( 'Miss Distance [m]');
    plot(t, y_sat, 'r-', t, y_unsat, 'b-', 'LineWidth', 2);
    ind(4) = legend( '$MD_{sat}$', '$MD_{Un-sat}$');
    ylim([0 inf]);
else
    ind(1) = title( '$\rho_u$ Vs. Time (NMP)');
    ind(2) = xlabel( 'Time [sec]');
    ind(3) = ylabel( 'Acceleration [$\frac{m}{sec^2}$]');
    plot(t, y_sat, 'r-', t, y_unsat, 'b-', 'LineWidth', 2);
    ind(4) = legend('$\rho_{u,sat}$', '$\rho_{u,Un-sat}$');
    ylim([0 inf]);
end

set(ind, 'Interpreter', 'latex', 'fontsize', 18 ); hold off;