clear;
clc;
close all;

%% Model Parameters

omega_n = 1.8;      % Natural frequency [rad/s]
zeta = 0.45;        % Damping ratio [-]
K_theta = 3.0;      % Elevator-to-pitch gain [1/s^2]

%% Final PID Gains

Kp = 4.0;
Ki = 1.2;
Kd = 1.8;

%% Reference Command

theta_ref_deg = 15;
theta_ref = deg2rad(theta_ref_deg);

%% Elevator Saturation Limits to Test

delta_e_max_deg_list = [15, 20, 25];

%% Simulation Time

tspan = [0 25];

%% Initial Conditions

theta0 = 0;
q0 = 0;
integral_e0 = 0;

x0 = [theta0; q0; integral_e0];

%% Results Storage

final_pitch_list = zeros(length(delta_e_max_deg_list), 1);
max_pitch_list = zeros(length(delta_e_max_deg_list), 1);
max_q_list = zeros(length(delta_e_max_deg_list), 1);
max_elevator_list = zeros(length(delta_e_max_deg_list), 1);
steady_state_error_list = zeros(length(delta_e_max_deg_list), 1);
overshoot_list = zeros(length(delta_e_max_deg_list), 1);
settling_time_list = zeros(length(delta_e_max_deg_list), 1);

%% Figure Setup

figure;
hold on;
grid on;
xlabel('Time [s]');
ylabel('\theta [deg]');
title('Effect of Elevator Saturation on Pitch Tracking');

%% Run Simulations

for i = 1:length(delta_e_max_deg_list)

    delta_e_max_deg = delta_e_max_deg_list(i);
    delta_e_max = deg2rad(delta_e_max_deg);

    [t, x] = ode45(@(t, x) uav_pitch_pid_dynamics(t, x, theta_ref, ...
        omega_n, zeta, K_theta, Kp, Ki, Kd, delta_e_max), tspan, x0);

    theta = x(:,1);
    q = x(:,2);
    integral_e = x(:,3);

    error = theta_ref - theta;

    delta_e = Kp*error + Ki*integral_e - Kd*q;

    % Apply elevator saturation for analysis
    delta_e(delta_e > delta_e_max) = delta_e_max;
    delta_e(delta_e < -delta_e_max) = -delta_e_max;

    %% Convert to Degrees

    theta_deg = rad2deg(theta);
    q_deg = rad2deg(q);
    delta_e_deg = rad2deg(delta_e);

    %% Performance Metrics

    theta_final = theta_deg(end);
    theta_max = max(theta_deg);
    q_max = max(abs(q_deg));
    max_elevator = max(abs(delta_e_deg));
    steady_state_error = theta_ref_deg - theta_final;

    if theta_max > theta_ref_deg
        overshoot = ((theta_max - theta_ref_deg) / theta_ref_deg) * 100;
    else
        overshoot = 0;
    end

    % Settling time calculation with 2 percent band
    tolerance = 0.02 * abs(theta_ref_deg);
    settling_time = NaN;

    for j = 1:length(t)
        if all(abs(theta_deg(j:end) - theta_ref_deg) <= tolerance)
            settling_time = t(j);
            break;
        end
    end

    %% Store Results

    final_pitch_list(i) = theta_final;
    max_pitch_list(i) = theta_max;
    max_q_list(i) = q_max;
    max_elevator_list(i) = max_elevator;
    steady_state_error_list(i) = steady_state_error;
    overshoot_list(i) = overshoot;
    settling_time_list(i) = settling_time;

    %% Plot Pitch Response

    plot(t, theta_deg, 'LineWidth', 1.8);
end

%% Add Reference Line

yline(theta_ref_deg, '--', 'Target 15 deg', 'LineWidth', 1.5);

legend('Elevator limit 15 deg', ...
       'Elevator limit 20 deg', ...
       'Elevator limit 25 deg', ...
       'Target 15 deg', ...
       'Location', 'best');

sgtitle('UAV Pitch Control - Actuator Saturation Study');

%% Print Results

fprintf('UAV Pitch Actuator Limit Study Results\n');
fprintf('------------------------------------------------------------------------------------------------\n');
fprintf('%-16s %-12s %-12s %-12s %-14s %-12s %-12s\n', ...
    'Elev Limit', 'Final', 'Max Pitch', 'Max q', 'Max Elevator', 'Overshoot', 'Settling');
fprintf('------------------------------------------------------------------------------------------------\n');

for i = 1:length(delta_e_max_deg_list)

    if isnan(settling_time_list(i))
        fprintf('%-16.2f %-12.2f %-12.2f %-12.2f %-14.2f %-12.2f %-12s\n', ...
            delta_e_max_deg_list(i), ...
            final_pitch_list(i), ...
            max_pitch_list(i), ...
            max_q_list(i), ...
            max_elevator_list(i), ...
            overshoot_list(i), ...
            'Not settled');
    else
        fprintf('%-16.2f %-12.2f %-12.2f %-12.2f %-14.2f %-12.2f %-12.2f\n', ...
            delta_e_max_deg_list(i), ...
            final_pitch_list(i), ...
            max_pitch_list(i), ...
            max_q_list(i), ...
            max_elevator_list(i), ...
            overshoot_list(i), ...
            settling_time_list(i));
    end
end

%% Save Figure and Results Table

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'uav_pitch_actuator_limit_study.png'));

results_table = table( ...
    delta_e_max_deg_list', ...
    final_pitch_list, ...
    max_pitch_list, ...
    max_q_list, ...
    max_elevator_list, ...
    steady_state_error_list, ...
    overshoot_list, ...
    settling_time_list, ...
    'VariableNames', { ...
    'ElevatorLimit_deg', ...
    'FinalPitch_deg', ...
    'MaxPitch_deg', ...
    'MaxPitchRate_deg_s', ...
    'MaxElevator_deg', ...
    'SteadyStateError_deg', ...
    'Overshoot_percent', ...
    'SettlingTime_s'});

writetable(results_table, fullfile(results_folder, 'uav_pitch_actuator_limit_study_results.csv'));

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