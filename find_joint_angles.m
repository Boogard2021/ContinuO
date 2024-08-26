%This function finds the values for theta, given the end effector positions
function X = find_joint_angles(u)
global L_sh L_th_h L_th_h_mid L_h L_b W_b
% Get individual theta's from input
q1=u(1); q2=u(2); q3=u(3); q4=u(4);
x_des = u(5);
y_des = u(6);
z_des = u(7);
r_p = u(8:10); % pelvis position
q_p = u(11:13); % pelvis rotation
alpha_p = q_p(1);
beta_p = q_p(2);
gamma_p = q_p(3);
id =u(end);
%% Rotation Matrix
% Pelvis
R_p_x = rot(1,alpha_p,4);
R_p_y = rot(2,beta_p,4);
R_p_z = rot(3,gamma_p,4);
R0 = R_p_y*R_p_z*R_p_x;

% Hind Left
Rq1 = rot(1,q1,4);
Rq2 = rot(2,q2,4);
Rq3 = rot(2,q3,4);
Rq4 = rot(2,q4,4);

%% Translation Matrix
% Trunk
P_p = trans([],r_p);

if id ==1
    %Hind Right
    P_shd = trans([],[-L_b/2,-W_b/2,0]);
    P_hip = trans([],[-L_h(1);-L_h(2);-L_h(3)]);
    P_knee_mid = trans([],[-L_th_h_mid(1);-L_th_h_mid(2);-L_th_h_mid(3)]);
    P_knee = trans([],[-L_th_h(1);-L_th_h(2);-L_th_h(3)]);
    P_ankle = trans([],[-L_sh(1);-L_sh(2);-L_sh(3)]);
else
    %Hind Left
    P_shd = trans([],[-L_b/2,W_b/2,0]);
    P_hip = trans([],[-L_h(1);L_h(2);-L_h(3)]);
    P_knee_mid = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
    P_knee = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
    P_ankle = trans([],[-L_sh(1);L_sh(2);-L_sh(3)]);
end
%% Position
r_ankle= P_p*R0*P_shd*Rq1*P_hip*Rq2*P_knee_mid*Rq3*P_knee*Rq4*P_ankle*[0;0;0;1];
endOfLink=r_ankle(1:3)
%Forming the equation to be solved. This will be then solved using FSolve
X = [endOfLink(1)-x_des; endOfLink(2)-y_des; endOfLink(3)-z_des];