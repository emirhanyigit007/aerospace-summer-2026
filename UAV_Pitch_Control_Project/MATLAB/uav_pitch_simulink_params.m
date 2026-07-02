clear;
clc;

%% UAV Pitch Control - Simulink Parameters

% Model parameters
omega_n = 1.8;      % Natural frequency [rad/s]
zeta = 0.45;        % Damping ratio [-]
K_theta = 3.0;      % Elevator-to-pitch gain [1/s^2]

% Final PID gains
Kp = 4.0;
Ki = 1.2;
Kd = 1.8;

% Pitch command
theta_ref_deg = 10;     % Desired pitch angle [deg]

% Elevator saturation
delta_e_max_deg = 15;   % Elevator limit for 10 deg command [deg]

% Transfer function coefficients
num_pitch = K_theta;
den_pitch = [1, 2*zeta*omega_n, omega_n^2];

% Simulation time
sim_time = 20;

fprintf('Simulink parameters loaded successfully.\n');
fprintf('Pitch plant transfer function:\n');
fprintf('G(s) = %.2f / (s^2 + %.2f s + %.2f)\n', ...
    K_theta, 2*zeta*omega_n, omega_n^2);