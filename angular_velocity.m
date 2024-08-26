function w=angular_velocity(P)
%% Input
% Task Space
p=P(1:18);
dp=P(19:36);
ddp=P(37:54);

r_p = p(1:3); % pelvis position
    x_p = r_p(1);
    y_p = r_p(2);
    z_p = r_p(3);
q_p = p(4:6); % pelvis rotation
    alpha_p = q_p(1);
    beta_p = q_p(2);
    gamma_p = q_p(3);   

dr_p = dp(1:3); % pelvis position
    dx_p = dr_p(1);
    dy_p = dr_p(2);
    dz_p = dr_p(3);
dq_p = dp(4:6); % pelvis rotation
    dalpha_p = dq_p(1);
    dbeta_p = dq_p(2);
    dgamma_p = dq_p(3); 

% Angle Joints    
q=P(55:68);
dq=P(69:82); % Joints angles and velocity
% size(P)
%% Angle and Velocity of Joints
q_fr = q(1:3);
q_fl = q(4:6);
q_hr = q(7:10);
q_hl = q(11:14);

q1_fr=q_fr(1);q2_fr=q_fr(2);q3_fr=q_fr(3);
q1_fl=q_fl(1);q2_fl=q_fl(2);q3_fl=q_fl(3);
q1_hr=q_hr(1);q2_hr=q_hr(2);q3_hr=q_hr(3);q4_hr=q_hr(4);
q1_hl=q_hl(1);q2_hl=q_hl(2);q3_hl=q_hl(3);q4_hl=q_hl(4);

dq_fr=dq(1:3);   
dq_fl=dq(4:6);
dq_hr = dq(7:10);
dq_hl = dq(11:14);

dq1_fr=dq_fr(1);dq2_fr=dq_fr(2);dq3_fr=dq_fr(3);
dq1_fl=dq_fl(1);dq2_fl=dq_fl(2);dq3_fl=dq_fl(3);
dq1_hr=dq_hr(1);dq2_hr=dq_hr(2);dq3_hr=dq_hr(3);dq4_hr=dq_hr(4);
dq1_hl=dq_hl(1);dq2_hl=dq_hl(2);dq3_hl=dq_hl(3);dq4_hl=dq_hl(4);

%% Rotation Matrix
% Pelvis
R_p_x =   rot(1,alpha_p,3);
R_p_y =   rot(2,beta_p,3);  
R_p_z =   rot(3,gamma_p,3);  
R_0_p=R_p_y*R_p_z*R_p_x; % Pelvis Rotation Matrix
  
% Front Right 
Rq1_fr = rot(1,q1_fr,3);
Rq2_fr = rot(2,q2_fr,3);
Rq3_fr = rot(2,q3_fr,3);

% Front Left
Rq1_fl = rot(1,q1_fl,3);
Rq2_fl = rot(2,q2_fl,3);
Rq3_fl = rot(2,q3_fl,3);

% Hind Right 
Rq1_hr = rot(1,q1_hr,3);
Rq2_hr = rot(2,q2_hr,3);
Rq3_hr = rot(2,q3_hr,3);
Rq4_hr = rot(2,q4_hr,3);

% Hind Left
Rq1_hl = rot(1,q1_hl,3);
Rq2_hl = rot(2,q2_hl,3);
Rq3_hl = rot(2,q3_hl,3);
Rq4_hl = rot(2,q4_hl,3);


R0_fr = R_0_p;
R1_fr = R0_fr*Rq1_fr; % Hip_z Rotation Matrix from pelvis
R2_fr = R1_fr*Rq2_fr; % Hip_x Rotation Matrix from pelvis
R3_fr = R2_fr*Rq3_fr; % Hip Rotation Matrix from pelvis


R0_fl = R_0_p;
R1_fl = R0_fl*Rq1_fl;
R2_fl = R1_fl*Rq2_fl;
R3_fl = R2_fl*Rq3_fl;

R0_hr = R_0_p;
R1_hr = R0_hr*Rq1_hr; % Hip_z Rotation Matrix from pelvis
R2_hr = R1_hr*Rq2_hr; % Hip_x Rotation Matrix from pelvis
R3_hr = R2_hr*Rq3_hr; % Hip Rotation Matrix from pelvis
R4_hr = R3_hr*Rq4_hr; % Hip Rotation Matrix from pelvis


R0_hl = R_0_p;
R1_hl = R0_hl*Rq1_hl; % Hip_z Rotation Matrix from pelvis
R2_hl = R1_hl*Rq2_hl; % Hip_x Rotation Matrix from pelvis
R3_hl = R2_hl*Rq3_hl; % Hip Rotation Matrix from pelvis
R4_hl = R3_hl*Rq4_hl; % Hip Rotation Matrix from pelvis
%% Angular Velocity
w_b=[0;dbeta_p;0]+R_p_y*[0;0;dgamma_p]+R_p_y*R_p_z*[dalpha_p;0;0];

w_hip_fr=w_b+R0_fr*[dq1_fr;0;0];
w_th_fr=w_hip_fr+R1_fr*[0;dq2_fr;0];
w_sh_fr=w_th_fr+R2_fr*[0;dq3_fr;0];

w_hip_fl=w_b+R0_fl*[dq1_fl;0;0];
w_th_fl=w_hip_fl+R1_fl*[0;dq2_fl;0];
w_sh_fl=w_th_fl+R2_fl*[0;dq3_fl;0];

w_hip_hr=w_b+R0_hr*[dq1_hr;0;0];
w_th_hr=w_hip_hr+R1_hr*[0;dq2_hr;0];
w_th_mid_hr=w_th_hr+R2_hr*[0;dq3_hr;0];
w_sh_hr=w_th_mid_hr+R3_hr*[0;dq4_hr;0];

w_hip_hl=w_b+R0_hl*[dq1_hl;0;0];
w_th_hl=w_hip_hl+R1_hl*[0;dq2_hl;0];
w_th_mid_hl=w_th_hl+R2_hl*[0;dq3_hl;0];
w_sh_hl=w_th_mid_hl+R3_hl*[0;dq4_hl;0];

w=[w_sh_fr;w_sh_fl;w_sh_hr;w_sh_hl;...
   w_th_fr;w_th_fl;w_th_hr;w_th_hl;w_th_mid_hr;w_th_mid_hl;...
   w_hip_fr;w_hip_fl;w_hip_hr;w_hip_hl;...
   w_b];
end