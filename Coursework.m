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
M_b = 0.42;      % Burner entry Mach number              []         % ASSIGNED SOMEWHERE ELSE??
T_b = 1700;     % Burner temperature                    [K]
P_2 = 150000;   % Pressure just before burner entrance  [Pa]
P_b = P_2;      % Burner pressure                       [Pa]

% Burner pressure ratio
Pb_over_P2 = 1;

% Exhaust pressure ratio (P_4 / P_1)
P4_over_P1 = 1;

F = 20000;      % Required thrust                       [N]

gamma = 1.4;    % Ratio of specific heats (Changes with T!)
M_2 = 0.26;      % Mach number at start of burner section
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
    [eta_P1thermo(i),eta_P1prop(i),eta_P1total(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1_range(i),R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

VaryP1 = figure;
hold on
plot(P_1_range,eta_P1prop, 'LineWidth', 1)
plot(P_1_range,eta_P1thermo, 'LineWidth', 1)
plot(P_1_range,eta_P1total, 'LineWidth', 1)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
ylabel("$\eta$")
xlabel("$P_1$ / Pa")
hold off
ylim([0 1])
xlim([0 120000])
betterPlot(VaryP1)
%% Varying T_1 (Freestream temperature)
T_1_range = linspace(0,1000,500);
eta_T1thermo = zeros(1,500);
eta_T1prop = zeros(1,500);
eta_T1total = zeros(1,500);

for i = 1:500
    [eta_T1thermo(i),eta_T1prop(i),eta_T1total(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1_range(i),T_b,Pb_over_P2,P4_over_P1);
end

VaryT1 = figure;
hold on
plot(T_1_range,eta_T1prop, 'LineWidth', 1)
plot(T_1_range,eta_T1thermo, 'LineWidth', 1)
plot(T_1_range,eta_T1total, 'LineWidth', 1)
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",Location="northeastoutside")
ylabel("$\eta$")
xlabel("$T_1$ / K")
hold off
betterPlot(VaryT1)
%% Varying M_1 (Flight Mach number)
% Varying flight Mach Number

% Defining range over which M_1 (flight Mach number) is varied
M_1_range = linspace(0,8,500);

% Using for loop to ittereate throuhg 
for i = [1:length(M_1_range)]
    [eta_thermo(i),eta_prop(i),eta_total(i)] = mainRamjet(F,gamma,M_1_range(i),M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Creating the figure for efficiency vs Flight Mach number
VaryM1 = figure;
hold on
plot(M_1_range,eta_thermo, 'LineWidth', 1)
plot(M_1_range,eta_prop, 'LineWidth', 1)
plot(M_1_range,eta_total, 'LineWidth', 1)
hold off
xlabel("M$_{1}$")
ylabel('$\eta$')
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')

% Better Plot
betterPlot(VaryM1)

%% Varying M_N (Normal Shock Strength)
% Varying Normal Shock Strength
% Defining range over which M_N (Normal Shock Strength) is varied
M_N_range = linspace(0,6,500);

% Using for loop to ittereate throuhg 
for i = [1:length(M_N_range)]
    [eta_thermo(i),eta_prop(i),eta_total(i)] = mainRamjet(F,gamma,M_1,M_2,M_N_range(i),P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Creating the figure for efficiency vs Flight Mach number
VaryMN = figure;
hold on
plot(M_N_range,eta_thermo, 'LineWidth', 1)
plot(M_N_range,eta_prop, 'LineWidth', 1)
plot(M_N_range,eta_total, 'LineWidth', 1)
hold off
xlabel("M$_{N}$")
ylabel('$\eta$')
ylim([0 2])
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$', location='northeastoutside')

% Better Plot
betterPlot(VaryMN)
%% Varying M_2 (Burner entry Mach number)
% Varying Burner Mach number
 
M_2_range = linspace(0,0.5,200); 
eta_M2thermo = zeros(1,200); 
eta_M2prop = zeros(1,200); 
eta_M2total = zeros(1,200); 
 
for i = 1:200 
    [eta_M2thermo(i),eta_M2prop(i),eta_M2total(i)] = mainRamjet(F,gamma,M_1,M_2_range(i),M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1); 
end 
 
VaryMbthermo = figure; 
 
hold on 
plot(M_2_range,eta_M2thermo, 'LineWidth', 1) 
plot(M_2_range,eta_M2prop, 'LineWidth', 1) 
plot(M_2_range,eta_M2total, 'LineWidth', 1) 
legend("$\eta_{cycle}$","$\eta_{prop}$","$\eta_{total}$",Location="northeastoutside") 
ylabel("$\eta$") 
xlabel("$M_2$ / K") 
hold off 
xlim([0 0.5])

betterPlot(VaryMbthermo)
%% Varying T_b (Burner temperature)
%varying burner temperature
T_b_range = linspace(0,2200,1000); 
eta_Tbthermo = zeros(1,1000); 
eta_Tbprop = zeros(1,1000); 
eta_Tbtotal = zeros(1,1000); 
 
for i = 1:1000 
    [eta_Tbthermo(i),eta_Tbprop(i),eta_Tbtotal(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1,T_b_range(i),Pb_over_P2,P4_over_P1); 
end 
 
VaryTbthermo = figure; 
 
hold on 
plot(T_b_range,eta_Tbthermo, 'LineWidth', 1) 
plot(T_b_range,eta_Tbprop, 'LineWidth', 1) 
plot(T_b_range,eta_Tbtotal, 'LineWidth', 1) 
legend("$\eta_{cycle}$","$\eta_{prop}$","$\eta_{total}$",Location="northeastoutside") 
ylabel("$\eta$") 
xlabel("$T_b$ / K") 
hold off 
 

betterPlot(VaryTbthermo)
%% Varying P_b/P_2 (Burner pressure ratio)
Pb_over_P2_range = linspace(0.5,1.5,500); %From under expanded to over expanded

% Calculate efficiencies for each expansion
for i = 1:length(Pb_over_P2_range)
    [eta_Fthermo(i),eta_Fprop(i), eta_Ftotal(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2_range(i),P4_over_P1);
end

% Varying thermodynamic efficiency
VaryPbP2thermo = figure;
plot(Pb_over_P2_range, eta_Fthermo, 'LineWidth', 1, 'DisplayName', 'Thermodynamic Efficiency');
hold on;
plot(Pb_over_P2_range, eta_Fprop, 'LineWidth', 1, 'DisplayName', 'Propulsive Efficiency');
plot(Pb_over_P2_range, eta_Ftotal, 'LineWidth', 1, 'DisplayName', 'Total Efficiency');
hold off;

% Set labels and title
xlabel('$\frac{P_b}{P_2}$');
ylabel('$\eta $');
%title('Efficiency vs Pb/P2');
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$', location='northeastoutside')
xlim([0.5 1.5])
grid on;

% Apply betterPlot style (if necessary)
betterPlot(VaryPbP2thermo); % Applies the betterPlot style to the current figure
%% Varying P_4/P_1 (Exhaust pressure ratio)
P4_over_P1_range = linspace(0.8,1.5,500); %From under expanded to over expanded

% Calculate efficiencies for each expansion
for i = 1:length(P4_over_P1_range)
    [eta_Fthermo(i),eta_Fprop(i),eta_Ftotal(i)] = mainRamjet(F,gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1_range(i));
end

% Varying thermodynamic efficiency
VaryP4P1thermo = figure;
plot(P4_over_P1_range, eta_Fthermo, 'LineWidth', 1, 'DisplayName', 'Thermodynamic Efficiency');
hold on;
plot(P4_over_P1_range, eta_Fprop, 'LineWidth', 1, 'DisplayName', 'Propulsive Efficiency');
plot(P4_over_P1_range, eta_Ftotal, 'LineWidth', 1, 'DisplayName', 'Total Efficiency');
hold off;

% Set labels and title
xlabel('$\frac{P_4}{P_1}$');
ylabel('$\eta $');
%title('Efficiency vs P4/P1');
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$', location='northeastoutside')
xlim([0.8 1.5])
grid on;

% Apply betterPlot style (if necessary)
betterPlot(VaryP4P1thermo); % Applies the betterPlot style to the current figure
%% Varying Thrust (Required Thrust)
F = linspace(0,200e3,500); %thrust range for general ramjet engines

% Calculate efficiencies for each thrust value
for i = 1:length(F)
    [eta_Fthermo(i),eta_Fprop(i),eta_Ftotal(i)] = mainRamjet(F(i),gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plot graphs
VaryT = figure;
plot(F, eta_Fthermo, 'LineWidth', 1, 'DisplayName', 'Thermodynamic Efficiency');
hold on;
plot(F, eta_Fprop, 'LineWidth', 1, 'DisplayName', 'Propulsive Efficiency');
plot(F, eta_Ftotal, 'LineWidth', 1, 'DisplayName', 'Total Efficiency');
hold off;

% Set labels and title
xlabel('Required Thrust / N');
ylabel('$\eta $');
%title('Efficiency vs Required Thrust');
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$', location='northeastoutside')
ylim([0 1])
grid on;

% Apply betterPlot style (if necessary)
betterPlot(VaryT); % Applies the betterPlot style to the current figure