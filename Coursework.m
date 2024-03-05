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
    [eta_P1prop(i),eta_P1thermo(i),eta_P1total(i)] = mainRamjet(P_1(i),T_1,M_1,M_N,M_b,T_b,P_2,P_b,P_4,F,gamma,M_2,R,f_fa,epsilon);
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

%T_b range
T_b_range = linspace(T_1,)

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
F = linspace(0,200e3,500); %thrust range for general ramjet engines



% Varying thermodynamic efficiency
VaryTthermo = figure;

betterPlot(VaryTthermo)
% Varying propulsive efficiency
VaryTprop = figure;

betterPlot(VaryTprop)