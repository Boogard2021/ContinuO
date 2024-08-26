function vw_rl=velocity_l_a(p)
%% Input
% size(p)
r_p=p(1:3); % pelvis position
    x_p=r_p(1);
    y_p=r_p(2);
    z_p=r_p(3);
q_p=p(4:6); % pelvis rotation
    alpha_p=q_p(1);
    beta_p=q_p(2);
    gama_p=q_p(3);
    
r_fr=p(7:9); % Right ankle position
    x_fr=r_fr(1);
    y_fr=r_fr(2);
    z_fr=r_fr(3);
r_fl=p(10:12); % Right ankle rotation
    x_fl=r_fl(1);    
    y_fl=r_fl(2);
    z_fl=r_fl(3);
    
r_hr=p(13:15); % Left ankle position
    x_hr=r_hr(1);
    y_hr=r_hr(2);
    z_hr=r_hr(3);
r_hl=p(16:18); % Left ankle rotation
    x_hl=r_hl(1);
    y_hl=r_hl(2);
    z_hl=r_hl(3); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dr_p=p(19:21); % 
    dx_p=dr_p(1);
    dy_p=dr_p(2);
    dz_p=dr_p(3);
dq_p=p(22:24); % 
    dalpha_p=dq_p(1);
    dbeta_p=dq_p(2);
    dgama_p=dq_p(3);
    
dr_fr=p(25:27); % 
    dx_ar=dr_fr(1);
    dy_ar=dr_fr(2);
    dz_ar=dr_fr(3);
dr_fl=p(28:30); % 
    dx_ar=dr_fl(1);    
    dy_ar=dr_fl(2);
    dz_ar=dr_fl(3);
    
dr_hr=p(31:33); % 
    dx_al=dr_hr(1);
    dy_al=dr_hr(2);
    dz_al=dr_hr(3);
dr_hl=p(34:36); % 
    dx_al=dr_hl(1);
    dy_al=dr_hl(2);
    dz_al=dr_hl(3); 
    
%% velocity
v_pl=dr_p;
v_fr=dr_fr;
v_fl=dr_fl;
v_hr=dr_hr;
v_hl=dr_hl;

R_p_y=[cos(beta_p) 0 sin(beta_p) 0;
       0 1 0 0;
       -sin(beta_p) 0 cos(beta_p) 0;
       0 0 0 1];
   
R_p_z=[cos(gama_p) -sin(gama_p) 0 0;
       sin(gama_p) cos(gama_p) 0 0;
       0 0 1 0
       0 0 0 1];
  
w_pl=[0;dbeta_p;0]+R_p_y(1:3,1:3)*[0;0;dgama_p]+R_p_y(1:3,1:3)*R_p_z(1:3,1:3)*[dalpha_p;0;0];


%%%%%%%%%%%%%   ???????????????


vw_pl=[v_pl;w_pl];
vw_fr=[v_fr;w_fr];
vw_fl=[v_fl;w_fl];
vw_hr=[v_hr;w_hr];
vw_hl=[v_hl;w_hl];
%% IK by Jacobian Matrix
vw_fr_=vw_fr-vw_pl;
vw_fl_=vw_fl-vw_pl;
vw_hr_=vw_hr-vw_pl;
vw_hl_=vw_hl-vw_pl;
%% Output
vw_rl=[vw_fr_;vw_fl_;vw_hr_;vw_hl_];
end