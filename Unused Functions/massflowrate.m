function m_dot_a = massflowrate(M_1, gamma, R, T_1, P_1, A_1)
% Funtion to calculate the cycle efficiency using the compression
% temperature ratio T1/T2
%
% Inputs:
% M_1       = Mach number at inlet
% gamma     = Ratio of specific heats
% R         = Gas constant
% T_1       = Temperature at inlet
% P_1       = Freestream pressure
% A_1       = Inlet Area
%
% Outputs:
% m_dot_a = mass flow rate

U_1 = M_1*sqrt(gamma*R*T_1);

rho_1 = P_1/(R*T_1);

m_dot_a = rho_1*U_1*A_1;

end
