clear;
clc;
close all;

%% Aircraft Performance Basic Analysis
% This script performs a basic aircraft performance analysis using MATLAB.
%
% The analysis includes:
% - Lift coefficient calculation
% - Drag polar
% - Drag force
% - Thrust required
% - Power required
% - Stall speed
% - Best range speed approximation
% - Best endurance speed approximation

%% Aircraft and Atmospheric Parameters

rho = 1.225;       % Air density at sea level [kg/m^3]
W = 12000;         % Aircraft weight [N]
S = 16.2;          % Wing reference area [m^2]

CD0 = 0.025;       % Zero-lift drag coefficient
k = 0.045;         % Induced drag factor
CL_max = 1.5;      % Maximum lift coefficient

%% Velocity Range

V = 20:1:100;      % Flight speed range [m/s]

%% Dynamic Pressure

q_inf = 0.5 * rho .* V.^2;

%% Lift Coefficient Required for Level Flight
% In steady level flight:
% Lift = Weight
%
% L = 0.5 * rho * V^2 * S * CL
% Therefore:
% CL = W / (0.5 * rho * V^2 * S)

CL_required = W ./ (q_inf .* S);

%% Drag Polar
% CD = CD0 + k * CL^2

CD = CD0 + k .* CL_required.^2;

%% Drag Force
% D = 0.5 * rho * V^2 * S * CD

Drag = q_inf .* S .* CD;

%% Thrust Required
% In steady level flight, thrust required equals drag.

Thrust_required = Drag;

%% Power Required
% P = T * V

Power_required = Thrust_required .* V;

%% Stall Speed
% V_stall = sqrt(2W / (rho*S*CLmax))

V_stall = sqrt((2 * W) / (rho * S * CL_max));

%% Best Range and Best Endurance Approximation

% Jet aircraft best range approximation:
% Minimum drag condition
[minimum_drag, idx_min_drag] = min(Drag);
best_range_speed = V(idx_min_drag);

% Propeller aircraft best endurance approximation:
% Minimum power required condition
[minimum_power, idx_min_power] = min(Power_required);
best_endurance_speed = V(idx_min_power);

%% Print Results

fprintf('Aircraft Performance Basic Analysis\n');
fprintf('-----------------------------------\n');
fprintf('Aircraft weight              : %.2f N\n', W);
fprintf('Wing area                    : %.2f m^2\n', S);
fprintf('Zero-lift drag coefficient   : %.4f\n', CD0);
fprintf('Induced drag factor          : %.4f\n', k);
fprintf('Maximum lift coefficient     : %.2f\n', CL_max);
fprintf('Stall speed                  : %.2f m/s\n', V_stall);
fprintf('Minimum drag                 : %.2f N\n', minimum_drag);
fprintf('Best range speed             : %.2f m/s\n', best_range_speed);
fprintf('Minimum power required       : %.2f W\n', minimum_power);
fprintf('Best endurance speed         : %.2f m/s\n', best_endurance_speed);

%% Plot Results

figure;

subplot(4,1,1);
plot(V, CL_required, 'LineWidth', 1.8);
grid on;
xlabel('Velocity V [m/s]');
ylabel('C_L Required');
title('Required Lift Coefficient vs Velocity');

subplot(4,1,2);
plot(V, Drag, 'LineWidth', 1.8);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Drag [N]');
title('Drag Force vs Velocity');

subplot(4,1,3);
plot(V, Thrust_required, 'LineWidth', 1.8);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Thrust Required [N]');
title('Thrust Required vs Velocity');

subplot(4,1,4);
plot(V, Power_required, 'LineWidth', 1.8);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Power Required [W]');
title('Power Required vs Velocity');

sgtitle('Aircraft Performance Basic Analysis');

%% Save Results

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
figures_folder = fullfile(project_folder, 'Results', 'Figures');
tables_folder = fullfile(project_folder, 'Results', 'Tables');

if ~exist(figures_folder, 'dir')
    mkdir(figures_folder);
end

if ~exist(tables_folder, 'dir')
    mkdir(tables_folder);
end

saveas(gcf, fullfile(figures_folder, 'aircraft_performance_basic_analysis.png'));

%% Save Results Table

results_table = table( ...
    V', ...
    CL_required', ...
    CD', ...
    Drag', ...
    Thrust_required', ...
    Power_required', ...
    'VariableNames', { ...
    'Velocity_m_s', ...
    'CL_required', ...
    'CD', ...
    'Drag_N', ...
    'ThrustRequired_N', ...
    'PowerRequired_W'});

writetable(results_table, fullfile(tables_folder, 'aircraft_performance_basic_results.csv'));

fprintf('Figure and results table saved successfully.\n');