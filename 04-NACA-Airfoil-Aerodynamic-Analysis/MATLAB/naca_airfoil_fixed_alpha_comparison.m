clear;
clc;
close all;

%% NACA Airfoil Fixed Angle of Attack Comparison
% This script compares lift and drag forces of different NACA airfoils
% at the same angle of attack.

%% Flight Parameters

rho = 1.225;          % Air density [kg/m^3]
V = 30;               % Free-stream velocity [m/s]
S = 1.0;              % Reference area [m^2]

q_inf = 0.5 * rho * V^2;

%% Fixed Angle of Attack

alpha_fixed_deg = 5;  % Fixed angle of attack [deg]

%% Airfoil Data

airfoil_names = {'NACA 0012', 'NACA 2412', 'NACA 4412'};

alpha_L0_deg = [0, -2, -4];       % Zero-lift angle of attack [deg]
Cl_max_values = [1.2, 1.4, 1.6];  % Maximum lift coefficient
Cd0_values = [0.012, 0.014, 0.016];
k_values = [0.045, 0.050, 0.055];

%% Storage

Cl_values = zeros(length(airfoil_names), 1);
Cd_values = zeros(length(airfoil_names), 1);
LD_values = zeros(length(airfoil_names), 1);
Lift_values = zeros(length(airfoil_names), 1);
Drag_values = zeros(length(airfoil_names), 1);

%% Calculations

for i = 1:length(airfoil_names)

    alpha_effective_rad = deg2rad(alpha_fixed_deg - alpha_L0_deg(i));

    Cl = 2*pi*alpha_effective_rad;

    % Stall limitation
    Cl_max = Cl_max_values(i);
    Cl_min = -1.0;

    if Cl > Cl_max
        Cl = Cl_max;
    elseif Cl < Cl_min
        Cl = Cl_min;
    end

    Cd = Cd0_values(i) + k_values(i) * Cl^2;
    LD = Cl / Cd;

    Lift = q_inf * S * Cl;
    Drag = q_inf * S * Cd;

    Cl_values(i) = Cl;
    Cd_values(i) = Cd;
    LD_values(i) = LD;
    Lift_values(i) = Lift;
    Drag_values(i) = Drag;
end

%% Print Results

fprintf('NACA Airfoil Fixed Angle of Attack Comparison\n');
fprintf('Fixed angle of attack: %.2f deg\n', alpha_fixed_deg);
fprintf('--------------------------------------------------------------------------\n');
fprintf('%-12s %-12s %-12s %-12s %-12s %-12s\n', ...
    'Airfoil', 'Cl', 'Cd', 'L/D', 'Lift[N]', 'Drag[N]');
fprintf('--------------------------------------------------------------------------\n');

for i = 1:length(airfoil_names)
    fprintf('%-12s %-12.3f %-12.4f %-12.2f %-12.2f %-12.2f\n', ...
        airfoil_names{i}, ...
        Cl_values(i), ...
        Cd_values(i), ...
        LD_values(i), ...
        Lift_values(i), ...
        Drag_values(i));
end

%% Plot Lift Comparison

figure;

bar(Lift_values);
grid on;
set(gca, 'XTickLabel', airfoil_names);
ylabel('Lift Force [N]');
title(['Lift Force Comparison at \alpha = ', num2str(alpha_fixed_deg), ' deg']);

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, 'Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'naca_airfoil_fixed_alpha_lift_comparison.png'));

%% Plot Drag Comparison

figure;

bar(Drag_values);
grid on;
set(gca, 'XTickLabel', airfoil_names);
ylabel('Drag Force [N]');
title(['Drag Force Comparison at \alpha = ', num2str(alpha_fixed_deg), ' deg']);

saveas(gcf, fullfile(results_folder, 'naca_airfoil_fixed_alpha_drag_comparison.png'));

%% Save Results Table

fixed_alpha_table = table( ...
    airfoil_names', ...
    Cl_values, ...
    Cd_values, ...
    LD_values, ...
    Lift_values, ...
    Drag_values, ...
    'VariableNames', { ...
    'Airfoil', ...
    'LiftCoefficient_Cl', ...
    'DragCoefficient_Cd', ...
    'LiftToDragRatio', ...
    'Lift_N', ...
    'Drag_N'});

writetable(fixed_alpha_table, fullfile(results_folder, 'naca_airfoil_fixed_alpha_results.csv'));

fprintf('Fixed angle comparison figures and results table saved successfully.\n');