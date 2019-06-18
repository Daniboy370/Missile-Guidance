function parameters(sgn)

global rho_w  M_d T_m tau N K K_d K_dth Vc dt Ts
% ------------------- Control Design ------------------- %
dt = 1e-7;                  % Initial Increment [sec]
Ts = 0.01;                  % Step size time [sec]
T_m = 120;                  % Acceleration [m/sec2]
tau = 0.05;                 % Time constant [sec]
rho_w = 10^-4;              % Bounded noise
% rho_v = 15;               % Bounded Target Acceleration [m/sec2]
M_d = 200*sgn;              % Moment derivative [1/sec2]
% K = 0.25*sgn;             % State feedback
K_d = 0.2*sgn;              % State feedback
K_dth = 0.05*sgn;           % Rate feedback
% ----------------- Adjoint Simulation ----------------- %
Vc = 1250;                  % Closing Speed [m/sec2]
N = 3;                      % Navigation Constant
end