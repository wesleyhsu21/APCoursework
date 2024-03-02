function [arearatio] = M2arearatio(M,gamma)
% Function to calculate the area ratio given Mach number and ratio of
% specific heats
%
% Inputs:
% M         = Mach number
% gamma     = Ratio of specific heats
%
% Outputs:
% arearatio = Area ratio for the given mach number

lambda = (2 / (gamma + 1)) * (1 + (gamma - 1) / 2 * M^2);           % Lambda set to group a complicated term together
arearatio = (1 / M) * lambda ^ ((gamma + 1) / (2 * (gamma - 1)));   % Equation for area ratio