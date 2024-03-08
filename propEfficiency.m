function prop_eff = propEfficiency(F_over_P1A1,gamma,R,M_1, M_4,T_1,T_4)
% Funtion to calculate the cycle efficiency using the compression
% temperature ratio T1/T2
%
% Inputs:
% gamma     = Ratio of specific heats
% M_1       = Mach number at inlet
% M_4       = Mach number at exit
% A_1       = Inlet Area
% A_4       = Exit Area
% R         = Gas constant
% T_1       = Temperature at inlet
% T_4       = Temperature at exit

% Outputs:
% prop_eff = Propulsive efficiency of the engine

U_1 = M_1 * sqrt(gamma * R * T_1);

U_4 = M_4 * sqrt(gamma * R * T_4);

prop_eff = F_over_P1A1 * ((2 * R * T_1) / (U_4^2 - U_1^2));

end
