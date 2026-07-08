clear;
clc;
close all;

%% NACA Airfoil Comparison Analysis
% This script compares simplified aerodynamic characteristics of
% NACA 0012, NACA 2412 and NACA 4412 airfoils.
%
% The analysis uses simplified lift curve and drag polar approximations.

%% Flight Parameters

rho = 1.225;          % Air density [kg/m^3]
V = 30;               % Free-stream velocity [m/s]
S = 1.0;              % Reference area [m^2]

q_inf = 0.5 * rho * V^2;  % Dynamic pressure [Pa]

%% Angle of Attack Range

alpha_deg = -10:1:15;
alpha_rad = deg2rad(alpha_deg);

%% Airfoil Data
% Simplified parameters for comparison

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

Cl_all = zeros(length(airfoil_names), length(alpha_deg));
Cd_all = zeros(length(airfoil_names), length(alpha_deg));
LD_all = zeros(length(airfoil_names), length(alpha_deg));

best_alpha_list = zeros(length(airfoil_names), 1);
max_LD_list = zeros(length(airfoil_names), 1);
max_Cl_list = zeros(length(airfoil_names), 1);
min_Cd_list = zeros(length(airfoil_names), 1);

%% Aerodynamic Calculations

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

    % Store values
    Cl_all(i, :) = Cl;
    Cd_all(i, :) = Cd;
    LD_all(i, :) = LD;

    % Key metrics
    [max_LD, idx] = max(LD);

    best_alpha_list(i) = alpha_deg(idx);
    max_LD_list(i) = max_LD;
    max_Cl_list(i) = max(Cl);
    min_Cd_list(i) = min(Cd);
end

%% Print Results

fprintf('NACA Airfoil Comparison Analysis\n');
fprintf('-------------------------------------------------------------\n');
fprintf('%-12s %-12s %-12s %-12s %-12s\n', ...
    'Airfoil', 'Max L/D', 'Best Alpha', 'Max Cl', 'Min Cd');
fprintf('-------------------------------------------------------------\n');

for i = 1:length(airfoil_names)
    fprintf('%-12s %-12.2f %-12.2f %-12.2f %-12.4f\n', ...
        airfoil_names{i}, ...
        max_LD_list(i), ...
        best_alpha_list(i), ...
        max_Cl_list(i), ...
        min_Cd_list(i));
end

%% Plot Lift Coefficient Comparison

figure;

plot(alpha_deg, Cl_all(1,:), 'LineWidth', 1.8);
hold on;
plot(alpha_deg, Cl_all(2,:), 'LineWidth', 1.8);
plot(alpha_deg, Cl_all(3,:), 'LineWidth', 1.8);

grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('C_L');
title('Lift Coefficient Comparison');
legend(airfoil_names, 'Location', 'best');

%% Save Lift Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, 'Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'naca_airfoil_lift_comparison.png'));

%% Plot Drag Coefficient Comparison

figure;

plot(alpha_deg, Cd_all(1,:), 'LineWidth', 1.8);
hold on;
plot(alpha_deg, Cd_all(2,:), 'LineWidth', 1.8);
plot(alpha_deg, Cd_all(3,:), 'LineWidth', 1.8);

grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('C_D');
title('Drag Coefficient Comparison');
legend(airfoil_names, 'Location', 'best');

saveas(gcf, fullfile(results_folder, 'naca_airfoil_drag_comparison.png'));

%% Plot L/D Ratio Comparison

figure;

plot(alpha_deg, LD_all(1,:), 'LineWidth', 1.8);
hold on;
plot(alpha_deg, LD_all(2,:), 'LineWidth', 1.8);
plot(alpha_deg, LD_all(3,:), 'LineWidth', 1.8);

grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('L/D');
title('Lift-to-Drag Ratio Comparison');
legend(airfoil_names, 'Location', 'best');

saveas(gcf, fullfile(results_folder, 'naca_airfoil_ld_comparison.png'));

%% Save Results Table

comparison_table = table( ...
    airfoil_names', ...
    max_LD_list, ...
    best_alpha_list, ...
    max_Cl_list, ...
    min_Cd_list, ...
    'VariableNames', { ...
    'Airfoil', ...
    'Maximum_LD_Ratio', ...
    'Best_AngleOfAttack_deg', ...
    'Maximum_Cl', ...
    'Minimum_Cd'});

writetable(comparison_table, fullfile(results_folder, 'naca_airfoil_comparison_results.csv'));

fprintf('Comparison figures and results table saved successfully.\n');