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
M_N = 1.1;      % Normalc shock strength                []
M_b = 0.42;     % Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;      % Burner pressure                       [Pa]
% % Burner pressure ratio (P_b / P_2)
% Pb_over_P2 = P_b / P_2; %SHOULD THIS BE 1??

%P_4 = P_1;   % Exhaust pressure                      [Pa]       % CHECK
% Exhaust pressure ratio (P_4 / P_1)
<<<<<<< Updated upstream
%P4_over_P1 = P_4 / P_1;
=======
P4_over_P1 = P_4 / P_1;
Pb_over_P2 = P_b / P_2;
>>>>>>> Stashed changes

F = 20000;      % Required thrust                       [N]

gamma = 1.4;    % Ratio of specific heats (Changes with T!)
M_2 = 0.2;      % Mach number at start of burner section
R = 287;

epsilon = 44786e3;
f_fa = 0.06641;
C_p = 1.0045e3;

%% Varying P_1 (Freestream pressure)
P_1_range = linspace(0,120000,200);
eta_P1thermo = zeros(1,200);
eta_P1prop = zeros(1,200);
eta_P1total = zeros(1,200);

for i = 1:200
    [eta_P1prop(i),eta_P1thermo(i),eta_P1total(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1_range(i),R,T_1,T_b);
end
VaryP1 = figure;
hold on
plot(P_1_range,eta_P1prop)
plot(P_1_range,eta_P1thermo)
plot(P_1_range,eta_P1total)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
hold off
ylim([0 1])
betterPlot(VaryP1)
%% Varying T_1 (Freestream temperature)
T_1_range = linspace(200,350,200);
eta_T1thermo = zeros(1,200);
eta_T1prop = zeros(1,200);
eta_T1total = zeros(1,200);
checkError = zeros(1,200);

for i = 1:200
    [eta_T1thermo(i),eta_T1prop(i),eta_T1total(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1_range(i),T_b);
end

VaryT1 = figure;
hold on
plot(T_1_range,eta_T1prop)
plot(T_1_range,eta_T1thermo)
plot(T_1_range,eta_T1total)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
hold off
betterPlot(VaryT1)
%% Varying M_1 (Flight Mach number)
% Varying flight Mach Number

% Defining range over which M_1 (flight Mach number) is varied
M_1_range = linspace(0,8,500);

% Using for loop to ittereate throuhg 
for i = [1:length(M_1_range)]
    [eta_thermo(i),eta_prop(i),eta_total(i)] = mainRamjet(F,gamma,M_1_range(i),M_2,M_N,P_1,R,T_1,T_b);
end

% Creating the figure for efficiency vs Flight Mach number
VaryM1 = figure;
plot(M_1_range,eta_prop)
hold on
plot(M_1_range,eta_thermo)
hold on
plot(M_1_range,eta_total)
hold off
xlabel("Flight Mach Number M$_{1}$")
ylabel('Efficiencies ($\eta$)')
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')

% Better Plot
betterPlot(VaryM1)

%% Varying M_N (Normal Shock Strength)
% Varying Normal Shock Strength
VaryMNthermo = figure;

betterPlot(VaryMNthermo)
%% Varying M_b (Burner entry Mach number)
% Varying thermodynamic efficiency
VaryMbthermo = figure;

betterPlot(VaryMbthermo)
% Varying propulsive efficiency
VaryMbprop = figure;

betterPlot(VaryMbprop)
%% Varying T_b (Burner temperature)

%T_b range
%T_b_range = linspace(T_1,)

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
P4_over_P1 = linspace(0.2,10,500); %From under expanded to over expanded
var P_4

% Calculate efficiencies for each expansion
for i = 1:length(P4_over_P1)
    [eta_Fprop(i), eta_Fthermo(i), eta_Ftotal(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1(i));
end

% Varying thermodynamic efficiency
VaryP4P1thermo = figure;
plot(P4_over_P1, eta_Fthermo, 'LineWidth', 2, 'DisplayName', 'Thermodynamic Efficiency');
hold on;
plot(P4_over_P1, eta_Fprop, 'LineWidth', 2, 'DisplayName', 'Propulsive Efficiency');
plot(P4_over_P1, eta_Ftotal, 'LineWidth', 2, 'DisplayName', 'Total Efficiency');
hold off;

% Set labels and title
xlabel('P4/P1');
ylabel('$\eta $');
title('Efficiency vs P4/P1');
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')
grid on;

% Apply betterPlot style (if necessary)
betterPlot(VaryP4P1thermo); % Applies the betterPlot style to the current figure
%% Varying Thrust (Required Thrust)
F = linspace(0,200e3,500); %thrust range for general ramjet engines

% Calculate efficiencies for each thrust value
for i = 1:length(F)
    [eta_Fprop(i), eta_Fthermo(i), eta_Ftotal(i)] = mainRamjet(F(i),gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plot graphs
VaryT = figure;
plot(F, eta_Fthermo, 'LineWidth', 2, 'DisplayName', 'Thermodynamic Efficiency');
hold on;
plot(F, eta_Fprop, 'LineWidth', 2, 'DisplayName', 'Propulsive Efficiency');
plot(F, eta_Ftotal, 'LineWidth', 2, 'DisplayName', 'Total Efficiency');
hold off;

% Set labels and title
xlabel('Required Thrust (N)');
ylabel('$\eta $');
title('Efficiency vs Required Thrust');
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')
grid on;

% Apply betterPlot style (if necessary)
betterPlot(VaryT); % Applies the betterPlot style to the current figure