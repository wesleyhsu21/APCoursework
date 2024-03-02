clear
clc
close all

%% Inputs to the code
P_1 = 70000;   % Freestream pressure                   [Pa]
T_1 = 210;   % Freestream temperature                [K]
M_1 = 2.8;        % Flight Mach number                    []
M_N = 1.1;      % Normal shock strength                 []
M_b = 0.42;      % Burner entry Mach number              []
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;   % Burner pressure                       [Pa]
% Burner pressure ratio (P_b / P_2)
Pb_over_P2 = P_b / P_2; %SHOULD THIS BE 1??

P_4 = 101325;   % Exhaust pressure                      [Pa]
% Exhaust pressure ratio (P_4 / P_1)
P4_over_P1 = P_4 / P_1;

%Thrust =        % Required thrust                       [N]

gamma = 1.4;    % Ratio of specific heats (Changes with T!)
M_2 = 0.2;      % Mach number at start of burner section

% Outputs to code:
% Inlet area
% Inlet throat area
% Burner entry area
% Burner exit area
% Nozzle throat area
% Exhaust area
% Thermodynamic efficiency
% Propulsive efficiency

%% Main

% Station 1 - Freestream
T01_over_T1 = M2T0ratio(M_1,gamma);
T0x_over_T1 = T01_over_T1;

P01_over_P1 = M2P0ratio(M_1,gamma);

A1_over_A1star = M2arearatio(M_1,gamma);

% Station C1 - Inlet Throat
A1_over_AC1 = A1_over_A1star;

AC1_over_A1 = 1 / A1_over_AC1;

% Station x - Just before shock
[M_y,Ty_over_Tx,Py_over_Px,rhoy_over_rhox] = normalShockRelations(M_N,gamma);

T0x_over_Tx = M2T0ratio(M_N,gamma);

As_over_AC1 = M2arearatio(M_N,gamma);
% note T0x = T01, Ax = Ay = Ashock

% Station y - Just after shock
As_over_Aystar = M2arearatio(M_y,gamma);

T0y_over_ty = M2T0ratio(M_y,gamma);

T02_over_Ty = T0y_over_ty;

% Station 2 - Beginning of burner
A2_over_A2star = M2arearatio(M_2,gamma);
A2_over_Aystar = A2_over_A2star;

T02_over_T2 = M2T0ratio(M_2,gamma);
T0y_over_T2 = T02_over_T2;

A2_over_A1 = A2_over_Aystar * (1 / As_over_Aystar) * As_over_AC1 * AC1_over_A1;

T2_over_T1 = (1 / T0y_over_T2) * T0y_over_ty * Ty_over_Tx * (1 / T0x_over_Tx) * T0x_over_T1;

T_2 = T2_over_T1 * T_1;

% Station b - End of burner (burn complete)

% Station C2 - Nozzle throat

% Station 2 - Engine exhaust


%% Plotting

%% Varying P_1 (Freestream pressure)
% Varying thermodynamic efficiency


% Varying propulsive efficiency



%% Varying T_1 (Freestream temperature)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying M_1 (Flight Mach number)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying M_N (Normal Shock Strength)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying M_b (Burner entry Mach number)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying T_b (Burner temperature)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying P_b/P_2 (Burner pressure ratio)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying P_4/P_1 (Exhaust pressure ratio)
% Varying thermodynamic efficiency


% Varying propulsive efficiency




%% Varying Thrust (Required Thrust)
% Varying thermodynamic efficiency


% Varying propulsive efficiency



