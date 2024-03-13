function prop_eff = propEfficiency(F_over_P1A1,gamma,R,M_1,M_4,T_1,T_4)
% Funtion to calculate the propulsive efficiency
% Fuel mass is ignored

% Inputs:
% F_over_P1A1   = Relative thrust, i.e. F / (P_1 * A_1)
% gamma         = Ratio of specific heats
% R             = Ideal gas constant
% M_1           = Flight Mach number
% M_4           = Exhaust Mach number
% T_1           = Atmospheric temperature
% T_4           = Exhaust temperature
%
% Outputs:
% prop_eff      = Propulsive efficiency of the ramjet

% Flight velocity
U_1 = M_1 * sqrt(gamma * R * T_1);

% Exhaust velocity
U_4 = M_4 * sqrt(gamma * R * T_4);

% Propulsive efficiency
prop_eff = F_over_P1A1 * ((2 * R * T_1) / (U_4^2 - U_1^2));

end
