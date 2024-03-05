function [Ab_over_A2] = AbA2ratio(P_b,P_2,gamma,M_2,M_b)
% Function to calculate the ratio between A_b and A_2 (i.e. between the end
% and start of the burner
%
% Inputs:
% P_b           = Pressure at the end of the burner
% P_2           = Pressure at the start of the burner
% gamma         = Ratio of specific heats
% M_2           = Mach number at the start of the burner
% M_b           = Mach number at the end of the burner
%
% Outputs:
% Ab_over_A2    = Ratio between A_b and A_2

P2_over_Pb = P_2 / P_b;

Ab_over_A2 = P2_over_Pb * (gamma * M_2^2 + 1) / (gamma * M_b^2 + 1);