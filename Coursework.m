clear
clc
close all

%% Inputs to the code
P_1 = % Freestream pressure
T_1 = % Freestream temperature
M_1 = % Flight Mach number
M_N = % Normal shock strength
M_b = % Burner entry Mach number
T_b = % Burner temperature
P_2 = % Pressure just before burner entrance
P_b = % Burner pressure
% Burner pressure ratio (P_b / P_2)

P_4 = % Exhaust pressure
% Exhaust pressure ratio (P_4 / P_1)

Thrust = % Required thrust

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