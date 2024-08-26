global T_ac 
global T_ac_p_ax 
global T_ac_p_ay T_ac_p_by T_ac_p_cy
global T_ac_p_az T_ac_p_bz
global T_ac_p_gamma 
global T_ac_a_a T_ac_a_b
% global SCR
%% Start Time
% if or(SCR==2,SCR==4)
%     T_ac_p_ax=0; %
%     
%     T_ac_p_ay=0; %
%     T_ac_p_by=0; %
%     T_ac_p_cy=0; %
%     
%     T_ac_p_az=0; %
%     T_ac_p_bz=0; %
%     T_ac_p_cz=0; %
% 
%     T_ac_p_gamma=0; %
% 
%     T_ac_a_a=0;%
%     T_ac_a_b=0; %
%     
% else
    
T_ac_p_az=Rac_1*T_ac; %
T_ac_p_bz=Rac_2*T_ac; %

%     T_ac_p_gamma=T_ac_p_ax; %

T_ac_a_a=Rac_3*T_ac;%
T_ac_a_b=Rac_4*T_ac; %
    
% end