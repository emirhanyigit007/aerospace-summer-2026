clear;
clc;
close all;

%% Run All Aircraft Performance Analyses
% This script runs all MATLAB analyses for the
% Aircraft Performance Analysis project.
%
% Project:
% 05 - Aircraft Performance Analysis Using MATLAB

fprintf('Running Aircraft Performance Analysis Project...\n');
fprintf('-----------------------------------------------\n\n');

%% Set MATLAB Folder Path

script_path = mfilename('fullpath');
matlab_folder = fileparts(script_path);
addpath(matlab_folder);

%% Run Basic Aircraft Performance Analysis

fprintf('1. Running basic aircraft performance analysis...\n\n');
aircraft_performance_basic_analysis;

fprintf('\nBasic aircraft performance analysis completed.\n');
fprintf('-----------------------------------------------\n\n');

%% Run Climb Performance Analysis

fprintf('2. Running climb performance analysis...\n\n');
aircraft_performance_climb_analysis;

fprintf('\nClimb performance analysis completed.\n');
fprintf('-----------------------------------------------\n\n');

%% Run Altitude Effect Analysis

fprintf('3. Running altitude effect analysis...\n\n');
aircraft_performance_altitude_analysis;

fprintf('\nAltitude effect analysis completed.\n');
fprintf('-----------------------------------------------\n\n');

%% Final Message

fprintf('All aircraft performance analyses completed successfully.\n');
fprintf('Figures are saved in: Results/Figures\n');
fprintf('Tables are saved in : Results/Tables\n');