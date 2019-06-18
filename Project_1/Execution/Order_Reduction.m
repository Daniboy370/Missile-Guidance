clc; clear all; close all; set(0,'defaultfigurecolor',[1 1 1]); 

%% ----------- Dynamic Sandbox ------------ %
% - Given the following transfer function - %
G = tf([1 5 2],[1 2 10 2 1]);
% Define desired options for higher order reduction
opt = balredOptions('Offset',.001,'StateElimMethod','Truncate');
% Compute second-order approximation
G_r = balred(G,3,opt)
% Step response Comparison
figure(1); step(G, G_r);

%% ----- Bode plots Comparison - Original vs. Truncated ----- %
figure(2);
[mag_A, phase_A, W1] = bode(G);
[mag_B, phase_B, W2] = bode(G_r);

% ------------ Amplitude ------------ %
subplot(2,1,1);
semilogx(W1, mag_A(:,:));hold on
semilogx(W2, mag_B(:,:));hold off

% -------------- Phase -------------- %
subplot(2,1,2)
semilogx(W1, phase_A(:,:)); hold on
semilogx(W2, phase_B(:,:)); hold off

%% Misc.
stepinfo(G_r)
bandwidth(G_r)

stepinfo(G)
bandwidth(G)