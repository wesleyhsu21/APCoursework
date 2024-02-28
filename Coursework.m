clear
clc
close all

%% Inputs to the code
P_1 = 101325    % Freestream pressure                   [Pa]
T_1 = 288.15    % Freestream temperature                [K]
M_1 = 3         % Flight Mach number                    []
M_N = 1.1       % Normal shock strength                 []
M_b = 400       % Burner entry Mach number              []
T_b = 1200      % Burner temperature                    [K]
P_2 = 150000    % Pressure just before burner entrance  [Pa]
P_b = 100000    % Burner pressure                       [Pa]
% Burner pressure ratio (P_b / P_2)

P_4 = 101325    % Exhaust pressure                      [Pa]
% Exhaust pressure ratio (P_4 / P_1)

Thrust =        % Required thrust                       [N]

% Outputs to code:
% Inlet area
% Inlet throat area
% Burner entry area
% Burner exit area
% Nozzle throat area
% Exhaust area
% Thermodynamic efficiency
% Propulsive efficiency

%%