function T0_over_T = M2T0ratio(M,gamma)
% Function to calculate the ratio between stagnation temperature and static
% temperature using isentropic flow relations
%
% Inputs:
% M         = Mach number
% gamma     = Ratio of specific heats
%
% Outputs:
% T0_over_T = Ratio between stagnation temperature and static temperature 


T0_over_T = 1 + (((gamma - 1)/2) * (M^2));


end