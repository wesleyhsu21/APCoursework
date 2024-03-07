function cycle_eff = cycleEfficiency(T_b,T_4,T_1,P_1,gamma,P_2,T_2,C_p,f_fa,epsilon)
% Funtion to calculate the cycle efficiency using the compression
% temperature ratio T1/T2
%
% Inputs:
% T_1       =
% T_2       =
% f_fa      =
% epsilon   =
% comp_eff  =
% exp_eff   =
% C_p       =
%
% Outputs:
% cycle eff =

% fuel to air ratio f_fa and expansion and compression efficiencies
% comp_eff exp_eff

% comp_T_ratio = T_1/T_2;
% 
% cycle_eff = (C_p *T_1/(f_fa * epsilon)) * (1/comp_T_ratio - 1) * (comp_eff * ...
%     exp_eff * (1 + comp_T_ratio * f_fa * epsilon/ C_p * T_1) - 1);

exp_eff = expansionEff(T_b,T_4,P_1,P_2,gamma);
comp_eff = compressorEff(P_1,P_2,gamma,T_1,T_2);

cycle_eff = (C_p * T_1) / (f_fa * epsilon) * (T_2 / T_1 - 1) * (comp_eff * exp_eff * (1 + (T_1 / T_2) * ((f_fa * epsilon) / (C_p * T_1))) - 1);
end

