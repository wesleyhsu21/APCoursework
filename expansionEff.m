function exp_eff = expansionEff(T_b,T_4,P_1,P_2,gamma)
% Function to calculate the expansion efficiency of a ramjet
%
% Inputs:
% T_b       = Temperature at the end of the burner section
% T_4       = Temperature in the exhaust
% P_1       = Atmospheric temperature
% P_2       = Pressure at the beginning of the burner
% gamma     = Ratio of specific heats
%
% Outputs:
% exp_eff   = Expansion efficiency

T_B = T_b * ((P_1 / P_2)^((gamma-1)/gamma));

exp_eff = (T_b-T_4) / (T_b - T_B);

end