function [M_b_low,M_b_high] = RaleighBurner(T_2,T_b,M_2,gamma)
% Function to calculate the burner Mach number using conservation of mass,
% conservation of momentum (without drag), solving a quadratic
% [T2_over_Tb * (M_2 + 1 / (gamma * M_2))^2 - 4 / gamma] needs to be >0
% otherwise Mach is imaginary
% Inputs:
% T2_over_Tb    = Ratio of temperatures between burner start and burner end
% M_2           = Mach number at burner start
% gamma         = Ratio of specific heats
% Outputs:
% M_b_low       = Low (subsonic) Mach number
% M_b_high      = High (supersonic) Mach number - not usually possible

% Useful Constants
T2_over_Tb = T_2 / T_b;
lambda = 0.5 * sqrt(T2_over_Tb) * (M_2 + 1 / (gamma * M_2));
alpha = 0.5 * sqrt(T2_over_Tb * (M_2 + 1 / (gamma * M_2))^2 - 4 / gamma);

M_b_low = lambda - alpha;

M_b_high = lambda + alpha;

end