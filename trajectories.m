function O=trajectories(P)
%% Input
% Task Space
p=P(1:18);  % body position and orientation and feet positions
dp=P(19:36);
ddp=P(37:54);

r_p = p(1:3); % body position
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);

q_p = p(4:6); % body rotation
alpha_p = q_p(1);
beta_p = q_p(2);
gamma_p = q_p(3);

% Angle Joints
q=P(55:68); % Joints angles and velocity

%% Global
global L_sh_f L_sh_h L_th_f L_th_h L_th_h_mid L_b W_b L_h

%% Angle of Joints
q_fr=q(1:3);q_fl=q(4:6);q_hr=q(7:10);q_hl=q(11:14);
q1_fr=q_fr(1);q2_fr=q_fr(2);q3_fr=q_fr(3);
q1_fl=q_fl(1);q2_fl=q_fl(2);q3_fl=q_fl(3);
q1_hr=q_hr(1);q2_hr=q_hr(2);q3_hr=q_hr(3);q4_hr=q_hr(4);
q1_hl=q_hl(1);q2_hl=q_hl(2);q3_hl=q_hl(3);q4_hl=q_hl(4);

%% Rotation Matrix
% Pelvis
R_p_x = rot(1,alpha_p,4);
R_p_y = rot(2,beta_p,4);
R_p_z = rot(3,gamma_p,4);
R0 = R_p_y*R_p_z*R_p_x;

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

%% Translation Matrix
% Trunk
P_p = trans([],r_p);
%P_pl = trans([],d_b);

%Front Right
P_shd_fr = trans([],[L_b/2,-W_b/2,0]);
P_hip_fr = trans([],[L_h(1);-L_h(2);-L_h(3)]);
P_knee_fr = trans([],[L_th_f(1);-L_th_f(2);-L_th_f(3)]);
P_ankle_fr = trans([],[-L_sh_f(1);-L_sh_f(2);-L_sh_f(3)]);

%Front Left
P_shd_fl = trans([],[L_b/2,W_b/2,0]);
P_hip_fl = trans([],[L_h(1);L_h(2);-L_h(3)]);
P_knee_fl = trans([],[L_th_f(1);L_th_f(2);-L_th_f(3)]);
P_ankle_fl = trans([],[-L_sh_f(1);L_sh_f(2);-L_sh_f(3)]);


%Hind Right
P_shd_hr = trans([],[-L_b/2,-W_b/2,0]);
P_hip_hr = trans([],[-L_h(1);-L_h(2);-L_h(3)]);
P_knee_hr = trans([],[-L_th_h(1);-L_th_h(2);-L_th_h(3)]);
P_knee_mid_hr = trans([],[-L_th_h_mid(1);-L_th_h_mid(2);-L_th_h_mid(3)]);
P_ankle_hr = trans([],[-L_sh_h(1);-L_sh_h(2);-L_sh_h(3)]);

%Hind Left
P_shd_hl = trans([],[-L_b/2,W_b/2,0]);
P_hip_hl = trans([],[-L_h(1);L_h(2);-L_h(3)]);
P_knee_hl = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
P_knee_mid_hl = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
P_ankle_hl = trans([],[-L_sh_h(1);L_sh_h(2);-L_sh_h(3)]);

%% Position
r_b=        P_p*R0*[0;0;0;1];

r_shd_fr=   P_p*R0*P_shd_fr*[0;0;0;1];
r_shd_fl=   P_p*R0*P_shd_fl*[0;0;0;1];
r_shd_hr=   P_p*R0*P_shd_hr*[0;0;0;1];
r_shd_hl=   P_p*R0*P_shd_hl*[0;0;0;1];

r_hip_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*[0;0;0;1];
r_hip_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*[0;0;0;1];
r_hip_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*[0;0;0;1];
r_hip_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*[0;0;0;1];

r_knee_fr=  P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*[0;0;0;1];
r_knee_fl=  P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*[0;0;0;1];
r_knee_hr=  P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*[0;0;0;1];
r_knee_hl=  P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*[0;0;0;1];
r_knee_mid_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hr*P_knee_mid_hr*[0;0;0;1];
r_knee_mid_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_knee_mid_hl*[0;0;0;1];

r_ankle_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*Rq3_fr*P_ankle_fr*[0;0;0;1];
r_ankle_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*Rq3_fl*P_ankle_fl*[0;0;0;1];
r_ankle_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hr*P_knee_mid_hr*Rq4_hr*P_ankle_hr*[0;0;0;1];
r_ankle_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_knee_mid_hl*Rq4_hl*P_ankle_hl*[0;0;0;1];
%% Output (1:3)
O=[r_b(1:3);r_shd_fr(1:3);r_shd_fl(1:3);r_shd_hr(1:3);r_shd_hl(1:3);r_hip_fr(1:3);r_hip_fl(1:3);r_hip_hr(1:3);r_hip_hl(1:3);
   r_knee_fr(1:3);r_knee_fl(1:3);r_knee_hr(1:3);r_knee_hl(1:3);r_knee_mid_hr(1:3);r_knee_mid_hl(1:3);
   r_ankle_fr(1:3);r_ankle_fl(1:3);r_ankle_hr(1:3);r_ankle_hl(1:3)];
end