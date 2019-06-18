function parameters(sgn)

global uc rho_w rho_u rho_v M_d T_m tau N K  K_dth Vc dt Ts
% ------------------- Control Design ------------------- %
dt = 0.01;                  % Initial Increment [sec]
Ts = 0.01;                  % Step size time [sec]
T_m = 120;                  % Acceleration [m/sec2]
tau = 0.05;                 % Time constant [sec]
rho_w = 10^-4;              % Bounded noise
rho_v = 15;                 % Bounded Target Acceleration [m/sec2]
rho_u = 5*rho_v;            % Bounded Target Acceleration [m/sec2]
M_d = 200*sgn;              % Moment derivative [1/sec2]
K = 0.2*sgn;                % State feedback
% K_d = 0.2*sgn;            % State feedback
K_dth = 0.2*sgn;           % Rate feedback
% ----------------- Adjoint Simulation ----------------- %
Vc = 1250;                  % Closing Speed [m/sec2]
N = 3;                      % Navigation Constant
end