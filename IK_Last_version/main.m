%% Redundancy Resolution
clear all;
close all;
clc;

global L1 L2 L3 L4 L_b W_b

L1 = [53.26 206.84 0.1]/1000; % Length of hip
L2 = 201/1000; % Length of hind thigh  
L3 = 246.5/1000; % Length of middle hind thigh 
L4 = [77.21 0 190.62]/1000; % Length of shank   dx = 77.21/1000 
L_b = 527/1000; % Length of body
W_b = 245.81/1000; % Width of body    

color_list = {'blue', 'red','green', 'black'};

%% Position of the base
r_p = [0.0 0.0 0.0]'/1000;
angle_p = [0.0 0.0 0.0]'*pi/180;
R_p_x =   rot(1,angle_p(1),4);
R_p_y =   rot(2,angle_p(2),4);
R_p_z =   rot(3,angle_p(3),4);
R0=R_p_z*R_p_y*R_p_x; % Body Rotation Matrix

base_pos = [r_p, angle_p];
%%
P_p = trans([],r_p);

r_b_sho_hr = trans([],[-L_b/2,-W_b/2,0]);
r_b_sho_hl = trans([],[-L_b/2,W_b/2,0]);
r_b_sho_fr = trans([],[L_b/2,-W_b/2,0]);
r_b_sho_fl = trans([],[L_b/2,W_b/2,0]);

r_w_sho_hr =  P_p*R0*r_b_sho_hr*[0;0;0;1];
r_w_sho_hl =  P_p*R0*r_b_sho_hl*[0;0;0;1];
r_w_sho_fr =  P_p*R0*r_b_sho_fr*[0;0;0;1];
r_w_sho_fl =  P_p*R0*r_b_sho_fl*[0;0;0;1];

body_pos= [r_w_sho_hr(1:3),r_w_sho_hl(1:3),r_w_sho_fr(1:3),r_w_sho_fl(1:3)];
%% Position of foot 
% p_global = [-393.96 -329.74 -638.29]'/1000;  % zero position 
% p_global = [-393.96 -229.74 -638.29]'/1000;
p_global = [-323.96 -229.74 -438.29]'/1000;
% p_global = [-323.96 -229.74 -258.29]'/1000;

%%
alpha = 0*pi/180;
%offset_y = 145/1000;

delta_y = r_w_sho_hr(2)-p_global(2); % SV: removed abs()
delta_z = abs(r_w_sho_hr(3)-p_global(3));

h = sqrt(delta_y^2+delta_z^2);
q1 = -atan2(delta_y,delta_z)+asin((L1(2))/h); % SV: updated atan2 and sign => q1 should be positive when hip above shoulder (right and left now different)
Rq1 = rot(1,q1,4);
P_sho_hip = trans([],[-L1(1),-L1(2),-L1(3)]);

r_0_hip=   P_p*R0*r_b_sho_hr*Rq1*P_sho_hip*[0;0;0;1];

% SV: new x-r plane calcs
dx = p_global(1) - r_0_hip(1); % SV: hip to foot dx
dy = p_global(2) - r_0_hip(2); % SV: hip to foot dy
dz = p_global(3) - r_0_hip(3); % SV: hip to foot dz

dr_foot = sqrt(dy^2+dz^2); % positive and increasing as foot moves away from hip

% rr = sqrt(L4(1)^2+L4(3)^2);
dx_ankle = dx - L4(3)*sin(alpha) + L4(1)*cos(alpha); % hip to ankle dx   
dr_ankle = dr_foot - L4(3)*cos(alpha); % hip to ankle dr L4(3)*cos(alpha)

h_1 = sqrt(dx_ankle^2+dr_ankle^2); % hyp. to ankle in x-r plane
phi = asin(dx_ankle/h_1); % angle to h_1 from r


if abs((h_1^2+L2^2-L3^2)/(2*h_1*L2))>1
    ratio = 1; % SV: changed sign, should be >0 now like right leg above
    q2 =0;
else
    ratio = (h_1^2+L2^2-L3^2)/(2*h_1*L2);
    q2 = -phi-acos(ratio); %% SV: -phi because dx>0 in same direction as x, q2>0 when knee behind hip
end
% q2_hl = -acos(ratio)+phi; %%%%%%%%%%%%%
if abs((L3^2+L2^2-h_1^2)/(2*L3*L2))>1
    ratio1 = 1;
    q3=0;
else
    ratio1 = (L3^2+L2^2-h_1^2)/(2*L2*L3);
    q3 = pi-acos(ratio1);
end

q4= -q2-q3-alpha;
q_new =[q1,q2,q3,q4];
foot_Pos = FK(q_new, base_pos); %q_new
figure
view(3)
Visualize_Robot(body_pos,foot_Pos, p_global, color_list) %Pos(:,3)
pause(0.1);

