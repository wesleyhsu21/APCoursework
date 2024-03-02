function [ratio] = M2P0ratio(M,gamma)
% Function to calculate ratio between stagnation pressure and static
% pressure using isentropic relations
%
% Inputs:
% M         = Mach number
% gamma     = Ratio of specific heats
%
% Outputs:
% ratio     = Ratio P0/P

ratio = (1+(gamma-1)/2*M^2)^(gamma/(gamma-1));

end