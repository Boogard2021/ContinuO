%% Redundancy Resolution
clear all;
close all;
clc;

global L1 L2 L3 L4 L_b W_b

L1 = [53.26 206.84 0.1]/1000; % Length of hip
L2 = 201/1000; % Length of hind thigh  
L3 = 246.5/1000; % Length of middle hind thigh 
% SV: As discussed, will set the zero position to the point with frame 5
% directly under frame 4 (on z4 axis). Length between frame 4 and 5 then equal
% to sqrt(77.21^2 + 190.62^2) = 205.66 mm.
L4 = norm([77.21 0 190.62])/1000; % Length of shank   dx = 77.21/1000
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
p_global = [-393.96+77.21 -329.74 -638.29-(norm([77.21, 190.62])-190.62)]'/1000;  % adjusted zero position
% p_global = [-393.96+77.21 -329.74 -438.29-(norm([77.21, 190.62])-190.62)]'/1000;
% p_global = [-393.96+77.21 -329.74 -138.29-(norm([77.21, 190.62])-190.62)]'/1000;
% p_global = [-393.96+77.21 -429.74 -438.29-(norm([77.21, 190.62])-190.62)]'/1000;
% p_global = [-193.96+77.21 -329.74 -438.29-(norm([77.21, 190.62])-190.62)]'/1000;

% p_global = [-393.96 -329.74 -638.29]'/1000;  % old zero position 
% p_global = [-393.96 -229.74 -638.29]'/1000;
% p_global = [-323.96 -229.74 -438.29]'/1000;
% p_global = [-393.96 -329.74 -38.29]'/1000;
% p_global = [-323.96 -229.74 -188.29]'/1000;

%%

alpha = 0*pi/180:-0.2*pi/180:-75*pi/180;
% TODO: cleanup commented code after testing
% delta_y = r_w_sho_hr(2)-p_global(2); % SV: removed abs()
% delta_z = abs(r_w_sho_hr(3)-p_global(3));

% vector from joint 1 to 5 (foot) in joint 1_hr frame:
p_1_5_hr = transpose(R0(1:3,1:3)) * (p_global - r_w_sho_hr(1:3)); 

% h = sqrt(delta_y^2+delta_z^2);
% q1 = -atan2(delta_y,delta_z)+asin((L1(2))/h); % SV: updated atan2 and sign 
% => q1 should be positive when hip above shoulder (right and left now different)

% h using joint 1 frame instead of delta_y & z:
h = sqrt(p_1_5_hr(2)^2 + p_1_5_hr(3)^2);

% hr q1 using joint 1 frame and with q1 positive when hip above shoulder 
% (right and left now different). atan2 discontinuity rotated to an 
% unattainable point (along y_1 axis) (by -pi/2):
q1 = atan2(-p_1_5_hr(3), -p_1_5_hr(2))+ asin(L1(2)/h) - pi/2; 

% Renamed several for consistency with writeup notation & clarity.
R_1_2_hr = rot(1,q1,4); 
R_0_2_hr = R0 * R_1_2_hr;

P_1_2_hr = trans([],[-L1(1),-L1(2),-L1(3)]);
p_0_2_hr = P_p*R0*r_b_sho_hr*R_1_2_hr*P_1_2_hr*[0;0;0;1];

% Vector from frame 2 to 5 in joint 2 frame:
p_2_5_hr = transpose(R_0_2_hr(1:3,1:3)) * (p_global - p_0_2_hr(1:3));

% % SV: new x-r plane calcs
% dx = p_global(1) - r_0_hip(1); % SV: hip to foot dx
% dy = p_global(2) - r_0_hip(2); % SV: hip to foot dy
% dz = p_global(3) - r_0_hip(3); % SV: hip to foot dz
% dr_foot = sqrt(dy^2+dz^2); % positive and increasing as foot moves away from hip

%%
for i = 1: length(alpha)
    % Vector from frame 5 to 4 (notice order) in joint 2 frame as a function of alpha:
    p_2_5_4 = [-L4*sin(alpha(i)); 0; L4*cos(alpha(i))];
    
    p_2_4_hr = p_2_5_hr + p_2_5_4; % Vector from frame 2 to 4 in joint 2 frame.

%   Angle between z_2 axis and p_2_4_hr, with dextral sign. Renamed from
%   phi to avoid confusion with body rotation angle.
    beta = atan2(-p_2_4_hr(1), -p_2_4_hr(3)); 

%     dx_ankle = dx - L4(3)*sin(alpha(i)) + L4(1)*cos(alpha((i))); % hip to ankle dx
%     dr_ankle = dr_foot - L4(3)*cos(alpha(i)); % hip to ankle dr L4(3)*cos(alpha)

%     h_1 = sqrt(dx_ankle^2+dr_ankle^2); % hyp. to ankle in x-r plane
%     phi = asin(dx_ankle/h_1); % angle to h_1 from r

% norm(p_2_4_hr) is the magnitude (2-norm) of the vector p_2_4_hr,
% equivalent to h_1 previously used:
% Also, I don't know if the domain check is still necessary:
    if abs((norm(p_2_4_hr)^2+L2^2-L3^2)/(2*norm(p_2_4_hr)*L2))>1
        ratio = 1; 
        q2 = 0;
    else
        ratio = (norm(p_2_4_hr)^2+L2^2-L3^2)/(2*norm(p_2_4_hr)*L2);
        q2 = -acos(ratio) + beta; % Note change in sign because of orientation of beta.
    end
    % q2_hl = -acos(ratio)+phi; %%%%%%%%%%%%%
    if abs((L3^2+L2^2-norm(p_2_4_hr)^2)/(2*L3*L2))>1
        ratio1 = 1;
        q3 = 0;
    else
        ratio1 = (L3^2+L2^2-norm(p_2_4_hr)^2)/(2*L3*L2);
        q3 = -acos(ratio1) + pi;
    end

    q4= -q2-q3-alpha(i);
    q_new(i,:) =[q1,q2,q3,q4];
    foot_Pos = FK(q_new(i,:), base_pos); %q_new
    error(i) = sqrt((foot_Pos(1,5)-p_global(1))^2+(foot_Pos(2,5)-p_global(2))^2+(foot_Pos(3,5)-p_global(3))^2); % root square error
end
plot(alpha*180/pi, error) 
[minError, minIndex] = min(error);
minAlpha = alpha(minIndex);
fprintf("alpha = %.2f deg\nerror = %.2e m", minAlpha*180/pi, minError)
foot_Pos_min = FK(q_new(minIndex,:), base_pos);

figure
view(3)
Visualize_Robot(body_pos,foot_Pos_min, p_global, color_list) %Pos(:,3)
pause(0.1);


