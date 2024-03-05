function prop_eff = propEfficiency(gamma,R, M_1, M_4, A_1, A_4,T_1, T_4)
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

U_1_squared = M_1^2*(gamma*R*T_1)

U_4_squared = M_4^2*(gamma*R*T_4)

prop_eff = (gamma*(M_1^2)*(((M_4^2)/(M_1^2)*(A_4/A_1))-1) - (A_4/A_1) -1)*((2*R*T_1)/(U_4_squared-U_1_squared));

end
