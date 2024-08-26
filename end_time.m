global T_dc
global T_dc_p_ax
global T_dc_p_ay T_dc_p_by T_dc_p_cy
global T_dc_p_az T_dc_p_bz
global T_dc_p_gamma
global T_dc_a_a T_dc_a_b T_dc_a_c
global SCR
global Td
%% End Time

% if or(SCR==2,SCR==3)
%     
%     T_dc_p_ax=0; % ???
% 
%     T_dc_p_ay=0; % ???
%     T_dc_p_by=0; % ???
%     T_dc_p_cy=0; % ???
% 
%     T_dc_p_az=0; % ???
%     T_dc_p_bz=0; % ???
% 
%     T_dc_p_gamma=T_dc_p_ax; % ???
% 
%     T_dc_a_a=0; % ???
%     T_dc_a_c=0; % ???
%     T_dc_a_b=0; % ???
%     
% else
    
    T_dc_p_ax=Rdc_1*T_dc; % ???

    T_dc_p_ay=Rdc_2*T_dc; % ???
    T_dc_p_by=Rdc_3*T_dc; % ???
    T_dc_p_cy=Rdc_4*T_dc; % ???

    T_dc_p_az=Rdc_5*T_dc; % ???
    T_dc_p_bz=Rdc_6*T_dc; % ???

    T_dc_p_gamma=T_dc_p_ax; % ???

    T_dc_a_a=Td; % ???
    T_dc_a_c=Rdc_7*T_dc; % ???
    if SCR==0
    T_dc_a_b=0.45*(T_dc_a_c-T_dc_a_a); % ???
    elseif SCR==1
        T_dc_a_b=4.4*(T_dc_a_c-T_dc_a_a); % ???
    end

% end