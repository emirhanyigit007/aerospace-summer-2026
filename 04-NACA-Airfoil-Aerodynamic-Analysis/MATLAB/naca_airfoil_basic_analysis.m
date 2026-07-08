clear;
clc;
close all;

%% Airfoil and Flight Parameters

airfoil_name = 'NACA 0012';

rho = 1.225;          % Air density at sea level [kg/m^3]
V = 30;               % Free-stream velocity [m/s]
S = 1.0;              % Reference wing area [m^2]

Cd0 = 0.012;          % Zero-lift drag coefficient
k = 0.045;            % Induced drag factor

alpha_deg = -10:1:15; % Angle of attack range [deg]
alpha_rad = deg2rad(alpha_deg);

%% Lift Coefficient Calculation
% Thin airfoil theory approximation:
% Cl = 2*pi*alpha

Cl = 2*pi*alpha_rad;

%% Simple Stall Limitation
% This is a simplified stall representation.
% Real airfoil stall behavior requires experimental or CFD/XFOIL data.

Cl_max = 1.2;
Cl_min = -1.0;

Cl(Cl > Cl_max) = Cl_max;
Cl(Cl < Cl_min) = Cl_min;

%% Drag Coefficient Calculation
% Parabolic drag polar:
% Cd = Cd0 + k*Cl^2

Cd = Cd0 + k*(Cl.^2);

%% Lift-to-Drag Ratio

LD_ratio = Cl ./ Cd;

%% Aerodynamic Forces

q_inf = 0.5 * rho * V^2;  % Dynamic pressure [Pa]

Lift = q_inf * S .* Cl;   % Lift force [N]
Drag = q_inf * S .* Cd;   % Drag force [N]

%% Key Results

[max_LD, max_LD_index] = max(LD_ratio);
best_alpha = alpha_deg(max_LD_index);

fprintf('NACA Airfoil Basic Aerodynamic Analysis\n');
fprintf('---------------------------------------\n');
fprintf('Airfoil name             : %s\n', airfoil_name);
fprintf('Free-stream velocity     : %.2f m/s\n', V);
fprintf('Maximum L/D ratio        : %.2f\n', max_LD);
fprintf('Best angle of attack     : %.2f deg\n', best_alpha);
fprintf('Maximum lift coefficient : %.2f\n', max(Cl));
fprintf('Minimum drag coefficient : %.4f\n', min(Cd));

%% Plot Results

figure;

subplot(3,1,1);
plot(alpha_deg, Cl, 'LineWidth', 1.8);
grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('C_L');
title('Lift Coefficient vs Angle of Attack');

subplot(3,1,2);
plot(alpha_deg, Cd, 'LineWidth', 1.8);
grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('C_D');
title('Drag Coefficient vs Angle of Attack');

subplot(3,1,3);
plot(alpha_deg, LD_ratio, 'LineWidth', 1.8);
grid on;
xlabel('Angle of Attack \alpha [deg]');
ylabel('L/D');
title('Lift-to-Drag Ratio vs Angle of Attack');

sgtitle('NACA 0012 Basic Aerodynamic Analysis');

%% Save Figure

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
project_folder = fileparts(matlab_folder);
results_folder = fullfile(project_folder, 'Results');

if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

saveas(gcf, fullfile(results_folder, 'naca0012_basic_aerodynamic_analysis.png'));

%% Save Results Table

results_table = table( ...
    alpha_deg', ...
    Cl', ...
    Cd', ...
    LD_ratio', ...
    Lift', ...
    Drag', ...
    'VariableNames', { ...
    'AngleOfAttack_deg', ...
    'LiftCoefficient_Cl', ...
    'DragCoefficient_Cd', ...
    'LiftToDragRatio', ...
    'Lift_N', ...
    'Drag_N'});

writetable(results_table, fullfile(results_folder, 'naca0012_basic_aerodynamic_results.csv'));

fprintf('Figure and results table saved successfully.\n');