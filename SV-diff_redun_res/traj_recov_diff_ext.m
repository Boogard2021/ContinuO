function [O, p]= traj_recov_diff(q)
%% Input
% Task Space
% p=P(1:18);  % body position and orientation and feet positions
% dp=P(19:36);
% ddp=P(37:54);

p0b = q(1:3); % body position
q0b = q(4:6); % body rotation
theta_b = q0b(1);
phi_b = q0b(2);
psi_b = q0b(3);

% Angle Joints
% q=P(55:68); % Joints angles and velocity

%% Global
global L_sh_f L_sh_h L_th_f L_th_h L_th_h_mid L_b W_b L_h

%% Angle of Joints
q_fr=q(7:9);
q1_fr=q_fr(1);
q2_fr=q_fr(2);
q3_fr=q_fr(3);

q_fl=q(10:12);
q1_fl=q_fl(1);
q2_fl=q_fl(2);
q3_fl=q_fl(3);

q_hr=q(13:16);
q1_hr=q_hr(1);
q2_hr=q_hr(2);
q3_hr=q_hr(3);
q4_hr=q_hr(4);

q_hl=q(17:20);
q1_hl=q_hl(1);
q2_hl=q_hl(2);
q3_hl=q_hl(3);
q4_hl=q_hl(4);

%% Rotation Matrix
% Body
R_b_x = rot(1,theta_b,4);
R_b_y = rot(2,phi_b,4);
R_b_z = rot(3,psi_b,4);
R0b = R_b_z*R_b_y*R_b_x;

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
P0b = trans([],p0b);
%P_pl = trans([],d_b);

%Front Right
Pb1_fr = trans([],[L_b/2,-W_b/2,0]);
P12_fr = trans([],[L_h(1);-L_h(2);-L_h(3)]);
P23_fr = trans([],[L_th_f(1);-L_th_f(2);-L_th_f(3)]);
P34_fr = trans([],[-L_sh_f(1);-L_sh_f(2);-L_sh_f(3)]);

%Front Left
Pb1_fl = trans([],[L_b/2,W_b/2,0]);
P12_fl = trans([],[L_h(1);L_h(2);-L_h(3)]);
P23_fl = trans([],[L_th_f(1);L_th_f(2);-L_th_f(3)]);
P34_fl = trans([],[-L_sh_f(1);L_sh_f(2);-L_sh_f(3)]);

%Hind Right
Pb1_hr = trans([],[-L_b/2,-W_b/2,0]);
P12_hr = trans([],[-L_h(1);-L_h(2);-L_h(3)]);
P23_hr = trans([],[-L_th_h(1);-L_th_h(2);-L_th_h(3)]);
P34_hr = trans([],[-L_th_h_mid(1);-L_th_h_mid(2);-L_th_h_mid(3)]);
P45_hr = trans([],[-L_sh_h(1);-L_sh_h(2);-L_sh_h(3)]);

%Hind Left
Pb1_hl = trans([],[-L_b/2,W_b/2,0]);
P12_hl = trans([],[-L_h(1);L_h(2);-L_h(3)]);
P23_hl = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
P34_hl = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
P45_hl = trans([],[-L_sh_h(1);L_sh_h(2);-L_sh_h(3)]);

%% Position
r_b =        P0b*R0b*[0;0;0;1];

r_shd_fr=   P0b*R0b*Pb1_fr*[0;0;0;1];
r_shd_fl=   P0b*R0b*Pb1_fl*[0;0;0;1];
r_shd_hr=   P0b*R0b*Pb1_hr*[0;0;0;1];
r_shd_hl=   P0b*R0b*Pb1_hl*[0;0;0;1];

r_hip_fr=   P0b*R0b*Pb1_fr*Rq1_fr*P12_fr*[0;0;0;1];
r_hip_fl=   P0b*R0b*Pb1_fl*Rq1_fl*P12_fl*[0;0;0;1];
r_hip_hr=   P0b*R0b*Pb1_hr*Rq1_hr*P12_hr*[0;0;0;1];
r_hip_hl=   P0b*R0b*Pb1_hl*Rq1_hl*P12_hl*[0;0;0;1];

r_knee_fr=  P0b*R0b*Pb1_fr*Rq1_fr*P12_fr*Rq2_fr*P23_fr*[0;0;0;1];
r_knee_fl=  P0b*R0b*Pb1_fl*Rq1_fl*P12_fl*Rq2_fl*P23_fl*[0;0;0;1];
r_knee_hr=  P0b*R0b*Pb1_hr*Rq1_hr*P12_hr*Rq2_hr*P23_hr*[0;0;0;1];
r_knee_hl=  P0b*R0b*Pb1_hl*Rq1_hl*P12_hl*Rq2_hl*P23_hl*[0;0;0;1];
r_knee_mid_hr=   P0b*R0b*Pb1_hr*Rq1_hr*P12_hr*Rq2_hr*P23_hr*Rq3_hr*P34_hr*[0;0;0;1];
r_knee_mid_hl=   P0b*R0b*Pb1_hl*Rq1_hl*P12_hl*Rq2_hl*P23_hl*Rq3_hl*P34_hl*[0;0;0;1];

r_ankle_fr=   P0b*R0b*Pb1_fr*Rq1_fr*P12_fr*Rq2_fr*P23_fr*Rq3_fr*P34_fr*[0;0;0;1];
r_ankle_fl=   P0b*R0b*Pb1_fl*Rq1_fl*P12_fl*Rq2_fl*P23_fl*Rq3_fl*P34_fl*[0;0;0;1];
r_ankle_hr=   P0b*R0b*Pb1_hr*Rq1_hr*P12_hr*Rq2_hr*P23_hr*Rq3_hr*P34_hr*Rq4_hr*P45_hr*[0;0;0;1];
r_ankle_hl=   P0b*R0b*Pb1_hl*Rq1_hl*P12_hl*Rq2_hl*P23_hl*Rq3_hl*P34_hl*Rq4_hl*P45_hl*[0;0;0;1];

%% Output
O = [r_b(1:3);r_shd_fr(1:3);r_shd_fl(1:3);r_shd_hr(1:3);r_shd_hl(1:3);r_hip_fr(1:3);r_hip_fl(1:3);r_hip_hr(1:3);r_hip_hl(1:3);
   r_knee_fr(1:3);r_knee_fl(1:3);r_knee_hr(1:3);r_knee_hl(1:3);r_knee_mid_hr(1:3);r_knee_mid_hl(1:3);
   r_ankle_fr(1:3);r_ankle_fl(1:3);r_ankle_hr(1:3);r_ankle_hl(1:3)];

p = [q(1:6); r_ankle_fr(1:3); r_ankle_fl(1:3); r_ankle_hr(1:3); r_ankle_hl(1:3)];
end