function [A_1,A_C1,A_2,A_b,A_C2,A_4,eta_thermo,eta_prop,eta_total] = mainRamjet(P_1,T_1,M_1,M_N,M_b,T_b,P_2,P_b,P_4,F,gamma,M_2,R)
% Function to calculate the main output parameters of a ramjet given
% relevant input parameters
%
% Inputs:
% P_1   = Freestream pressure                   [Pa]
% T_1   = Freestream temperature                [K]
% M_1   = Flight Mach number                    []
% M_N   = Normal shock strength                 []
% M_b   = Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
% T_b   = Burner temperature                    [K]
% P_2   = Pressure just before burner entrance  [Pa]
% P_b   = Burner pressure                       [Pa]
%
% Outputs:
% A_1   = Inlet Area
% A_C1  = Inlet Throst Area
% A_2   = Burner Entry Area
% A_b   = Burner Exit Area
% A_C2  = Nozzle Throat Area
% A_4   = Exhaust Area
% eta_t = Thermodynamic Efficiency
% eta_p = Propulsive Efficiency

Pb_over_P2 = P_b / P_2;
P4_over_P1 = P_4 / P_1;

%% Station 1 - Freestream
T01_over_T1 = M2T0ratio(M_1,gamma);
T0x_over_T1 = T01_over_T1;

P01_over_P1 = M2P0ratio(M_1,gamma);

A1_over_A1star = M2arearatio(M_1,gamma);

%% Station C1 - Inlet Throat
A1_over_AC1 = A1_over_A1star;

AC1_over_A1 = 1 / A1_over_AC1;

%% Station x - Just before shock
M_x = M_N;

[M_y,Ty_over_Tx,Py_over_Px,~] = normalShockRelations(M_N,gamma);

T0x_over_Tx = M2T0ratio(M_N,gamma);

As_over_AC1 = M2arearatio(M_N,gamma);
% note T0x = T01, Ax = Ay = Ashock

P0x_over_Px = M2P0ratio(M_x,gamma);

%% Station y - Just after shock
As_over_Aystar = M2arearatio(M_y,gamma);

T0y_over_ty = M2T0ratio(M_y,gamma);

T02_over_Ty = T0y_over_ty;

P0y_over_Py = M2P0ratio(M_y,gamma);

%% Station 2 - Beginning of burner
A2_over_A2star = M2arearatio(M_2,gamma);
A2_over_Aystar = A2_over_A2star;

T02_over_T2 = M2T0ratio(M_2,gamma);
T0y_over_T2 = T02_over_T2;

A2_over_A1 = A2_over_Aystar * (1 / As_over_Aystar) * As_over_AC1 * AC1_over_A1;

T2_over_T1 = (1 / T0y_over_T2) * T0y_over_ty * Ty_over_Tx * (1 / T0x_over_Tx) * T0x_over_T1;

T_2 = T2_over_T1 * T_1;

P02_over_P2 = M2P0ratio(M_2,gamma);

%% Station b - End of burner (burn complete)
%[M_b,~] = RaleighBurner(T_2,T_b,M_2,gamma);
% Needs to be subsonic or flow will choke, one other constraint, see eq
% May need another plot, slide 40 Lecture 3.

Ab_over_A2 = AbA2ratio(P_b,P_2,gamma,M_2,M_b);

Ab_over_A1 = Ab_over_A2 * A2_over_A1;

%% Station C2 - Nozzle throat
P0b_over_Pb = M2P0ratio(M_b,gamma);
P0b_over_P2 = P0b_over_Pb;

T0b_over_Tb = M2T0ratio(M_b,gamma);

Ab_over_Abstar = M2arearatio(M_b,gamma);
Ab_over_AC2 = Ab_over_Abstar;

AC2_over_A1 = (1 / Ab_over_AC2) * Ab_over_A1;

%% Station 4 - Engine exhaust
% CHECK THESE
P04_over_P0b = 1;
P02_over_P0y = 1;
P0x_over_P01 = 1;

P04_over_P4 = P04_over_P0b * P0b_over_Pb * Pb_over_P2 * (1 / P02_over_P2) ...
    * P02_over_P0y * P0y_over_Py * Py_over_Px * (1 / P0x_over_Px)...
    * P0x_over_P01 * P01_over_P1 * (1 / P4_over_P1);

M_4 = P0ratio2M(P04_over_P4,gamma);

T04_over_T4 = M2T0ratio(M_4,gamma);

A4_over_A4star = M2arearatio(M_4,gamma);
A4_over_AC2 = A4_over_A4star;

A4_over_A1 = A4_over_AC2 * AC2_over_A1;

%% Performance
T04_over_T0b = 1;

T4_over_Tb = T0b_over_Tb * T04_over_T0b * (1 / T04_over_T4);
T_4 = T_b * T4_over_Tb;

U_4 = M_4 * sqrt(gamma * R * T_4);

F_over_P1A1 = gamma * M_1^2 * (M_4^2 / M_1^2 * A4_over_A1 - 1); % CHECK, APPROX

%% Outputs
% Inlet area
A_1 = 1 / ( ((P_1 * gamma * M_1^2) / F) *( ((M_4/M_1) ^ 2) * A4_over_A1 -1 ) );

% Inlet throat area
A_C1 = AC1_over_A1 * A_1;

% Burner entry area
A_2 = A2_over_A1 * A_1;

% Burner exit area
A_b = Ab_over_A1 * A_1;

% Nozzle throat area
A_C2 = AC2_over_A1 * A_1;

% Exhaust area
A_4 = A4_over_A1 * A_1;

% Propulsive efficiency
eta_prop = cycleEfficiency(T_1,T_2,f_fa,epsilon,compressorEff(P_1,P_2,gamma,T_1,T_2),expansionEff(T_b,T_4,P_1,P_2,gamma),C_p);

% Thermodynamic efficiency
eta_thermo = propEfficiency(gamma,R,M_1,M_4,A_1,A_4,T_1,T_4);

% Total Efficiency
eta_total = eta_thermo * eta_prop;

end