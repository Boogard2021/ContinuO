function cur_pos = FK(q,r, leg)
global L_sh L_th_f L_h L_th_h L_th_h_mid L_b W_b

r_p = r(1:3); % pelvis position
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);
q_p = r(4:6); % pelvis rotation
alpha_p = q_p(1);
beta_p = q_p(2);
gamma_p = q_p(3);

R_p_x = rot(1,alpha_p,4);
R_p_y = rot(2,beta_p,4);
R_p_z = rot(3,gamma_p,4);
R0 = R_p_z*R_p_y*R_p_x;
P_p = trans([],r_p);

if leg==1
    q1_hl = q(1);
    q2_hl = q(2);
    q3_hl = q(3);
    q4_hl = q(4);
    
    Rq1_hl = rot(1,q1_hl,4);
    Rq2_hl = rot(2,q2_hl,4);
    Rq3_hl = rot(2,q3_hl,4);
    Rq4_hl = rot(2,q4_hl,4);
    
    P_shd_hl = trans([],[-L_b/2,W_b/2,0]);
    P_hip_hl = trans([],[-L_h(1);L_h(2);-L_h(3)]);
    P_knee_mid_hl = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
    P_knee_hl = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
    P_ankle_hl = trans([],[-L_sh(1);L_sh(2);-L_sh(3)]);
    cur_pos =   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_mid_hl*Rq3_hl*P_knee_hl*Rq4_hl*P_ankle_hl*[0;0;0;1];
elseif leg==2
    q1_hr = q(1);
    q2_hr = q(2);
    q3_hr = q(3);
    q4_hr = q(4);
    
    Rq1_hr = rot(1,q1_hr,4);
    Rq2_hr = rot(2,q2_hr,4);
    Rq3_hr = rot(2,q3_hr,4);
    Rq4_hr = rot(2,q4_hr,4);
    
    P_shd_hr = trans([],[-L_b/2,W_b/2,0]);
    P_hip_hr = trans([],[-L_h(1);L_h(2);-L_h(3)]);
    P_knee_mid_hr = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
    P_knee_hr = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
    P_ankle_hr = trans([],[-L_sh(1);L_sh(2);-L_sh(3)]);
    cur_pos =   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_mid_hr*Rq3_hr*P_knee_hr*Rq4_hr*P_ankle_hr*[0;0;0;1];
elseif leg==0
    q1_fr = q(1);
    q2_fr = q(2);
    q3_fr = q(3);
    
    Rq1_fr = rot(1,q1_fr,4);
    Rq2_fr = rot(2,q2_fr,4);
    Rq3_fr = rot(2,q3_fr,4);
    
    P_shd_fr = trans([],[L_b/2,-W_b/2,0]);
    P_hip_fr = trans([],[L_h(1);-L_h(2);-L_h(3)]);
    P_knee_fr = trans([],[L_th_f(1);-L_th_f(2);-L_th_f(3)]);
    P_ankle_fr = trans([],[-L_sh(1);-L_sh(2);-L_sh(3)]);
    cur_pos=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*Rq3_fr*P_ankle_fr*[0;0;0;1];
else
    q1_fl = q(1);
    q2_fl = q(2);
    q3_fl = q(3);
    
    Rq1_fl = rot(1,q1_fl,4);
    Rq2_fl = rot(2,q2_fl,4);
    Rq3_fl = rot(2,q3_fl,4);
    
    P_shd_fl = trans([],[L_b/2,W_b/2,0]);
    P_hip_fl = trans([],[L_h(1);L_h(2);-L_h(3)]);
    P_knee_fl = trans([],[L_th_f(1);L_th_f(2);-L_th_f(3)]);
    P_ankle_fl = trans([],[-L_sh(1);L_sh(2);-L_sh(3)]);
    
    cur_pos=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*Rq3_fl*P_ankle_fl*[0;0;0;1];
end
end