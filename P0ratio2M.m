function [M] = P0ratio2M(ratio,gamma)
% Function to calculate the Mach number given the ratio P0/P using
% isentropic relations
%
% Inputs:
% ratio = Ratio P0/P
% gamma = Ratio of specific heats
%
% Outputs:
% M     = Mach number

lambda = (ratio ^ ((gamma - 1) / gamma) - 1) * 2 / (gamma - 1);

M = sqrt(lambda);

end