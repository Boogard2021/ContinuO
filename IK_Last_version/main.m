%% Redundancy Resolution
clear all;
close all;
clc;

global L1 L2 L3 L4

L1= [53.26 61.84 0.1]/1000; % Length of hip
L2= 201/1000; % Length of hind thigh  [0 46.5 201]
L3= 246.5/1000; % Length of middle hind thigh [0 63.5 246.5]
% L4=[-77.18 -145 -280.52]/1000; % Length of shank
L4=[0 0 190.62]/1000; % Length of shank  280.52  190.62

color_list = {'blue', 'red','green', 'black'};

% p_global = [-53.2600 -61.8400 -638.2200]'/1000;  % zero position -728.12
% p_global = [-130.61 -95.84 -620.05]'/1000;
% p_global = [-226.55 -153.84 -463.83]'/1000;
p_global = [192.46 -206.84 18.8]'/1000;

r_0_sho = [-0,-0,0]'/1000;
alpha =10*pi/180;
offset_y = 145/1000;

delta_y = r_0_sho(2)-p_global(2); % SV: removed abs()
%     delta_y = abs(r_0_sho_hl(2)-y_hl);
delta_z = abs(r_0_sho(3)-p_global(3));

h = sqrt(delta_y^2+delta_z^2);
q1 = -atan2(delta_y,delta_z)+asin((L1(2))/h); % SV: updated atan2 and sign => q1 should be positive when hip above shoulder (right and left now different)
%     q1_hl= atan(delta_y/delta_z)-asin((L_h(2))/h);
Rq1 = rot(1,q1,4);
P_sho_hip = trans([],[-L1(1),-L1(2),-L1(3)]);

r_0_hip=   Rq1*P_sho_hip*[0;0;0;1];

% SV: new x-r plane calcs
dx = p_global(1) - r_0_hip(1); % SV: hip to foot dx
dy = p_global(2) - r_0_hip(2); % SV: hip to foot dy
dz = p_global(3) - r_0_hip(3); % SV: hip to foot dz

dr_foot = sqrt(dy^2+dz^2); % positive and increasing as foot moves away from hip

dx_ankle = dx - L4(3)*sin(alpha); % hip to ankle dx
dr_ankle = dr_foot - L4(3)*cos(alpha); % hip to ankle dr

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
Pos = FK(q_new); %q_new
figure
view(3)
Visualize_Robot(Pos, p_global, color_list) %Pos(:,3)
pause(0.1);

