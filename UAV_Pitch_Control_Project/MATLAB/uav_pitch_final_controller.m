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

%% Final PID Gains

Kp = 4.0;
Ki = 1.2;
Kd = 1.8;

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

%% Numerical Solution

[t, x] = ode45(@(t, x) uav_pitch_pid_dynamics(t, x, theta_ref, ...
    omega_n, zeta, K_theta, Kp, Ki, Kd, delta_e_max), tspan, x0);

%% Extract States

theta = x(:,1);
q = x(:,2);
integral_e = x(:,3);

%% Calculate Error and Elevator Command

error = theta_ref - theta;

delta_e = Kp*error + Ki*integral_e - Kd*q;

% Apply saturation for plotting
delta_e(delta_e > delta_e_max) = delta_e_max;
delta_e(delta_e < -delta_e_max) = -delta_e_max;

%% Convert to Degrees

theta_deg = rad2deg(theta);
q_deg = rad2deg(q);
error_deg = rad2deg(error);
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

% Settling time calculation, 2 percent band
tolerance = 0.02 * abs(theta_ref_deg);
settling_time = NaN;

for i = 1:length(t)
    if all(abs(theta_deg(i:end) - theta_ref_deg) <= tolerance)
        settling_time = t(i);
        break;
    end
end

%% Print Results

fprintf('Final UAV Pitch PID Controller Results\n');
fprintf('--------------------------------------\n');
fprintf('Kp                     : %.2f\n', Kp);
fprintf('Ki                     : %.2f\n', Ki);
fprintf('Kd                     : %.2f\n', Kd);
fprintf('Target pitch angle     : %.2f deg\n', theta_ref_deg);
fprintf('Final pitch angle      : %.2f deg\n', theta_final);
fprintf('Maximum pitch angle    : %.2f deg\n', theta_max);
fprintf('Maximum pitch rate     : %.2f deg/s\n', q_max);
fprintf('Maximum elevator input : %.2f deg\n', max_elevator);
fprintf('Steady-state error     : %.2f deg\n', steady_state_error);
fprintf('Overshoot              : %.2f %%\n', overshoot);

if isnan(settling_time)
    fprintf('Settling time          : Not settled within simulation time\n');
else
    fprintf('Settling time          : %.2f s\n', settling_time);
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
legend('Actual Pitch Angle', 'Target Pitch Angle', 'Location', 'best');

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
title('Pitch Tracking Error');

sgtitle('Final UAV Pitch Control Response');

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'uav_pitch_final_controller_response.png'));

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