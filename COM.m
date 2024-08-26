function O=COM(P)
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

% Angle Joints
q=P(55:68); % Joints angles and velocity

%% Global
global L_sh_f L_sh_h L_th_f L_th_h L_th_h_mid L_b W_b L_h 
global d_sh_fr d_sh_fl d_sh_hr d_sh_hl d_th_fr d_th_fl d_th_hr d_th_hl d_th_mid_hr d_th_mid_hl d_hip_fr d_hip_fl d_hip_hr d_hip_hl d_b
%% Angle of Joints
q_fr = q(1:3);
q_fl = q(4:6);
q_hr = q(7:10);
q_hl = q(11:14);

q1_fr=q_fr(1);q2_fr=q_fr(2);q3_fr=q_fr(3);
q1_fl=q_fl(1);q2_fl=q_fl(2);q3_fl=q_fl(3);
q1_hr=q_hr(1);q2_hr=q_hr(2);q3_hr=q_hr(3);q4_hr=q_hr(4);
q1_hl=q_hl(1);q2_hl=q_hl(2);q3_hl=q_hl(3);q4_hl=q_hl(4);

%% Rotation Matrix
% Pelvis
R_p_x =   rot(1,alpha_p,4);
R_p_y =   rot(2,beta_p,4);  
R_p_z =   rot(3,gamma_p,4);  
R_0_p=R_p_y*R_p_z*R_p_x; % Pelvis Rotation Matrix

R0 = R_0_p;
% Front Right 
Rq1_fr = rot(1,q1_fr,4);
Rq2_fr = rot(2,q2_fr,4);
Rq3_fr = rot(2,q3_fr,4);

% Front Left
Rq1_fl = rot(1,q1_fl,4);
Rq2_fl = rot(2,q2_fl,4);
Rq3_fl = rot(2,q3_fl,4);

% Hind Right 
Rq1_hr = rot(1,q1_hr,4);
Rq2_hr = rot(2,q2_hr,4);
Rq3_hr = rot(2,q3_hr,4);
Rq4_hr = rot(2,q4_hr,4);

% Hind Left
Rq1_hl = rot(1,q1_hl,4);
Rq2_hl = rot(2,q2_hl,4);
Rq3_hl = rot(2,q3_hl,4);
Rq4_hl = rot(2,q4_hl,4);


% R0_fr = R0;
% R1_fr = R0_fr*Rq1_fr; % Hip_z Rotation Matrix from pelvis
% R2_fr = R1_fr*Rq2_fr; % Hip_x Rotation Matrix from pelvis
% R3_fr = R2_fr*Rq3_fr; % Hip Rotation Matrix from pelvis
% 
% 
% R0_fl = R0;
% R1_fl = R0_fl*Rq1_fl;
% R2_fl = R1_fl*Rq2_fl;
% R3_fl = R2_fl*Rq3_fl;
% 
% R0_hr = R0;
% R1_hr = R0_hr*Rq1_hr; % Hip_z Rotation Matrix from pelvis
% R2_hr = R1_hr*Rq2_hr; % Hip_x Rotation Matrix from pelvis
% R3_hr = R2_hr*Rq3_hr; % Hip Rotation Matrix from pelvis
% R4_hr = R3_hr*Rq4_hr; % Hip Rotation Matrix from pelvis
% 
% 
% R0_hl = R0;
% R1_hl = R0_hl*Rq1_hl; % Hip_z Rotation Matrix from pelvis
% R2_hl = R1_hl*Rq2_hl; % Hip_x Rotation Matrix from pelvis
% R3_hl = R2_hl*Rq3_hl; % Hip Rotation Matrix from pelvis
% R4_hl = R3_hl*Rq4_hl; % Hip Rotation Matrix from pelvis
%% Translation Matrix
% Trunk
P_p = trans([],r_p);
P_p_c = trans([],d_b);
% Front Right
P_sho_fr = trans([],0.5*[L_b,-W_b,0]);
P_hip_c_fr= trans([],d_hip_fr);
P_hip_fr = trans([],[L_h(1),-L_h(2),-L_h(3)]);
P_th_c_fr = trans([],d_th_fr);
P_th_fr = trans([],[L_th_f(1),-L_th_f(2),-L_th_f(3)]);
P_sh_c_fr = trans([],d_sh_fr);
P_sh_fr = trans([],[-L_sh_f(1),-L_sh_f(2),-L_sh_f(3)]);

% Front Left
P_sho_fl = trans([],0.5*[L_b,W_b,0]);
P_hip_c_fl= trans([],d_hip_fl);
P_hip_fl = trans([],[L_h(1),L_h(2),-L_h(3)]);
P_th_c_fl = trans([],d_th_fl);
P_th_fl = trans([],[L_th_f(1),L_th_f(2),-L_th_f(3)]);
P_sh_c_fl = trans([],d_sh_fl);
P_sh_fl = trans([],[-L_sh_f(1),L_sh_f(2),-L_sh_f(3)]);

% Hind Right
P_sho_hr = trans([],0.5*[-L_b,-W_b,0]);
P_hip_c_hr= trans([],d_hip_hr);
P_hip_hr = trans([],[-L_h(1),-L_h(2),-L_h(3)]);
P_th_c_hr = trans([],d_th_hr);
P_th_hr = trans([],[-L_th_h(1),-L_th_h(2),-L_th_h(3)]);
P_th_mid_c_hr = trans([],d_th_mid_hr);
P_th_mid_hr = trans([],[-L_th_h_mid(1),-L_th_h_mid(2),-L_th_h_mid(3)]);
P_sh_c_hr = trans([],d_sh_hr);
P_sh_hr = trans([],[-L_sh_h(1),-L_sh_h(2),-L_sh_h(3)]);

% Hind Left
P_sho_hl = trans([],0.5*[-L_b,W_b,0]);
P_hip_c_hl= trans([],d_hip_hl);
P_hip_hl = trans([],[-L_h(1),L_h(2),-L_h(3)]);
P_th_c_hl = trans([],d_th_hl);
P_th_hl = trans([],[-L_th_h(1),L_th_h(2),-L_th_h(3)]);
P_th_mid_c_hl = trans([],d_th_mid_hl);
P_th_mid_hl = trans([],[-L_th_h_mid(1),L_th_h_mid(2),-L_th_h_mid(3)]);
P_sh_c_hl = trans([],d_sh_hl);
P_sh_hl = trans([],[-L_sh_h(1),L_sh_h(2),-L_sh_h(3)]);
%% Position
r_b=        P_p*R0*P_p_c*[0;0;0;1];

r_hip_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_c_fr*[0;0;0;1];
r_hip_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_c_fl*[0;0;0;1];
r_hip_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_c_hr*[0;0;0;1];
r_hip_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_c_hl*[0;0;0;1];

r_th_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_c_fr*[0;0;0;1];
r_th_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_c_fl*[0;0;0;1];
r_th_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_c_hr*[0;0;0;1];
r_th_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_c_hl*[0;0;0;1];
r_th_mid_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_hr*Rq3_hr*P_th_mid_c_hr*[0;0;0;1];
r_th_mid_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_hl*Rq3_hl*P_th_mid_c_hl*[0;0;0;1];

r_sh_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_fr*Rq3_fr*P_sh_c_fr*[0;0;0;1];
r_sh_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_fl*Rq3_fl*P_sh_c_fl*[0;0;0;1];
r_sh_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_hr*Rq3_hr*P_th_mid_hr*Rq4_hr*P_sh_c_hr*[0;0;0;1];
r_sh_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_hl*Rq3_hl*P_th_mid_hl*Rq4_hl*P_sh_c_hl*[0;0;0;1];
%% Output
O=[r_sh_fr(1:3);r_sh_fl(1:3);r_sh_hr(1:3);r_sh_hl(1:3);r_th_fr(1:3);r_th_fl(1:3);r_th_hr(1:3);r_th_hl(1:3);r_th_mid_hr(1:3);r_th_mid_hl(1:3);r_hip_fr(1:3);r_hip_fl(1:3);r_hip_hr(1:3);r_hip_hl(1:3);r_b(1:3)];
end