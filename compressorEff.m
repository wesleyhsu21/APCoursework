function comp_eff = compressorEff(P_1,P_2,gamma,T_1,T_2)
%function to calculate compressor efficiency from the inlet and compression
%temperatures

T_A = T_2 * ( (P_2 / P_1) ^ ( -(gamma - 1) /gamma));

comp_eff = (T_2 - T_A)/(T_2 - T_1);

end