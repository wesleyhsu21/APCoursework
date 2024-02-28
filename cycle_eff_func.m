function cycle_eff = cycle_eff_func(T_1, T_2,f_fa,epsilon,comp_eff,burner_eff,C_p)

comp_T_ratio = T_1/T_2;

cycle_eff = (C_p *T_1/f_fa * epsilon) * (1/comp_T_ratio - 1) * (comp_eff * ...
    burner_eff * (1 + comp_T_ratio * f_fa * epsilon/ C_p * T_1) - 1);