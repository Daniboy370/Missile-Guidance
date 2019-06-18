function show_Labels( opt )

if ( opt == 1)
    ind(1) = title( 'Miss Distance Vs. Bounded Target Manuever');
    ind(2) = zlabel('Miss Distance [m]');
    view([-27 25]);
else
    ind(1) = title( '$G_M(s)$ Step Response');
    ind(2) = zlabel('Amplitude');
    view([-27 22]);
end

ind(3) = xlabel('$t_{go}$ [sec]');
ind(4) = ylabel('K');

set(ind, 'Interpreter', 'latex', 'fontsize', 18);

set(gca,'YMinorTick','on');
set(gca, 'YDir', 'reverse');
view([-29 15]);