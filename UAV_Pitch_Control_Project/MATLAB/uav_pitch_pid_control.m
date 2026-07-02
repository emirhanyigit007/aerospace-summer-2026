clear;
clc;
close all;

%% Model Parameters

omega_n = 1.8;      % Natural frequency [rad/s]
zeta = 0.45;        % Damping ratio [-]
K_theta = 3.0;      % Elevator-to-pitch gain [1/s^2]

%% Reference Command

theta_ref_deg = 10;                 % Desired pitch angle [deg]
theta_ref = deg2rad(theta_ref_deg); % Desired pitch angle [rad]

%% PID Controller Gains

Kp = 3.0;    % Proportional gain
Ki = 0.6;    % Integral gain
Kd = 1.5;    % Derivative gain

%% Elevator Saturation Limit

delta_e_max_deg = 15;                    % Maximum elevator deflection [deg]
delta_e_max = deg2rad(delta_e_max_deg);  % Maximum elevator deflection [rad]

%% Simulation Time

t_start = 0;
t_end = 20;
tspan = [t_start t_end];

%% Initial Conditions

theta0 = 0;        % Initial pitch angle [rad]
q0 = 0;            % Initial pitch rate [rad/s]
integral_e0 = 0;   % Initial integral error [rad*s]

x0 = [theta0; q0; integral_e0];

%% Numerical Solution

[t, x] = ode45(@(t, x) uav_pitch_pid_dynamics(t, x, theta_ref, ...
    omega_n, zeta, K_theta, Kp, Ki, Kd, delta_e_max), tspan, x0);

%% Extract States

theta = x(:,1);       % Pitch angle [rad]
q = x(:,2);           % Pitch rate [rad/s]
integral_e = x(:,3);  % Integral of error [rad*s]

%% Calculate Error and Elevator Command

error = theta_ref - theta;

delta_e = Kp*error + Ki*integral_e - Kd*q;

% Apply elevator saturation again for plotting
delta_e(delta_e > delta_e_max) = delta_e_max;
delta_e(delta_e < -delta_e_max) = -delta_e_max;

%% Convert Results to Degrees

theta_deg = rad2deg(theta);
q_deg = rad2deg(q);
error_deg = rad2deg(error);
delta_e_deg = rad2deg(delta_e);

%% Performance Results

theta_final = theta_deg(end);
theta_max = max(theta_deg);
q_max = max(abs(q_deg));
steady_state_error = theta_ref_deg - theta_final;

if theta_max > theta_ref_deg
    overshoot = ((theta_max - theta_ref_deg) / theta_ref_deg) * 100;
else
    overshoot = 0;
end

% Settling time calculation, 2 percent band
tolerance = 0.02 * abs(theta_ref_deg);
settling_time = NaN;

for i = 1:length(t)
    if all(abs(theta_deg(i:end) - theta_ref_deg) <= tolerance)
        settling_time = t(i);
        break;
    end
end

fprintf('UAV Pitch PID Controlled Simulation Results\n');
fprintf('-------------------------------------------\n');
fprintf('Target pitch angle      : %.2f deg\n', theta_ref_deg);
fprintf('Final pitch angle       : %.2f deg\n', theta_final);
fprintf('Maximum pitch angle     : %.2f deg\n', theta_max);
fprintf('Maximum pitch rate      : %.2f deg/s\n', q_max);
fprintf('Maximum elevator input  : %.2f deg\n', max(abs(delta_e_deg)));
fprintf('Steady-state error      : %.2f deg\n', steady_state_error);
fprintf('Overshoot               : %.2f %%\n', overshoot);

if isnan(settling_time)
    fprintf('Settling time           : Not settled within simulation time\n');
else
    fprintf('Settling time           : %.2f s\n', settling_time);
end

%% Plot Results

figure;

subplot(4,1,1);
plot(t, theta_deg, 'LineWidth', 1.8);
hold on;
yline(theta_ref_deg, '--', 'LineWidth', 1.4);
grid on;
xlabel('Time [s]');
ylabel('\theta [deg]');
title('Pitch Angle Response');
legend('Actual Pitch Angle', 'Target Pitch Angle');

subplot(4,1,2);
plot(t, q_deg, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('q [deg/s]');
title('Pitch Rate Response');

subplot(4,1,3);
plot(t, delta_e_deg, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('\delta_e [deg]');
title('Elevator Command');

subplot(4,1,4);
plot(t, error_deg, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('Error [deg]');
title('Pitch Angle Tracking Error');

sgtitle('UAV Longitudinal Pitch Dynamics - PID Control');

%% Save Figure Automatically

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'uav_pitch_pid_response.png'));

%% Local Function

function dx = uav_pitch_pid_dynamics(~, x, theta_ref, omega_n, zeta, ...
    K_theta, Kp, Ki, Kd, delta_e_max)

    theta = x(1);
    q = x(2);
    integral_e = x(3);

    error = theta_ref - theta;

    % PID control law
    % Derivative of error is approximately -q because reference is constant
    delta_e = Kp*error + Ki*integral_e - Kd*q;

    % Elevator saturation
    if delta_e > delta_e_max
        delta_e = delta_e_max;
    elseif delta_e < -delta_e_max
        delta_e = -delta_e_max;
    end

    theta_dot = q;
    q_dot = K_theta*delta_e - 2*zeta*omega_n*q - omega_n^2*theta;
    integral_e_dot = error;

    dx = [theta_dot; q_dot; integral_e_dot];
end