clear;
clc;
close all;
omega_n = 1.8;      % Natural frequency [rad/s]
zeta = 0.45;        % Damping ratio [-]
K_theta = 3.0;      % Elevator-to-pitch gain [1/s^2]

%% Elevator Input

delta_e_deg = 5;                 % Elevator deflection [deg]
delta_e = deg2rad(delta_e_deg);  % Elevator deflection [rad]

%% Simulation Time

t_start = 0;
t_end = 20;
tspan = [t_start t_end];

%% Initial Conditions

theta0 = 0;   % Initial pitch angle [rad]
q0 = 0;       % Initial pitch rate [rad/s]

x0 = [theta0; q0];

%% Equations of Motion

pitch_dynamics = @(t, x) [x(2);K_theta * delta_e - 2*zeta*omega_n*x(2) - omega_n^2*x(1)];

%% Numerical Solution

[t, x] = ode45(pitch_dynamics, tspan, x0);

theta = x(:,1);   % Pitch angle [rad]
q = x(:,2);       % Pitch rate [rad/s]

%% Convert Results to Degrees

theta_deg = rad2deg(theta);
q_deg = rad2deg(q);
delta_e_plot = delta_e_deg * ones(size(t));

%% Performance Results

theta_final = theta_deg(end);
theta_max = max(theta_deg);
q_max = max(abs(q_deg));

overshoot = ((theta_max - theta_final) / theta_final) * 100;

fprintf('UAV Pitch Open Loop Simulation Results\n');
fprintf('--------------------------------------\n');
fprintf('Elevator input       : %.2f deg\n', delta_e_deg);
fprintf('Final pitch angle    : %.2f deg\n', theta_final);
fprintf('Maximum pitch angle  : %.2f deg\n', theta_max);
fprintf('Maximum pitch rate   : %.2f deg/s\n', q_max);
fprintf('Overshoot            : %.2f %%\n', overshoot);

%% Plot Results

figure;

subplot(3,1,1);
plot(t, theta_deg, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('\theta [deg]');
title('Pitch Angle Response');

subplot(3,1,2);
plot(t, q_deg, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('q [deg/s]');
title('Pitch Rate Response');

subplot(3,1,3);
plot(t, delta_e_plot, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('\delta_e [deg]');
title('Elevator Input');

sgtitle('UAV Longitudinal Pitch Dynamics - Open Loop Simulation');