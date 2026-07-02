clc;
clear;
close all;

%% UAV Pitch Control - Simulink Performance Analysis
% This script runs the Simulink model and calculates performance metrics.

%% Load Parameters

uav_pitch_simulink_params;

%% Run Simulink Model

out = sim('uav_pitch_pid_control');

%% Extract Data

t = out.get('t_simulink');
theta = out.get('theta_simulink');
delta_e = out.get('delta_e_simulink');
error = out.get('error_simulink');

t = t(:);
theta = theta(:);
delta_e = delta_e(:);
error = error(:);

%% Performance Metrics

theta_final = theta(end);
theta_max = max(theta);
max_elevator = max(abs(delta_e));
steady_state_error = theta_ref_deg - theta_final;

if theta_max > theta_ref_deg
    overshoot = ((theta_max - theta_ref_deg) / theta_ref_deg) * 100;
else
    overshoot = 0;
end

% 2 percent settling time
tolerance = 0.02 * abs(theta_ref_deg);
settling_time = NaN;

for i = 1:length(t)
    if all(abs(theta(i:end) - theta_ref_deg) <= tolerance)
        settling_time = t(i);
        break;
    end
end

%% Print Results

fprintf('Simulink UAV Pitch Control Performance Results\n');
fprintf('----------------------------------------------\n');
fprintf('Target pitch angle     : %.2f deg\n', theta_ref_deg);
fprintf('Final pitch angle      : %.2f deg\n', theta_final);
fprintf('Maximum pitch angle    : %.2f deg\n', theta_max);
fprintf('Maximum elevator input : %.2f deg\n', max_elevator);
fprintf('Steady-state error     : %.2f deg\n', steady_state_error);
fprintf('Overshoot              : %.2f %%\n', overshoot);

if isnan(settling_time)
    fprintf('Settling time          : Not settled\n');
else
    fprintf('Settling time          : %.2f s\n', settling_time);
end

%% Save Results as CSV

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, '03_Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

performance_table = table( ...
    theta_ref_deg, ...
    theta_final, ...
    theta_max, ...
    max_elevator, ...
    steady_state_error, ...
    overshoot, ...
    settling_time, ...
    'VariableNames', { ...
    'TargetPitch_deg', ...
    'FinalPitch_deg', ...
    'MaxPitch_deg', ...
    'MaxElevator_deg', ...
    'SteadyStateError_deg', ...
    'Overshoot_percent', ...
    'SettlingTime_s'});

writetable(performance_table, fullfile(results_folder, 'uav_pitch_simulink_performance.csv'));

fprintf('Performance results saved successfully.\n');