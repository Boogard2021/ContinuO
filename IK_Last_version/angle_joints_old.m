function q = angle_joints(q1,p,dy,dz)

global L1 L2 L3 

% %% Rotation Matrix
% % Pelvis
% R_p_x =   rot(1,alpha_p,4);
% R_p_y =   rot(2,beta_p,4);
% R_p_z =   rot(3,gamma_p,4);
% R0=R_p_y*R_p_z*R_p_x; % Pelvis Rotation Matrix

% % Front Right
% Rq1 = rot(1,q1,4);
% %% Translation Matrix
% P_p = trans([],r_p);
% % Front Right
% P_b_sho_fr = trans([],0.5*[L_b,-W_b,0]);
% P_b_sho_fl = trans([],0.5*[L_b,W_b,0]);
% P_b_sho_hr = trans([],0.5*[-L_b,-W_b,0]);
% P_b_sho_hl = trans([],0.5*[-L_b,W_b,0]);
P_sho_hip = trans([],[-L1(1),-L1(2),-L1(3)]);
% P_sho_hip_fl = trans([],[L_h(1),L_h(2),-L_h(3)]);
% P_sho_hip_hr = trans([],[-L_h(1),-L_h(2),-L_h(3)]);
% P_sho_hip_hl = trans([],[-L_h(1),L_h(2),-L_h(3)]);

% r_0_sho_fr =  P_p*R0*P_b_sho_fr*[0;0;0;1];
% r_0_sho_fl =  P_p*R0*P_b_sho_fl*[0;0;0;1];
% r_0_sho_hr =  P_p*R0*P_b_sho_hr*[0;0;0;1];
% r_0_sho_hl =  P_p*R0*P_b_sho_hl*[0;0;0;1];
%% Front Right
% delta_y = -p(2);
% delta_z = -p(3);
% 
% h = sqrt(delta_y^2+delta_z^2);
% q1= (atan(delta_y/delta_z)-asin(L1(2)/h));
% r_0 = sqrt(delta_y^2+delta_z^2-L1(2)^2);

Rq1 = rot(1,q1,4);
r_0_hip=  Rq1*P_sho_hip*[0;0;0;1];

delta_x= r_0_hip(1)-p(1);
delta_y= r_0_hip(2)-p(2);
delta_z= r_0_hip(3)-p(3);
r_0 = sqrt(dy^2+dz^2-L1(2)^2);

% delta_x_hip = -r_0_hip(1)+p(1);
h_1 = sqrt(delta_x^2+r_0^2);
phi = asin(delta_x/h_1);
if abs((h_1^2+L2^2-L3^2)/(2*h_1*L2))>1
    ratio = 1;
else
    ratio = (h_1^2+L2^2-L3^2)/(2*h_1*L2);
end
q2 = phi-acos(ratio);
if abs((L3^2+L2^2-h_1^2)/(2*L3*L2))>1
    ratio1 = -1;
else
    ratio1 = (L3^2+L2^2-h_1^2)/(2*L2*L3);
end
q3 = pi-acos(ratio1);

q = [q2,q3];
% pause
end