%% Ramjet Coursework Code for the Advanced Propulsion Class 2024
% Code to calculate relevant output parameters for a ramjet given relevant
% input parameters to the engine.

% Coded by:
% Wesley Hsu
% (Ayo) Ayooluwa Babalola
% Lasen T Wanni Arachchige
% (Jayden) Chi Him Chun

%% Housekeeping
clear
clc
close all

%% Inputs to the code
P_1 = 70000;    % Freestream pressure                   [Pa]
T_1 = 210;      % Freestream temperature                [K]
M_1 = 2.8;      % Flight Mach number                    []
M_N = 1.1;      % Normal shock strength                 []
M_b = 0.42;     % Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;      % Burner pressure                       [Pa]
% Burner pressure ratio (P_b / P_2)
Pb_over_P2 = P_b / P_2; %SHOULD THIS BE 1??

P_4 = P_1;   % Exhaust pressure                      [Pa]       % CHECK
% Exhaust pressure ratio (P_4 / P_1)
P4_over_P1 = P_4 / P_1;

F = 20000;           % Required thrust                       [N]

gamma = 1.4;    % Ratio of specific heats (Changes with T!)
M_2 = 0.2;      % Mach number at start of burner section
R = 287;

epsilon = 44786e3;
f_fa = 0.06641;
C_p = 1.0045e3;

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

[M_y,Ty_over_Tx,Py_over_Px,rhoy_over_rhox] = normalShockRelations(M_N,gamma);

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

% Thermodynamic efficiency
ThermoEff = cycleEfficiency(T_1,T_2,f_fa,epsilon,compressorEff(P_1,P_2,gamma,T_1,T_2),expansionEff(T_b,T_4,P_1,P_2),C_p);

% Propulsive efficiency
PropEff = propEfficiency(gamma,R,M_1,M_4,A_1,A_4,T_1,T_4);

%% Plotting
%% Varying P_1 (Freestream pressure)

% P_1 = 70000
T_1 = 210;      % Freestream temperature                [K]
M_1 = 2.8;      % Flight Mach number                    []
M_N = 1.1;      % Normal shock strength                 []
M_b = 0.42;     % Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;      % Burner pressure                       [Pa]
F = 20000;      % Required thrust                       [N]
P_1 = linspace(0,110000,200);
eta_P1thermo = zeros(1,200);
eta_P1prop = zeros(1,200);
eta_P1total = zeros(1,200);
for i = 1:200
    [eta_P1thermo(i),eta_P1prop(i),eta_P1total(i)] = mainRamjet(P_1(i),T_1,M_1,M_N,M_b,T_b,P_2,P_b,P_4,F,gamma,M_2,R);
end
VaryP1 = figure;
hold on
plot(P_1,eta_P1prop)
plot(P_1,eta_P1thermo)
plot(P_1,eta_P1total)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
hold off
betterPlot(VaryP1)
%% Varying T_1 (Freestream temperature)

P_1 = 70000;
% T_1 = 210;      % Freestream temperature                [K]
M_1 = 2.8;      % Flight Mach number                    []
M_N = 1.1;      % Normal shock strength                 []
M_b = 0.42;     % Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;      % Burner pressure                       [Pa]
F = 20000;      % Required thrust                       [N]

T_1 = linspace(200,350,200);
eta_T1thermo = zeros(1,200);
eta_T1prop = zeros(1,200);
eta_T1total = zeros(1,200);

for i = 1:200
    [eta_T1thermo(i),eta_T1prop(i),eta_T1total(i)] = mainRamjet(P_1,T_1(i),M_1,M_N,M_b,T_b,P_2,P_b,P_4,F,gamma,M_2,R);
end

VaryT1 = figure;
plot(P_1,eta_T1prop)
plot(P_1,eta_T1thermo)
plot(P_1,eta_T1total)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
betterPlot(VaryT1)
%% Varying M_1 (Flight Mach number)
% Varying flight Mach Number

% Defining range over which M_1 (flight Mach number) is varied
M_1_range = linspace(1.5,6,500);

% Using for loop to ittereate throuhg 
for i = [1:length(M_1_range)]
    [A_1,A_C1,A_2,A_b,A_C2,A_4,eta_thermo(i),eta_prop(i),eta_total(i)] = mainRamjet(P_1,T_1,M_1_range(i),M_N,M_b,T_b,P_2,P_b,P_4,F,gamma,M_2,R);
end

% Creating the figure for efficiency vs Flight Mach number
figure
plot(M_1_range,eta_prop)
hold on
plot(M_1_range,eta_thermo)
hold on
plot(M_1_range,eta_total)
hold off
xlabel("Flight Mach number")
ylabel('$\eta$')
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')


% Better Plot
VaryM1thermo = figure;

betterPlot(VaryM1thermo)
% Varying propulsive efficiency
VaryM1prop = figure;

betterPlot(VaryM1prop)
%% Varying M_N (Normal Shock Strength)
% Varying thermodynamic efficiency
VaryMNthermo = figure;

betterPlot(VaryMNthermo)
% Varying propulsive efficiency
VaryMNprop = figure;

betterPlot(VaryMNprop)
%% Varying M_b (Burner entry Mach number)
% Varying thermodynamic efficiency
VaryMbthermo = figure;

betterPlot(VaryMbthermo)
% Varying propulsive efficiency
VaryMbprop = figure;

betterPlot(VaryMbprop)
%% Varying T_b (Burner temperature)
% Varying thermodynamic efficiency
VaryTbthermo = figure;

betterPlot(VaryTbthermo)
% Varying propulsive efficiency
VaryTbprop = figure;

betterPlot(VaryTbprop)
%% Varying P_b/P_2 (Burner pressure ratio)
% Varying thermodynamic efficiency
VaryPbP2thermo = figure;

betterPlot(VaryPbP2thermo)
% Varying propulsive efficiency
VaryPbP2prop = figure;

betterPlot(VaryPbP2prop)
%% Varying P_4/P_1 (Exhaust pressure ratio)
% Varying thermodynamic efficiency
VaryP4P1thermo = figure;

betterPlot(VaryP4P1thermo)
% Varying propulsive efficiency
VaryP4P1prop = figure;

betterPlot(VaryP4P1prop)
%% Varying Thrust (Required Thrust)
% Varying thermodynamic efficiency
VaryTthermo = figure;

betterPlot(VaryTthermo)
% Varying propulsive efficiency
VaryTprop = figure;

betterPlot(VaryTprop)