clear;
clc;
close all;

%% Model Parameters

omega_n = 1.8;      % Natural frequency [rad/s]
zeta = 0.45;        % Damping ratio [-]
K_theta = 3.0;      % Elevator-to-pitch gain [1/s^2]

%% Reference Command

theta_ref_deg = 10;
theta_ref = deg2rad(theta_ref_deg);

%% Elevator Saturation

delta_e_max_deg = 15;
delta_e_max = deg2rad(delta_e_max_deg);

%% Simulation Time

tspan = [0 20];

%% Initial Conditions

theta0 = 0;
q0 = 0;
integral_e0 = 0;

x0 = [theta0; q0; integral_e0];

%% PID Gain Sets

gain_sets = [
    3.0  0.6  1.5;   % Set 1 - Baseline
    4.5  0.8  1.2;   % Set 2 - Faster response
    5.5  1.0  1.0;   % Set 3 - More aggressive
    4.0  1.2  1.8    % Set 4 - More damping + stronger integral
];

set_names = {
    'Set 1 - Baseline';
    'Set 2 - Faster';
    'Set 3 - Aggressive';
    'Set 4 - Damped'
};

%% Prepare Figures

figure;
hold on;
grid on;
xlabel('Time [s]');
ylabel('\theta [deg]');
title('PID Tuning Comparison - Pitch Angle Response');

fprintf('PID Tuning Results\n');
fprintf('-------------------------------------------------------------\n');
fprintf('%-18s %-8s %-8s %-8s %-10s %-10s %-10s\n', ...
    'Controller', 'Kp', 'Ki', 'Kd', 'Final', 'Overshoot', 'Settling');
fprintf('-------------------------------------------------------------\n');

%% Run Simulations

for i = 1:size(gain_sets, 1)

    Kp = gain_sets(i, 1);
    Ki = gain_sets(i, 2);
    Kd = gain_sets(i, 3);

    [t, x] = ode45(@(t, x) uav_pitch_pid_dynamics(t, x, theta_ref, ...
        omega_n, zeta, K_theta, Kp, Ki, Kd, delta_e_max), tspan, x0);

    theta = x(:,1);
    q = x(:,2);
    integral_e = x(:,3);

    theta_deg = rad2deg(theta);

    %% Performance Metrics

    theta_final = theta_deg(end);
    theta_max = max(theta_deg);

    if theta_max > theta_ref_deg
        overshoot = ((theta_max - theta_ref_deg) / theta_ref_deg) * 100;
    else
        overshoot = 0;
    end

    tolerance = 0.02 * abs(theta_ref_deg);
    settling_time = NaN;

    for j = 1:length(t)
        if all(abs(theta_deg(j:end) - theta_ref_deg) <= tolerance)
            settling_time = t(j);
            break;
        end
    end

    %% Plot Pitch Response

    plot(t, theta_deg, 'LineWidth', 1.8);

    %% Print Results

    if isnan(settling_time)
        settling_text = 'Not set';
        fprintf('%-18s %-8.2f %-8.2f %-8.2f %-10.2f %-10.2f %-10s\n', ...
            set_names{i}, Kp, Ki, Kd, theta_final, overshoot, settling_text);
    else
        fprintf('%-18s %-8.2f %-8.2f %-8.2f %-10.2f %-10.2f %-10.2f\n', ...
            set_names{i}, Kp, Ki, Kd, theta_final, overshoot, settling_time);
    end
end

yline(theta_ref_deg, '--', 'Target Pitch Angle', 'LineWidth', 1.5);
legend([set_names; {'Target Pitch Angle'}], 'Location', 'best');

sgtitle('UAV Pitch Control - PID Gain Tuning Study');

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'uav_pitch_pid_tuning_comparison.png'));

%% Local Function

function dx = uav_pitch_pid_dynamics(~, x, theta_ref, omega_n, zeta, ...
    K_theta, Kp, Ki, Kd, delta_e_max)

    theta = x(1);
    q = x(2);
    integral_e = x(3);

    error = theta_ref - theta;

    % PID control law
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