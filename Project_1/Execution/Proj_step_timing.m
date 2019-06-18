function Proj_step_timing(vec_1, vec_2, j)

global resolution tout
clc; close all;

% --------- Choose the following Configuration sign and assign j --------- %
hold on;
for i=1:resolution
    plot(tout, vec_1(j,i).Data, 'b-', 'LineWidth', 2 );
end
hold off;

ind(1) = title( 'Worst Target Manuever Vs. $t_{go}$', 'fontsize', 14 );
ind(2) = xlabel( 'Time [sec]', 'fontsize', 14 );
yyaxis left;
ind(3) = ylabel( 'Miss Distance [m]', 'fontsize', 14 );
set(gca, 'ycolor', 'b');

yyaxis right;
for i=1:resolution
    plot(tout, vec_2(j,i).Data, 'r-', 'LineWidth', 3 );
end

ind(4) = ylabel('Bounded Manuever $[\frac{m}{sec^2}]$', 'Interpreter', 'latex');
set(gca, 'ycolor', 'r');
ind(5) = legend('$\rho_{u}$', '$\rho_{worst}$');

set(ind, 'Interpreter', 'latex', 'fontsize', 14 );