hold on;
scatter(ms_MP(:,1), ms_MP(:,2))%, '-', 'LineWidth', 3);
scatter(ms_NMP(:,1), ms_NMP(:,2))%, '-', 'LineWidth', 3);
grid on;
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 14, 'XTickLabelMode', 'auto');
ind(1) = title( '$m^*$ vs. $t_{go}^{cr}$');
ind(2) = xlabel( '$t_{go}$');
ind(3) = ylabel( '$m^*$ [m]');
ind(4) = legend( 'MP', 'NMP');
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );


