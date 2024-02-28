function [M_high,M_low] = area2M(arearatio,gamma)
% Function to calculate the required Mach number given the area ratio and
% ratio of specific heats
% Inputs:
% arearatio = Area ratio for the given Mach number
% gamma     = Ratio of specific heats
%
% Outputs:
% M_high    = Supersonic Mach number
% M_low     = Subsonic Mach number

% Defining function with function handle
eq = @(M) (1/M) * ((2 / (gamma + 1)) * (1 + (gamma - 1) / 2 * M^2))^((gamma + 1) / (2 * (gamma - 1))) - arearatio;

% Need to define intervals to find the roots, one is subsonic and the other
% supersonic

options = optimset('Display','off'); % Turn off display in preparation for using fzero

% Finding subsonic Mach number
M_low = fzero(eq, 0.5, options); % Starting guess in subsonic range

% Finding supersonic Mach number
M_high = fzero(eq, 2, options); % Starting guess in supersonic range