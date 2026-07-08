clear;
clc;
close all;

%% NACA Airfoil Velocity Effect Analysis
% This script analyzes the effect of free-stream velocity on lift and drag
% forces for NACA 0012, NACA 2412 and NACA 4412 airfoils.
%
% The best aerodynamic operating point for each airfoil is calculated
% automatically based on maximum lift-to-drag ratio.

%% Flight Parameters

rho = 1.225;          % Air density at sea level [kg/m^3]
S = 1.0;              % Reference wing area [m^2]

V = 10:5:50;          % Free-stream velocity range [m/s]

%% Angle of Attack Range

alpha_deg = -10:1:15;
alpha_rad = deg2rad(alpha_deg);

%% Airfoil Data

airfoil_names = {'NACA 0012', 'NACA 2412', 'NACA 4412'};

% Zero-lift angle of attack [deg]
alpha_L0_deg = [0, -2, -4];

% Maximum lift coefficient
Cl_max_values = [1.2, 1.4, 1.6];

% Minimum drag coefficient
Cd0_values = [0.012, 0.014, 0.016];

% Induced drag factor
k_values = [0.045, 0.050, 0.055];

%% Storage

Cl_best = zeros(length(airfoil_names), 1);
Cd_best = zeros(length(airfoil_names), 1);
LD_best = zeros(length(airfoil_names), 1);
best_alpha_deg = zeros(length(airfoil_names), 1);

Lift_all = zeros(length(airfoil_names), length(V));
Drag_all = zeros(length(airfoil_names), length(V));
q_inf_all = zeros(1, length(V));

%% Find Best Aerodynamic Operating Point for Each Airfoil

for i = 1:length(airfoil_names)

    alpha_effective_rad = deg2rad(alpha_deg - alpha_L0_deg(i));

    % Lift coefficient approximation
    Cl = 2*pi*alpha_effective_rad;

    % Stall limitation
    Cl_max = Cl_max_values(i);
    Cl_min = -1.0;

    Cl(Cl > Cl_max) = Cl_max;
    Cl(Cl < Cl_min) = Cl_min;

    % Drag polar
    Cd0 = Cd0_values(i);
    k = k_values(i);

    Cd = Cd0 + k*(Cl.^2);

    % Lift-to-drag ratio
    LD = Cl ./ Cd;

    % Find maximum L/D point
    [LD_best(i), idx] = max(LD);

    best_alpha_deg(i) = alpha_deg(idx);
    Cl_best(i) = Cl(idx);
    Cd_best(i) = Cd(idx);
end

%% Force Calculations for Different Velocities

for j = 1:length(V)

    q_inf = 0.5 * rho * V(j)^2;
    q_inf_all(j) = q_inf;

    for i = 1:length(airfoil_names)

        Lift_all(i, j) = q_inf * S * Cl_best(i);
        Drag_all(i, j) = q_inf * S * Cd_best(i);

    end
end

%% Print Results at 30 m/s

fprintf('NACA Airfoil Velocity Effect Analysis\n');
fprintf('--------------------------------------------------------------------------\n');
fprintf('%-12s %-12s %-12s %-12s %-12s %-12s\n', ...
    'Airfoil', 'Best Alpha', 'Cl_best', 'Lift@30m/s', 'Drag@30m/s', 'L/D');
fprintf('--------------------------------------------------------------------------\n');

V_reference = 30;
[~, idx_ref] = min(abs(V - V_reference));

for i = 1:length(airfoil_names)

    fprintf('%-12s %-12.2f %-12.3f %-12.2f %-12.2f %-12.2f\n', ...
        airfoil_names{i}, ...
        best_alpha_deg(i), ...
        Cl_best(i), ...
        Lift_all(i, idx_ref), ...
        Drag_all(i, idx_ref), ...
        LD_best(i));
end

%% Plot Lift Force Comparison

figure;

plot(V, Lift_all(1,:), 'LineWidth', 1.8);
hold on;
plot(V, Lift_all(2,:), 'LineWidth', 1.8);
plot(V, Lift_all(3,:), 'LineWidth', 1.8);

grid on;
xlabel('Free-stream Velocity V [m/s]');
ylabel('Lift Force [N]');
title('Lift Force vs Free-stream Velocity');
legend(airfoil_names, 'Location', 'best');

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, 'Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'naca_airfoil_lift_vs_velocity.png'));

%% Plot Drag Force Comparison

figure;

plot(V, Drag_all(1,:), 'LineWidth', 1.8);
hold on;
plot(V, Drag_all(2,:), 'LineWidth', 1.8);
plot(V, Drag_all(3,:), 'LineWidth', 1.8);

grid on;
xlabel('Free-stream Velocity V [m/s]');
ylabel('Drag Force [N]');
title('Drag Force vs Free-stream Velocity');
legend(airfoil_names, 'Location', 'best');

saveas(gcf, fullfile(results_folder, 'naca_airfoil_drag_vs_velocity.png'));

%% Save Results Table

velocity_results_table = table( ...
    V', ...
    q_inf_all', ...
    Lift_all(1,:)', ...
    Drag_all(1,:)', ...
    Lift_all(2,:)', ...
    Drag_all(2,:)', ...
    Lift_all(3,:)', ...
    Drag_all(3,:)', ...
    'VariableNames', { ...
    'Velocity_m_s', ...
    'DynamicPressure_Pa', ...
    'NACA0012_Lift_N', ...
    'NACA0012_Drag_N', ...
    'NACA2412_Lift_N', ...
    'NACA2412_Drag_N', ...
    'NACA4412_Lift_N', ...
    'NACA4412_Drag_N'});

writetable(velocity_results_table, fullfile(results_folder, 'naca_airfoil_velocity_effect_results.csv'));

fprintf('Velocity effect figures and results table saved successfully.\n');