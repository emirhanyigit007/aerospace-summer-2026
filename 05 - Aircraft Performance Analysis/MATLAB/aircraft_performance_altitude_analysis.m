clear;
clc;
close all;

%% Aircraft Performance Altitude Analysis
% This script analyzes how altitude affects aircraft performance.
%
% The analysis includes:
% - Air density variation with altitude
% - Stall speed variation
% - Thrust required variation
% - Thrust available variation
% - Rate of climb variation
% - Maximum level flight speed variation

%% Aircraft Parameters

rho0 = 1.225;      % Sea level air density [kg/m^3]
H = 8500;          % Approximate atmospheric scale height [m]

W = 12000;         % Aircraft weight [N]
S = 16.2;          % Wing reference area [m^2]

CD0 = 0.025;       % Zero-lift drag coefficient
k = 0.045;         % Induced drag factor
CL_max = 1.5;      % Maximum lift coefficient

T_available_SL = 1800;   % Sea level available thrust [N]

%% Altitude and Velocity Range

altitudes = [0 1500 3000 4500];   % Altitudes [m]
V = 20:1:120;                     % Velocity range [m/s]

%% Storage Arrays

stall_speeds = zeros(length(altitudes), 1);
max_ROC_values = zeros(length(altitudes), 1);
best_climb_speeds = zeros(length(altitudes), 1);
max_level_speeds = zeros(length(altitudes), 1);
thrust_available_values = zeros(length(altitudes), 1);

Altitude_full = [];
Velocity_full = [];
Density_full = [];
CL_full = [];
CD_full = [];
ThrustRequired_full = [];
ThrustAvailable_full = [];
RateOfClimb_full = [];

%% Figure Setup

figure;

legend_entries = cell(length(altitudes), 1);

%% Altitude Loop

for i = 1:length(altitudes)

    altitude = altitudes(i);

    %% Air Density Model
    % Simplified exponential atmosphere model

    rho = rho0 * exp(-altitude / H);
    sigma = rho / rho0;

    %% Thrust Available Model
    % Available thrust decreases with air density

    T_available = T_available_SL * sigma;

    %% Dynamic Pressure

    q_inf = 0.5 * rho .* V.^2;

    %% Required Lift Coefficient for Level Flight

    CL_required = W ./ (q_inf .* S);

    %% Drag Polar

    CD = CD0 + k .* CL_required.^2;

    %% Drag and Thrust Required

    Drag = q_inf .* S .* CD;
    Thrust_required = Drag;

    %% Power and Rate of Climb

    Excess_thrust = T_available - Thrust_required;
    Excess_power = Excess_thrust .* V;

    Rate_of_climb = Excess_power ./ W;
    Rate_of_climb_ft_min = Rate_of_climb * 196.85;

    %% Stall Speed

    V_stall = sqrt((2 * W) / (rho * S * CL_max));
    stall_speeds(i) = V_stall;

    %% Valid Flight Region

    valid_flight = V >= V_stall;
    valid_climb_region = valid_flight & Rate_of_climb > 0;

    %% Maximum Rate of Climb

    valid_climb_indices = find(valid_climb_region);

    if isempty(valid_climb_indices)
        max_ROC = NaN;
        best_climb_speed = NaN;
    else
        [max_ROC, local_idx] = max(Rate_of_climb(valid_climb_indices));
        best_climb_speed = V(valid_climb_indices(local_idx));
    end

    max_ROC_values(i) = max_ROC;
    best_climb_speeds(i) = best_climb_speed;

    %% Maximum Level Flight Speed

    level_flight_possible = valid_flight & (Thrust_required <= T_available);

    if any(level_flight_possible)
        max_level_speed = max(V(level_flight_possible));
    else
        max_level_speed = NaN;
    end

    max_level_speeds(i) = max_level_speed;
    thrust_available_values(i) = T_available;

    %% Store Full Results

    Altitude_full = [Altitude_full; repmat(altitude, length(V), 1)];
    Velocity_full = [Velocity_full; V'];
    Density_full = [Density_full; repmat(rho, length(V), 1)];
    CL_full = [CL_full; CL_required'];
    CD_full = [CD_full; CD'];
    ThrustRequired_full = [ThrustRequired_full; Thrust_required'];
    ThrustAvailable_full = [ThrustAvailable_full; repmat(T_available, length(V), 1)];
    RateOfClimb_full = [RateOfClimb_full; Rate_of_climb'];

    %% Plot Thrust Required

    subplot(3,1,1);
    hold on;
    plot(V, Thrust_required, 'LineWidth', 1.8);

    %% Plot Rate of Climb

    subplot(3,1,2);
    hold on;
    plot(V, Rate_of_climb, 'LineWidth', 1.8);

    legend_entries{i} = sprintf('%d m', altitude);

end

%% Complete Plots

subplot(3,1,1);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Thrust Required [N]');
title('Thrust Required vs Velocity at Different Altitudes');
legend(legend_entries, 'Location', 'best');

subplot(3,1,2);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Rate of Climb [m/s]');
title('Rate of Climb vs Velocity at Different Altitudes');
yline(0, '--', 'LineWidth', 1.5);
legend(legend_entries, 'Location', 'best');

subplot(3,1,3);
plot(altitudes, stall_speeds, '-o', 'LineWidth', 1.8, 'MarkerSize', 7);
grid on;
xlabel('Altitude [m]');
ylabel('Stall Speed [m/s]');
title('Stall Speed vs Altitude');

sgtitle('Aircraft Performance Altitude Effect Analysis');

%% Print Summary Results

fprintf('Aircraft Performance Altitude Analysis\n');
fprintf('--------------------------------------\n');

for i = 1:length(altitudes)
    fprintf('Altitude: %d m\n', altitudes(i));
    fprintf('Air density                  : %.4f kg/m^3\n', rho0 * exp(-altitudes(i) / H));
    fprintf('Available thrust             : %.2f N\n', thrust_available_values(i));
    fprintf('Stall speed                  : %.2f m/s\n', stall_speeds(i));
    fprintf('Maximum rate of climb        : %.2f m/s\n', max_ROC_values(i));
    fprintf('Maximum rate of climb        : %.2f ft/min\n', max_ROC_values(i) * 196.85);
    fprintf('Best climb speed             : %.2f m/s\n', best_climb_speeds(i));
    fprintf('Maximum level flight speed   : %.2f m/s\n', max_level_speeds(i));
    fprintf('\n');
end

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

saveas(gcf, fullfile(figures_folder, 'aircraft_performance_altitude_analysis.png'));

%% Save Full Results Table

full_results_table = table( ...
    Altitude_full, ...
    Velocity_full, ...
    Density_full, ...
    CL_full, ...
    CD_full, ...
    ThrustRequired_full, ...
    ThrustAvailable_full, ...
    RateOfClimb_full, ...
    'VariableNames', { ...
    'Altitude_m', ...
    'Velocity_m_s', ...
    'AirDensity_kg_m3', ...
    'CL_required', ...
    'CD', ...
    'ThrustRequired_N', ...
    'ThrustAvailable_N', ...
    'RateOfClimb_m_s'});

writetable(full_results_table, fullfile(tables_folder, 'aircraft_performance_altitude_full_results.csv'));

%% Save Summary Results Table

summary_table = table( ...
    altitudes', ...
    thrust_available_values, ...
    stall_speeds, ...
    max_ROC_values, ...
    max_ROC_values * 196.85, ...
    best_climb_speeds, ...
    max_level_speeds, ...
    'VariableNames', { ...
    'Altitude_m', ...
    'ThrustAvailable_N', ...
    'StallSpeed_m_s', ...
    'MaxRateOfClimb_m_s', ...
    'MaxRateOfClimb_ft_min', ...
    'BestClimbSpeed_m_s', ...
    'MaxLevelFlightSpeed_m_s'});

writetable(summary_table, fullfile(tables_folder, 'aircraft_performance_altitude_summary_results.csv'));

fprintf('Altitude analysis figure and result tables saved successfully.\n');