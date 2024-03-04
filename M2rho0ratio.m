function rho0_over_rho = M2rho0ratio(M,gamma)
% Function to calculate the ratio between stagnation density and static
% density using isentropic flow relations
%
% Inputs:
% M             = Mach number
% gamma         = Ratio of specific heats
%
% Outputs:
% rho0_over_rho = Ratio between stagnation density and static density

rho0_over_rho = (1 + (((gamma - 1)/2) * (M^2)))^(1/(gamma-1));

end
% Checked