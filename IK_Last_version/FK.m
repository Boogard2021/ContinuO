function pos = FK(q,r)
global L_b W_b
r_p = r(1:3); % pelvis position
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);
q_p = r(4:6); % pelvis rotation
theta_p = q_p(1);
phi_p = q_p(2);
psi_p = q_p(3);

R_p_x = rot(1,theta_p,4);
R_p_y = rot(2,phi_p,4);
R_p_z = rot(3,psi_p,4);
R0 = R_p_z*R_p_y*R_p_x;
P_p = trans([],r_p);
P_shd_hr = trans([],[-L_b/2,-W_b/2,0]);

q1_hl = q(1);
q2_hl = q(2);
q3_hl = q(3);
q4_hl = q(4);

Rq1_hr = rot(1,q1_hl,4);
Rq2_hr = rot(2,q2_hl,4);
Rq3_hr = rot(2,q3_hl,4);
Rq4_hr = rot(2,q4_hl,4);

L_h = [53.26, 61.34, 0.17]/1000;
L_th_h_mid = [0.0, 92.88, 201.0]/1000;
L_th_h = [0.0, 52.62, 246.5]/1000;
% Adjusted L_sh to put foot under frame 4 in zero pose, as discussed.
L_sh = [0.0, 0.0, norm([77.21, 190.62])]/1000; 
P_hip_hr = trans([],[-L_h(1);-L_h(2);-L_h(3)]);
P_knee_mid_hr = trans([],[-L_th_h_mid(1);-L_th_h_mid(2);-L_th_h_mid(3)]);
P_knee_hr = trans([],[-L_th_h(1);-L_th_h(2);-L_th_h(3)]);
P_ankle_hr = trans([],[-L_sh(1);-L_sh(2);-L_sh(3)]);

shoulder_pos = P_p*R0*P_shd_hr*[0;0;0;1];
hip_pos = P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*[0;0;0;1];
knee_mid_pos = P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_mid_hr*[0;0;0;1];
knee_pos = P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_mid_hr*Rq3_hr*P_knee_hr*[0;0;0;1];
anlke_pos =   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_mid_hr*Rq3_hr*P_knee_hr*Rq4_hr*P_ankle_hr*[0;0;0;1];
pos = [shoulder_pos(1:3), hip_pos(1:3), knee_mid_pos(1:3), knee_pos(1:3), anlke_pos(1:3)];
end