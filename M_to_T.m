function T0_over_T = M_to_T(M,gamma)
% function to calculate the ratio between stagnation temperature and static
% temperature using isentropic flow relations

T0_over_T = 1 + (((gamma - 1)/2) * (M^2));


end