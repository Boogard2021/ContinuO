global Ds L_ff_f
global xs xe yd ye
global lg delt
global zp_ss_max zp_ss_min
global Td Tc

Td=R_Td*Tc;
xe=Sc*Ds/(Rse+1); % Distance of pelvis and rear ankle in DSP   
xs=Rse*xe; % Distance of pelvis and front ankle in DSP    
% ye=Rm*0.5*L_ff_f*0; % maximum of pelvis movement in y direction
% yd=Rd*ye; % minimum of pelvis movement in y direction

zp_ss_min=R_zp*lg; % minimum heigth of body
zp_ss_max=zp_ss_min+delt; % maximum heigth of pelvis
