close all; clc; clear all;
syms x(t)

tspan = [0 10];
dx = diff(x,t,1);
ddx = diff(x,t,2);


Q = dsolve(Eqn, [x(0)==1 dx(0)==1] )
W = inline(Q);
t = linspace(0,10);

plot(t, W(t), '-', 'LineWidth', 2)
xlabel('Time'); ylabel('y'); grid on;

%% ------------------ Useful Function ------------------ %
V = odeToVectorField(Eqn);
F = matlabFunction(V, 'vars', {'t','Y'});
ode45(F, tspan, [1 1])


%% --------- Manual Decomposition of ode2vector --------- %
hold on;
syms y(t)
tspan = [0 10];
eqn = @(t, y) [0 + y(2); -( y(1) + y(2) )];

ode45(eqn, tspan, [1 1] )
grid on;
