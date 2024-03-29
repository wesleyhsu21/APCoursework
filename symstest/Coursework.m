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
% These are the following values that will be used in calculations if the
% value is not the one being varied
P_1 = 70000;    % Freestream pressure                       [Pa]
T_1 = 210;      % Freestream temperature                    [K]
M_1 = 2.8;      % Flight Mach number                        []
M_N = 1.1;      % Normal shock strength                     []
M_2 = 0.26;     % Mach number at start of burner section    []
T_b = 1700;     % Burner temperature                        [K]
P_2 = 150000;   % Pressure just before burner entrance      [Pa]
P_b = P_2;      % Burner pressure                           [Pa]
F = 20000;      % Required thrust                           [N]

% Burner pressure ratio
Pb_over_P2 = 1;%                                            []

% Exhaust pressure ratio (P_4 / P_1)
P4_over_P1 = 1; %                                           []

%% Chosen Variables
% There values are chosen, and are typical of ramjets or are heavily
% dependent on temberature and must be set to get an understandable result
gamma = 1.4;        % Ratio of specific heats VARIES WITH T![]
R = 287;            %                                       [J/Kg K]
epsilon = 44786e3;  % Lower heating value                   [J/kg]
f_fa = 0.06641;     % mdot_f/mdot_a                         []
C_p = 1.0045e3;     % Specific heat at constant pressure    [J/Kg K]

%% Discretisation of range
n = 1000;

%% Saving to Folder 'Figures'
folderName = 'Figures';
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

%% 1. Varying P_1 (Freestream pressure)
P_1_range = linspace(0,120000,n);

% Initialising 
eta_P1thermo = zeros(1,n);
eta_P1prop = zeros(1,n);
eta_P1total = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:n
    [eta_P1thermo(i),eta_P1prop(i),eta_P1total(i)] = mainRamjet(F,gamma,...
        M_1,M_2,M_N,P_1_range(i),R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plotting
VaryP1 = figure;
hold on
plot(P_1_range,eta_P1prop, 'LineWidth', 1)
plot(P_1_range,eta_P1thermo, 'LineWidth', 1)
plot(P_1_range,eta_P1total, 'LineWidth', 1)

% Legend
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",...
    Location="northeastoutside")

% Axes
ylabel("$\eta$")
xlabel("$P_1$ / Pa")
hold off
ylim([0 1])
xlim([0 120000])

betterPlot(VaryP1) % Consistent style function

% Saving figure
saveas(VaryP1, fullfile(folderName, 'VaryP1.png'))

%% 2. Varying T_1 (Freestream temperature)
T_1_range = linspace(0,1000,n);

% Initalising
eta_T1thermo = zeros(1,n);
eta_T1prop = zeros(1,n);
eta_T1total = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:n
    [eta_T1thermo(i),eta_T1prop(i),eta_T1total(i)] = mainRamjet(F,gamma,...
        M_1,M_2,M_N,P_1,R,T_1_range(i),T_b,Pb_over_P2,P4_over_P1);
end

% Plotting
VaryT1 = figure;
hold on
plot(T_1_range,eta_T1prop, 'LineWidth', 1)
plot(T_1_range,eta_T1thermo, 'LineWidth', 1)
plot(T_1_range,eta_T1total, 'LineWidth', 1)

% Plotting regions
T1xregion1 = [670 1000 1000 670];
T1yregion1 = [1.2 1.2 0 0];
fill(T1xregion1, T1yregion1, 'red', 'FaceAlpha', 0.3)

T1xregion2 = [0 211.211 211.211 0];
T1yregion2 = [1.2 1.2 0 0];
fill(T1xregion2, T1yregion2, 'green', 'FaceAlpha', 0.3)

% Legend
legend("$\eta_{propulsive}$","$\eta_{cycle}$","$\eta_{total}$",...
    "$T_2 > T_b$","Imaginary $M_b$",...
    Location="northeastoutside")

% Axes
ylabel("$\eta$")
xlabel("$T_1$ / K")
hold off

betterPlot(VaryT1) % Consistent style function

% Saving figure
saveas(VaryT1, fullfile(folderName, 'VaryT1.png'))

%% 3. Varying M_1 (Flight Mach number)
M_1_range = linspace(0,8,n);

% Initialising
eta_M1thermo = zeros(1,n);
eta_M1prop = zeros(1,n);
eta_M1total = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:n
    [eta_M1thermo(i),eta_M1prop(i),eta_M1total(i)] = mainRamjet(F,gamma,...
        M_1_range(i),M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plotting
VaryM1 = figure;
hold on
plot(M_1_range,eta_M1thermo, 'LineWidth', 1)
plot(M_1_range,eta_M1prop, 'LineWidth', 1)
plot(M_1_range,eta_M1total, 'LineWidth', 1)

% Legend
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$',...
    location='northeastoutside')

% Axes
xlabel("M$_{1}$")
ylabel('$\eta$')
hold off

betterPlot(VaryM1) % Consistent style function

% Saving figure
saveas(VaryM1, fullfile(folderName, 'VaryM1.png'))

%% 4. Varying M_N (Normal Shock Strength)
M_N_range = linspace(0,6,n);

% Initialising
eta_MNthermo = zeros(1,n);
eta_MNprop = zeros(1,n);
eta_MNtotal = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:n
    [eta_MNthermo(i),eta_MNprop(i),eta_MNtotal(i)] = mainRamjet(F,gamma,...
        M_1,M_2,M_N_range(i),P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plotting
VaryMN = figure;
hold on
plot(M_N_range,eta_MNthermo, 'LineWidth', 1)
plot(M_N_range,eta_MNprop, 'LineWidth', 1)
plot(M_N_range,eta_MNtotal, 'LineWidth', 1)

% Legend
legend('$\eta_{cycle}$','$\eta_{propulsion}$','$\eta_{total}$',...
    location='northeastoutside')

% Axes
xlabel("M$_{N}$")
ylabel('$\eta$')
hold off
ylim([0 2])

betterPlot(VaryMN) % Consistent style function

% Saving figure
saveas(VaryMN, fullfile(folderName, 'VaryMN.png'))

%% 5. Varying M_2 (Burner entry Mach number)
M_2_range = linspace(0,0.5,n);

% Initialising
eta_M2thermo = zeros(1,n); 
eta_M2prop = zeros(1,n); 
eta_M2total = zeros(1,n); 

% Looping, Calculating efficiency for every i
for i = 1:n 
    [eta_M2thermo(i),eta_M2prop(i),eta_M2total(i)] = mainRamjet(F,gamma,...
        M_1,M_2_range(i),M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1); 
end 

% Plotting
VaryM2 = figure; 
hold on
plot(M_2_range,eta_M2thermo, 'LineWidth', 1) 
plot(M_2_range,eta_M2prop, 'LineWidth', 1) 
plot(M_2_range,eta_M2total, 'LineWidth', 1) 

% Legend
legend("$\eta_{cycle}$","$\eta_{prop}$","$\eta_{total}$",...
    Location="northeastoutside")

% Axes
ylabel("$\eta$") 
xlabel("$M_2$ / K") 
hold off 
xlim([0 0.5])

betterPlot(VaryM2) % Consistent style function

% Saving figure
saveas(VaryM2, fullfile(folderName, 'VaryM2.png'))

%% 6. Varying T_b (Burner temperature)
T_b_range = linspace(0,2200,n);

% Initalising
eta_Tbthermo = zeros(1,n); 
eta_Tbprop = zeros(1,n); 
eta_Tbtotal = zeros(1,n); 

% Looping, Calculating efficiency for every i
for i = 1:n 
    [eta_Tbthermo(i),eta_Tbprop(i),eta_Tbtotal(i)] = mainRamjet(F,gamma,...
        M_1,M_2,M_N,P_1,R,T_1,T_b_range(i),Pb_over_P2,P4_over_P1); 
end 

% Plotting
VaryTb = figure; 
hold on 
plot(T_b_range,eta_Tbthermo, 'LineWidth', 1) 
plot(T_b_range,eta_Tbprop, 'LineWidth', 1) 
plot(T_b_range,eta_Tbtotal, 'LineWidth', 1) 

% Legend
legend("$\eta_{cycle}$","$\eta_{prop}$","$\eta_{total}$",...
    Location="northeastoutside")

% Axes
ylabel("$\eta$") 
xlabel("$T_b$ / K") 
hold off 

betterPlot(VaryTb) % Consistent style function

% Saving figure
saveas(VaryTb, fullfile(folderName, 'VaryTb.png'))

%% 7. Varying P_b/P_2 (Burner pressure ratio)
Pb_over_P2_range = linspace(0.5,1.5,n);

% Initialising
eta_PbP2thermo = zeros(1,n);
eta_PbP2prop = zeros(1,n);
eta_PbP2total = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:length(Pb_over_P2_range)
    [eta_PbP2thermo(i),eta_PbP2prop(i), eta_PbP2total(i)] = mainRamjet(F,...
        gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2_range(i),P4_over_P1);
end

% Plotting
VaryPbP2thermo = figure;
hold on;
plot(Pb_over_P2_range, eta_PbP2thermo, 'LineWidth', 1);
plot(Pb_over_P2_range, eta_PbP2prop, 'LineWidth', 1);
plot(Pb_over_P2_range, eta_PbP2total, 'LineWidth', 1);

% Legend
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$',...
    location='northeastoutside')

% Axes
xlabel('$\frac{P_b}{P_2}$');
ylabel('$\eta $');
xlim([0.5 1.5])
hold off;

betterPlot(VaryPbP2thermo) % Consistent style function

% Saving figure
saveas(VaryPbP2thermo, fullfile(folderName, 'VaryPbP2.png'))

%% 8. Varying P_4/P_1 (Exhaust pressure ratio)
P4_over_P1_range = linspace(0.8,1.5,n);

% Initialising
eta_P4P1thermo = zeros(1,n);
eta_P4P1prop = zeros(1,n);
eta_P4P1total = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:length(P4_over_P1_range)
    [eta_P4P1thermo(i),eta_P4P1prop(i),eta_P4P1total(i)] = mainRamjet(F,...
        gamma,M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1_range(i));
end

% Plotting
VaryP4P1thermo = figure;
hold on;
plot(P4_over_P1_range, eta_P4P1thermo, 'LineWidth', 1);
plot(P4_over_P1_range, eta_P4P1prop, 'LineWidth', 1);
plot(P4_over_P1_range, eta_P4P1total, 'LineWidth', 1);

% Legend
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$',...
    location='northeastoutside')

% Axes
xlabel('$\frac{P_4}{P_1}$');
ylabel('$\eta $');
xlim([0.8 1.5])
hold off;

betterPlot(VaryP4P1thermo) % Consistent style function

% Saving figure
saveas(VaryP4P1thermo, fullfile(folderName, 'VaryP4P1.png'))

%% 9. Varying Thrust (Required Thrust)
F = linspace(0,200000,n);

% Initialising
eta_Fthermo = zeros(1,n);
eta_Fprop = zeros(1,n);
eta_Ftotal = zeros(1,n);

% Looping, Calculating efficiency for every i
for i = 1:length(F)
    [eta_Fthermo(i),eta_Fprop(i),eta_Ftotal(i)] = mainRamjet(F(i),gamma,...
        M_1,M_2,M_N,P_1,R,T_1,T_b,Pb_over_P2,P4_over_P1);
end

% Plotting
VaryT = figure;
hold on;
plot(F,eta_Fthermo,'LineWidth',1);
plot(F, eta_Fprop, 'LineWidth', 1);
plot(F, eta_Ftotal, 'LineWidth', 1);

% Legend
legend('$\eta_{cycle}$','$\eta_{prop}$','$\eta_{total}$',...
    location='northeastoutside')

% Axes
xlabel('Required Thrust / N');
ylabel('$\eta $');
ylim([0 1])
hold off;

betterPlot(VaryT) % Consistent style function

% Saving figure
saveas(VaryT, fullfile(folderName, 'VaryThrust.png'))
