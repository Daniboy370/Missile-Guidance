% -------------------- Game Space Formulation --------------------- %
clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]);
global Tp Tz Tt mu
% ----------------------------------------------------------------- %
syms t
% t=linspace(0,10);
dt = 0.01;      tf = 10;             t_go = tf-t;
Tp = 1;         th_p = t_go/Tp;      psi_p = exp(-th_p) + th_p - 1;
Tt = 1;         th_t = t_go/Tt;      psi_t = exp(-th_t) + th_t - 1;
mu = 1.0:0.2:5.0;                    Tz = -0.1:0.025:0.1;

% ------------------------- t_cr for ZEM -------------------------- %
for j = 1:length(Tz)
    for i = 1:length(mu)
        T_cr(j,i) = solve(Tt*t_go - mu(i)*psi_p*(Tp-Tz(j)) );
        plot((tf-t_cr)/tf,
    end
end
t_cr = double(T_cr(:,2:end));


% -------------------- Plotting the 3D Surface -------------------- %
% close all;
figure;
surf(mu(2:end), Tz, (tf-t_cr)/tf, 'LineStyle', ':', 'FaceAlpha', 0.825);
xlim([mu(1) mu(end)]); set(gca, 'XDir', 'reverse');
ylim([Tz(1)-.01 Tz(end)+.01]);
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto');
set(gca, 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
zlim([0 1]);
ind(1) = title( '$t_{cr}$ vs. $\mu$ vs. $\tau_z$');
ind(2) = xlabel('$\mu$');
ind(3) = ylabel('$\tau_z$');
ind(4) = zlabel('$t_{go}^{cr}$ / $t_f$'); grid on;
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 15, 'XTickLabelMode', 'auto');
view([-47 13]);
set(gcf, 'Position', [2000, 100, 550, 450]);

%% -------------- Marking the desired t_cr vector -------------- %
hold on;
lenV = length(t_cr(:,1));
n0 = 2; nf = length(mu)-1; mid = round(nf/2)-3;
% scatter3(ones(lenV,1)*mu(2), Tz, (tf-t_cr(:,1))/tf, '-');
plot3(ones(lenV,1)*mu(2), Tz, (tf-t_cr(:,1))/tf, 'r-', 'linewidth', 3.5);
plot3(ones(lenV,1)*mu(mid), Tz, 1.1*(tf-t_cr(:,mid))/tf, 'r-', 'linewidth', 3.5);
plot3(ones(lenV,1)*mu(nf), Tz, (tf-t_cr(:,nf))/tf, 'r-', 'linewidth', 3.5);

T_cr = tf-[t_cr(:,1) t_cr(:,mid) t_cr(:,nf)];
T_cr(T_cr > 10 ) = 10;

%% ----------------- ZEM - f(mu) : Game Space Plotting ----------------- %
clear all; close all;
syms t
dt = 0.01; tf = 10;
Tp = 1; Tz = 0; Tt = 1;
t_go = tf-t;
th_p = t_go/Tp;     th_t = t_go/Tt;
psi_p = exp(-th_p) + th_p - 1;
T = linspace(0,tf); lenT = length(T);
mu = 0.5; mu = mu^-1;  Tz = [0.1 -0.1];
z0 = 0:0.2:1;

figure; hold on; grid on;
for j = 1:length(Tz(1))
    for i = 1:length(z0)
        Z = int( t_go - mu*psi_p*(Tp-Tz(j)) );
        Zt = inline(Z);
        z_cr = abs(min(Zt(T)));
        Dlta = z0(i) + z_cr + Zt(T);
        %      plot3( (tf-T)/2, ones(lenT,1)*Tz(j),  Dlta, 'k-', 'LineWidth', 1.5);
        %      plot3( (tf-T)/2, ones(lenT,1)*Tz(j), -Dlta, 'k-', 'LineWidth', 1.5);
        plot( (tf-T)/3,  Dlta, 'k-', 'LineWidth', 2);
        plot( (tf-T)/3, -Dlta, 'k-', 'LineWidth', 2);
        % --------- Spotting Minimal element - t_cr --------- %
%         [~,min_d(j)] = min(Dlta);
        %     legend(mu(j));
    end
end

% view([-40 15]);
ind(1) = title( '$|y(t_f)|$ vs. $t_{go}$ ($\mu$ = 0.5)');
ind(2) = xlabel('$t_{go}$');
ind(3) = ylabel('$|y(t_f)|$');
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 15, 'XTickLabelMode', 'auto');
xlim([0 1.5]);    ylim([-2 2]);
 
%% ----------------- ZEM - f(mu) : Game Space Plotting ----------------- %
xlim([mu(1) mu(end)]); set(gca, 'XDir', 'reverse');
ylim([Tz(1)-.01 Tz(end)+.01]); set(gca, 'YDir', 'reverse');
set(gca, 'XTickMode', 'auto', 'XTickLabelMode', 'auto');
set(gca, 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
zlim([0 1]);
ind(1) = title( 'ZEM vs. $t_{cr}$ vs. $\tau_z$ ($\mu$ = 1.1');
ind(2) = xlabel('$t_{go}^{cr}$ / $t_f$');
ind(3) = ylabel('$\tau_z$');
ind(4) = zlabel('Normalized ZEM'); grid on;
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
a = get(gca,'XTickLabel');
set(gca,'XTickLabel', a, 'fontsize', 15, 'XTickLabelMode', 'auto');

set(gcf, 'Position', [2000, 100, 550, 450]);



%%
figure;
plot(Tz, (tf-t_cr(:,1))/tf, '-');
ylim([0 1]);

%% ---------------- Plotting NMD ---------------- %
% figure;
% plot(mu, (tf-t_cr)/tf, '-', 'LineWidth', 2.5);
% set(gca, 'XDir', 'reverse');
% ind(1) = title( '$t_{cr}$ vs. $\mu$' );
% ind(2) = xlabel( '$\mu$');
% ind(3) = ylabel( 'Normalized Flight Time');
% set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
% ylim([0 1]); xlim([1 inf]); grid on;

