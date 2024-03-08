function cycle_eff = cycleEfficiency(T_1,T_2,T_b,T_4)
% Funtion to calculate the thermodynamic cycle efficiency using the compression
% temperature ratio T1/T2
%
% Inputs:
% T_1       = Atmospheric Pressure
% T_2       = Temperature at the beginning of the burner
% T_b       = Temperature at the end of the burner
% T_4       = Temperature at the exhaust
%
% Outputs:
% cycle_eff = Thermodynamic cycle efficiency

cycle_eff = 1 - ((T_4 - T_1) / (T_b - T_2));

end

