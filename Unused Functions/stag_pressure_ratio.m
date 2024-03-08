function [ratio] = stag_pressure_ratio(M,gamma)
%fucntion to calculate P_0 / P

ratio = (1+(gamma-1)/2*M^2)^(gamma/(gamma-1))