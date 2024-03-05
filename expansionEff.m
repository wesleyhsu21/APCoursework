function exp_eff = expansionEff(T_b,T_4,P_1,P_2,gamma)


T_B = T_b * ((P_1/P_2)^((gamma-1)/gamma));

exp_eff = (T_b-T_4)/(T_b - T_B);