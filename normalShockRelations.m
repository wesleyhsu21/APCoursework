function [M2, T2_T1, P2_P1, rho2_rho1] = normalShockRelations(M1, gamma)
    % Function to calculate normal shock relations

    % Inputs
    % M1    = Mach number before the shock 
    % gamma = ratio of specific heats


    % Outputs
    % M2    = Mach number after shock
    % T2_T1 = Ratio T2/T1
    % P2_P1 = Ratio P2/P1
    % rho2_rho1 = ratio rho2/rho1
    
    % Calculating the mach number after the shock (M2)
    M2 = sqrt((((gamma-1)*M1^2)+2)/ ((2*gamma*M1^2) - (gamma-1)));
    
     % Calculate pressure ratio (P2/P1)
    P2_P1 = (1 + gamma * M1^2) / (1 + gamma * M2^2);
    
    % Calculate temperature ratio (T2/T1)
    T2_T1 = (1 + (gamma-1)/2 * M1^2) / (1 + (gamma-1)/2 * M2^2);
    
    
    % Calculate density ratio (rho2/rho1)
    rho2_rho1 = sqrt(1/T2_T1)* (M2/M1); 
    
end