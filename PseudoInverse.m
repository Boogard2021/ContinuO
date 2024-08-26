function [q, q_dot] = PseudoInverse(q_0, p_global,p,leg,flag)
global delt
global L_sh L_th_f L_th_h L_th_h_mid L_b W_b L_h

k = 1000;
r_p = p(1:3);
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);
q_p = p(4:6); % body rotation
alpha_p = q_p(1);
beta_p = q_p(2);
gamma_p = q_p(3);
weights = [100,1,10];
W = diag(weights);

R_p_x = rot(1,alpha_p,4);
R_p_y = rot(2,beta_p,4);
R_p_z = rot(3,gamma_p,4);
R0 = R_p_y*R_p_z*R_p_x;
P_p = trans([],r_p);
%% Calculating the forward kinematics
if leg == 1
    J1 = Jacob_hl(q_p,q_0);
    q1_hl = q_0(1);
    q2_hl = q_0(2);
    q3_hl = q_0(3);
    q4_hl = q_0(4);
    
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
    
else %leg == 2
    J1 = Jacob_hr(q_p,q_0);
    q1_hr = q_0(1);
    q2_hr = q_0(2);
    q3_hr = q_0(3);
    q4_hr = q_0(4);
    
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
    % elseif leg == 0
    %     J1 = JJ(1:3,7:9);
    %     q1_fr = q_0(1);
    %     q2_fr = q_0(2);
    %     q3_fr = q_0(3);
    %
    %     Rq1_fr = rot(1,q1_fr,4);
    %     Rq2_fr = rot(2,q2_fr,4);
    %     Rq3_fr = rot(2,q3_fr,4);
    %     P_shd_fr = trans([],[L_b/2,-W_b/2,0]);
    %     P_hip_fr = trans([],[L_h(1);-L_h(2);-L_h(3)]);
    %     P_knee_fr = trans([],[L_th_f(1);-L_th_f(2);-L_th_f(3)]);
    %     P_ankle_fr = trans([],[-L_sh(1);-L_sh(2);-L_sh(3)]);
    %     cur_pos=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*Rq3_fr*P_ankle_fr*[0;0;0;1];
    % else
    %     J1 = JJ(1:3,14:16);
    %     q1_fl = q_0(1);
    %     q2_fl = q_0(2);
    %     q3_fl = q_0(3);
    %
    %     Rq1_fl = rot(1,q1_fl,4);
    %     Rq2_fl = rot(2,q2_fl,4);
    %     Rq3_fl = rot(2,q3_fl,4);
    %     P_shd_fl = trans([],[L_b/2,W_b/2,0]);
    %     P_hip_fl = trans([],[L_h(1);L_h(2);-L_h(3)]);
    %     P_knee_fl = trans([],[L_th_f(1);L_th_f(2);-L_th_f(3)]);
    %     P_ankle_fl = trans([],[-L_sh(1);L_sh(2);-L_sh(3)]);
    %     cur_pos=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*Rq3_fl*P_ankle_fl*[0;0;0;1];
end
%% Getting the r vector
r = p_global - cur_pos(1:3);

%% Numerical differentiation
r_dot = r./k; % To decrease the step that is taken by the velocity, k is some large constant
% if leg==1 | leg==2
if flag == 1
    J_inv_ps = pinv(J1);
else %Weighted pseudo inverse
    %     J_inv_ps =  W\J1'/(J1/W*J1');
    J_inv_ps = inv(J1'*W*J1)*J1'*W ;
end
% else
%     J_inv = inv(J1);
% end
%% Caculating the q_dot
% if leg==1 | leg==2
q_dot = J_inv_ps * r_dot;
% else
% q_dot = J_inv * r_dot;
% end
q = q_0+ (q_dot .* delt);
end