function comp_eff = compressorEff(P_1,P_2,gamma,T_1,T_2)
% Function to calculate compressor efficiency from the inlet and compression
% temperatures
%
% Inputs:
% P_1       = Atmospheric Pressure
% P_2       = Pressure at the start of the burner (i.e. the end of the
%             compression zone)
% gamma     = Ratio of specific heats
% T_1       = Atmospheric Temperature
% T_2       = Temperature at the start of the burner (i.e. the end of the
%             compression zone)
%
% Outputs:
% comp_eff

T_A = T_2 * ((P_2 / P_1) ^ (-(gamma - 1) / gamma));

comp_eff = (T_2 - T_A) / (T_2 - T_1);

end