function O = taskspace_traj(t)
%% Input
global Time_x_fr        Time_y_fr         Time_z_fr 
global Time_x_fl        Time_y_fl         Time_z_fl 
global Time_x_hr        Time_y_hr         Time_z_hr 
global Time_x_hl        Time_y_hl         Time_z_hl
global cof_x_fr         cof_y_fr          cof_z_fr
global cof_x_fl         cof_y_fl          cof_z_fl
global cof_x_hr         cof_y_hr          cof_z_hr
global cof_x_hl         cof_y_hl          cof_z_hl

global Time_x_p         Time_y_p          Time_z_p
global cof_x_p          cof_y_p           cof_z_p

global Time_alpha_p     Time_beta_p       Time_gamma_p
global cof_alpha_p      cof_beta_p        cof_gamma_p
%% Pelvis trajectory
[x_p,dx_p,ddx_p] = pva(t,Time_x_p,cof_x_p);
[y_p,dy_p,ddy_p] = pva(t,Time_y_p,cof_y_p);
[z_p,dz_p,ddz_p] = pva(t,Time_z_p,cof_z_p);

[alpha_p,dalpha_p,ddalpha_p] = pva(t,Time_alpha_p,cof_alpha_p);
[beta_p ,dbeta_p ,ddbeta_p ] = pva(t,Time_beta_p ,cof_beta_p);
[gamma_p,dgamma_p,ddgamma_p] = pva(t,Time_gamma_p,cof_gamma_p);

%% Front Left ankle trajectory
[x_fl,dx_fl,ddx_fl] = pva(t,Time_x_fl,cof_x_fl);
[y_fl,dy_fl,ddy_fl] = pva(t,Time_y_fl,cof_y_fl);
[z_fl,dz_fl,ddz_fl] = pva(t,Time_z_fl,cof_z_fl);
%% Front Right ankle trajectory
[x_fr,dx_fr,ddx_fr] = pva(t,Time_x_fr,cof_x_fr);
[y_fr,dy_fr,ddy_fr] = pva(t,Time_y_fr,cof_y_fr);
[z_fr,dz_fr,ddz_fr] = pva(t,Time_z_fr,cof_z_fr);
%% Front Left ankle trajectory
[x_hl,dx_hl,ddx_hl] = pva(t,Time_x_hl,cof_x_hl);
[y_hl,dy_hl,ddy_hl] = pva(t,Time_y_hl,cof_y_hl);
[z_hl,dz_hl,ddz_hl] = pva(t,Time_z_hl,cof_z_hl);
%% Front Left ankle trajectory
[x_hr,dx_hr,ddx_hr] = pva(t,Time_x_hr,cof_x_hr);
[y_hr,dy_hr,ddy_hr] = pva(t,Time_y_hr,cof_y_hr);
[z_hr,dz_hr,ddz_hr] = pva(t,Time_z_hr,cof_z_hr);

%% Output
r_p =  [x_p;y_p;z_p];
q_p =  [alpha_p;beta_p;gamma_p];
r_fr = [x_fr;y_fr;z_fr];
r_fl = [x_fl;y_fl;z_fl];
r_hr = [x_hr;y_hr;z_hr];
r_hl = [x_hl;y_hl;z_hl];

dr_p =  [dx_p;        dy_p;        dz_p];
dq_p =  [dalpha_p;    dbeta_p; dgamma_p];
dr_fr = [dx_fr;       dy_fr;      dz_fr];
dr_fl = [dx_fl;       dy_fl;      dz_fl];
dr_hr = [dx_hr;       dy_hr;      dz_hr];
dr_hl = [dx_hl;       dy_hl;      dz_hl];

ddr_p =  [ddx_p;        ddy_p;       ddz_p];
ddq_p =  [ddalpha_p;    ddbeta_p;    ddgamma_p];
ddr_fr = [ddx_fr;       ddy_fr;      ddz_fr];
ddr_fl = [ddx_fl;       ddy_fl;      ddz_fl];
ddr_hr = [ddx_hr;       ddy_hr;      ddz_hr];
ddr_hl = [ddx_hl;       ddy_hl;      ddz_hl];

O = [r_p; q_p; r_fr; r_fl; r_hr; r_hl;      
    dr_p; dq_p; dr_fr; dr_fl; dr_hr; dr_hl;      
    ddr_p; ddq_p; ddr_fr; ddr_fl; ddr_hr; ddr_hl];
end