clc;
close all;

%% UAV Pitch Control - Simulink Results Plot
% This script plots the Simulink simulation results and saves the figure.

%% Extract Simulink Output Data

t_simulink = out.get('t_simulink');
theta_simulink = out.get('theta_simulink');
delta_e_simulink = out.get('delta_e_simulink');
error_simulink = out.get('error_simulink');

%% Reference Command

theta_ref_deg = 10;

%% Plot Results

figure;

subplot(3,1,1);
plot(t_simulink, theta_simulink, 'LineWidth', 1.8);
hold on;
yline(theta_ref_deg, '--', 'LineWidth', 1.4);
grid on;
xlabel('Time [s]');
ylabel('\theta [deg]');
title('Pitch Angle Response');
legend('Simulink Pitch Response', 'Target Pitch Angle', 'Location', 'best');

subplot(3,1,2);
plot(t_simulink, delta_e_simulink, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('\delta_e [deg]');
title('Elevator Command');

subplot(3,1,3);
plot(t_simulink, error_simulink, 'LineWidth', 1.8);
grid on;
xlabel('Time [s]');
ylabel('Error [deg]');
title('Pitch Tracking Error');

sgtitle('UAV Longitudinal Pitch Control - Simulink Results');

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'uav_pitch_simulink_results.png'));

fprintf('Simulink results figure saved successfully.\n');