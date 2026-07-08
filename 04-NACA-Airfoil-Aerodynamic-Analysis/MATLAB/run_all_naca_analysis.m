clear;
clc;
close all;

fprintf('Running NACA Airfoil Aerodynamic Analysis Project...\n\n');

fprintf('1. Running basic NACA 0012 analysis...\n');
naca_airfoil_basic_analysis;

fprintf('\n2. Running NACA airfoil comparison analysis...\n');
naca_airfoil_comparison;

fprintf('\n3. Running velocity effect analysis...\n');
naca_airfoil_velocity_effect;

fprintf('\n4. Running fixed angle of attack comparison...\n');
naca_airfoil_fixed_alpha_comparison;

fprintf('\nAll NACA airfoil analyses completed successfully.\n');