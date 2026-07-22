clear;
clc;
close all;

%% Aircraft Performance Climb Analysis
% This script extends the basic aircraft performance analysis.
%
% The analysis includes:
% - Thrust required
% - Thrust available
% - Excess thrust
% - Excess power
% - Rate of climb
% - Best climb speed
% - Maximum level flight speed

%% Aircraft and Atmospheric Parameters

rho = 1.225;       % Air density at sea level [kg/m^3]
W = 12000;         % Aircraft weight [N]
S = 16.2;          % Wing reference area [m^2]

CD0 = 0.025;       % Zero-lift drag coefficient
k = 0.045;         % Induced drag factor
CL_max = 1.5;      % Maximum lift coefficient

%% Propulsion Parameter

T_available = 1800;    % Constant available thrust [N]

%% Velocity Range

V = 20:1:100;          % Flight speed range [m/s]

%% Dynamic Pressure

q_inf = 0.5 * rho .* V.^2;

%% Required Lift Coefficient for Level Flight

CL_required = W ./ (q_inf .* S);

%% Drag Polar

CD = CD0 + k .* CL_required.^2;

%% Drag and Thrust Required

Drag = q_inf .* S .* CD;
Thrust_required = Drag;

%% Stall Speed

V_stall = sqrt((2 * W) / (rho * S * CL_max));

%% Excess Thrust and Excess Power

Excess_thrust = T_available - Thrust_required;
Excess_power = Excess_thrust .* V;

%% Rate of Climb
% Rate of climb is calculated using:
%
% ROC = Excess Power / Weight

Rate_of_climb = Excess_power ./ W;          % [m/s]
Rate_of_climb_ft_min = Rate_of_climb * 196.85;  % [ft/min]

%% Valid Flight Region
% Speeds below stall speed are not considered valid for steady level flight.

valid_flight = V >= V_stall;
positive_climb = Rate_of_climb > 0;

valid_climb_region = valid_flight & positive_climb;

%% Maximum Rate of Climb and Best Climb Speed

Rate_of_climb_valid = Rate_of_climb;
Rate_of_climb_valid(~valid_climb_region) = NaN;

[max_ROC, idx_max_ROC] = max(Rate_of_climb_valid);
best_climb_speed = V(idx_max_ROC);

max_ROC_ft_min = max_ROC * 196.85;

%% Maximum Level Flight Speed
% Maximum level flight speed occurs where thrust available is still greater
% than or approximately equal to thrust required.

level_flight_possible = valid_flight & (Thrust_required <= T_available);

if any(level_flight_possible)
    max_level_speed = max(V(level_flight_possible));
else
    max_level_speed = NaN;
end

%% Print Results

fprintf('Aircraft Performance Climb Analysis\n');
fprintf('-----------------------------------\n');
fprintf('Aircraft weight              : %.2f N\n', W);
fprintf('Wing area                    : %.2f m^2\n', S);
fprintf('Available thrust            : %.2f N\n', T_available);
fprintf('Stall speed                  : %.2f m/s\n', V_stall);
fprintf('Maximum rate of climb        : %.2f m/s\n', max_ROC);
fprintf('Maximum rate of climb        : %.2f ft/min\n', max_ROC_ft_min);
fprintf('Best climb speed             : %.2f m/s\n', best_climb_speed);
fprintf('Maximum level flight speed   : %.2f m/s\n', max_level_speed);

%% Plot Results

figure;

subplot(3,1,1);
plot(V, Thrust_required, 'LineWidth', 1.8);
hold on;
yline(T_available, '--', 'LineWidth', 1.8);
xline(V_stall, '--', 'LineWidth', 1.5);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Thrust [N]');
title('Thrust Required and Thrust Available');
legend('Thrust Required', 'Thrust Available', 'Stall Speed', 'Location', 'best');

subplot(3,1,2);
plot(V, Excess_power, 'LineWidth', 1.8);
yline(0, '--', 'LineWidth', 1.5);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Excess Power [W]');
title('Excess Power vs Velocity');

subplot(3,1,3);
plot(V, Rate_of_climb, 'LineWidth', 1.8);
hold on;
plot(best_climb_speed, max_ROC, 'o', 'MarkerSize', 8, 'LineWidth', 2);
xline(V_stall, '--', 'LineWidth', 1.5);
yline(0, '--', 'LineWidth', 1.5);
grid on;
xlabel('Velocity V [m/s]');
ylabel('Rate of Climb [m/s]');
title('Rate of Climb vs Velocity');
legend('Rate of Climb', 'Best Climb Point', 'Stall Speed', 'Zero Climb', 'Location', 'best');

sgtitle('Aircraft Performance Climb Analysis');

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

saveas(gcf, fullfile(figures_folder, 'aircraft_performance_climb_analysis.png'));

%% Save Results Table

results_table = table( ...
    V', ...
    CL_required', ...
    CD', ...
    Thrust_required', ...
    repmat(T_available, length(V), 1), ...
    Excess_thrust', ...
    Excess_power', ...
    Rate_of_climb', ...
    Rate_of_climb_ft_min', ...
    'VariableNames', { ...
    'Velocity_m_s', ...
    'CL_required', ...
    'CD', ...
    'ThrustRequired_N', ...
    'ThrustAvailable_N', ...
    'ExcessThrust_N', ...
    'ExcessPower_W', ...
    'RateOfClimb_m_s', ...
    'RateOfClimb_ft_min'});

writetable(results_table, fullfile(tables_folder, 'aircraft_performance_climb_results.csv'));

fprintf('Figure and results table saved successfully.\n');