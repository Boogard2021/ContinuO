function q = angle_joints(p)
r_p = p(1:3); % Base position
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);

q_p = p(4:6); % Base rotation
alpha_p = q_p(1);
beta_p  = q_p(2);
gamma_p = q_p(3);

r_fr = p(7:9); % Front Right foot position
x_fr = r_fr(1);
y_fr = r_fr(2);
z_fr = r_fr(3);

r_fl = p(10:12); % Front Left foot position
x_fl = r_fl(1);
y_fl = r_fl(2);
z_fl = r_fl(3);

r_hr = p(13:15); % Hind Right foot position
x_hr = r_hr(1);
y_hr = r_hr(2);
z_hr = r_hr(3);

r_hl = p(16:18); % Hind Left foot position
x_hl = r_hl(1);
y_hl = r_hl(2);
z_hl = r_hl(3);

%% Global
global L_h L_b W_b % Base (Body) dimensions
global redundant 
% global  L_sh L_th_f L_th_h L_th_h_mid    
%% Rotation Matrix
% Body Rotation Matrix
R_p_x =   rot(1,alpha_p,4);
R_p_y =   rot(2,beta_p,4);
R_p_z =   rot(3,gamma_p,4);
R0=R_p_y*R_p_z*R_p_x; % Body Rotation Matrix

%% Translation Matrix
% Base in the World frame
P_p = trans([],r_p);

% Translation from Base to Shoulder joint
P_b_sho_fr = trans([],0.5*[L_b,-W_b,0]);  
P_b_sho_fl = trans([],0.5*[L_b,W_b,0]);
P_b_sho_hr = trans([],0.5*[-L_b,-W_b,0]);
P_b_sho_hl = trans([],0.5*[-L_b,W_b,0]);

% Translation from Shoulder to Hip joint
P_sho_hip_fr = trans([],[L_h(1),-L_h(2),-L_h(3)]);
P_sho_hip_fl = trans([],[L_h(1),L_h(2),-L_h(3)]);
P_sho_hip_hr = trans([],[-L_h(1),-L_h(2),-L_h(3)]);
P_sho_hip_hl = trans([],[-L_h(1),L_h(2),-L_h(3)]);
% Position of Shoulder joint in the World frame
r_0_sho_fr =  P_p*R0*P_b_sho_fr*[0;0;0;1];
r_0_sho_fl =  P_p*R0*P_b_sho_fl*[0;0;0;1];
r_0_sho_hr =  P_p*R0*P_b_sho_hr*[0;0;0;1];
r_0_sho_hl =  P_p*R0*P_b_sho_hl*[0;0;0;1];
%% Front Right
L2_f = 246.5/1000;  % Vertical distance between Shoulder and Knee Joints 
L3_f = 280.67/1000;  % Vertical distance between Knee and Foot Joints 
% off_y = 143.34/1000;

delta_y = abs(r_0_sho_fr(2)-y_fr);
delta_z = r_0_sho_fr(3)-z_fr;

h_fr = sqrt(delta_y^2+delta_z^2);
q1_fr= atan(delta_y/delta_z)-asin(L_h(2)/h_fr); 
r_0 = sqrt(h_fr^2-L_h(2)^2);

Rq1_fr = rot(1,q1_fr,4);
r_0_hip=   P_p*R0*P_b_sho_fr*Rq1_fr*P_sho_hip_fr*[0;0;0;1];

delta_x_hip = x_fr-r_0_hip(1);

h_1 = sqrt(delta_x_hip^2+r_0^2);
phi = asin(delta_x_hip/h_1);
q2_fr = acos((h_1^2+L2_f^2-L3_f^2)/(2*h_1*L2_f))-phi;
q3_fr = acos((L3_f^2+L2_f^2-h_1^2)/(2*L3_f*L2_f))-pi;
%% Front Left
delta_y = abs(r_0_sho_fl(2)-y_fl);
delta_z = r_0_sho_fl(3)-z_fl;

h_fl = sqrt(delta_y^2+delta_z^2);
q1_fl= atan(delta_y/delta_z)-asin(L_h(2)/h_fl);
% q1_fl =0;
r_0 = sqrt(h_fl^2-L_h(2)^2);

Rq1_fl = rot(1,q1_fl,4);
r_0_hip=   P_p*R0*P_b_sho_fl*Rq1_fl*P_sho_hip_fl*[0;0;0;1];

delta_x_hip = x_fl-r_0_hip(1);

h_1 = sqrt(delta_x_hip^2+r_0^2);
phi = asin(delta_x_hip/h_1);
q2_fl = acos((h_1^2+L2_f^2-L3_f^2)/(2*h_1*L2_f))-phi;
q3_fl = acos((L3_f^2+L2_f^2-h_1^2)/(2*L3_f*L2_f))-pi;

%% Hind Right
if redundant == 1 % Hind legs with redundancy
    alpha = 10*pi/180;   % alpha = q2+q3+q4
    L2_h = 201/1000;   % Vertical distance between Shoulder and Knee Joint (Hind leg)
    L3_h = 246.5/1000;  % Vertical distance between Knee and Ankle Joint (Hind leg)
    
    delta_y = r_0_sho_hr(2)-y_hr;
    delta_z = abs(r_0_sho_hr(3)-z_hr);
    
    h = sqrt(delta_y^2+delta_z^2);
    q1_hr= +atan(delta_y/delta_z)-asin((L_h(2))/h);
    Rq1_hr = rot(1,q1_hr,4);
    r_0_hip=   P_p*R0*P_b_sho_hr*Rq1_hr*P_sho_hip_hr*[0;0;0;1];
    
    L4 = [0 0 190.62]/1000;  % Vertical distance from Knee to foot
    
    
    % SV: new x-r plane calcs
    dx = x_hr - r_0_hip(1); % SV: hip to foot dx
    dy = y_hr - r_0_hip(2); % SV: hip to foot dy
    dz = z_hr - r_0_hip(3); % SV: hip to foot dz
    
    dr_foot = sqrt(dy^2+dz^2); % positive and increasing as foot moves away from hip
    
    dx_ankle = dx - L4(3)*sin(alpha); % hip to ankle dx
    dr_ankle = dr_foot - L4(3)*cos(alpha); % hip to ankle dr
    
    h_1 = sqrt(dx_ankle^2+dr_ankle^2); % hyp. to ankle in x-r plane
    phi = asin(dx_ankle/h_1); % angle to h_1 from r
    
    
    if abs((h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h))>1
        ratio = 1; % SV: changed sign, should be >0 now like right leg above
        q2_hr =0;
    else
        ratio = (h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h);
        q2_hr = -phi-acos(ratio); %% SV: -phi because dx>0 in same direction as x, q2>0 when knee behind hip
    end
    % q2_hl = -acos(ratio)+phi; %%%%%%%%%%%%%
    if abs((L3_h^2+L2_h^2-h_1^2)/(2*L2_h*L3_h))>1
        ratio1 = 1;
        q3_hr=0;
    else
        ratio1 = (L3_h^2+L2_h^2-h_1^2)/(2*L2_h*L3_h);
        q3_hr = pi-acos(ratio1);
    end
    
    q4_hr= -q2_hr-q3_hr-alpha;
    %% Hind Left  
%     alpha=10*pi/180;
    delta_y = -(r_0_sho_hl(2)-y_hl);
    delta_z = abs(r_0_sho_hl(3)-z_hl);
    
    h = sqrt(delta_y^2+delta_z^2);
    q1_hl= +atan(delta_y/delta_z)-asin((L_h(2))/h);
    Rq1_hl = rot(1,q1_hl,4);
    r_0_hip=   P_p*R0*P_b_sho_hl*Rq1_hl*P_sho_hip_hl*[0;0;0;1];
    
    L4 = [0 0 190.62]/1000;  % Vertical distance from Knee to foot
    
    
    % SV: new x-r plane calcs
    dx = x_hl - r_0_hip(1); % SV: hip to foot dx
    dy = y_hl - r_0_hip(2); % SV: hip to foot dy
    dz = z_hl - r_0_hip(3); % SV: hip to foot dz
    
    dr_foot = sqrt(dy^2+dz^2); % positive and increasing as foot moves away from hip
    
    dx_ankle = dx - L4(3)*sin(alpha); % hip to ankle dx
    dr_ankle = dr_foot - L4(3)*cos(alpha); % hip to ankle dr
    
    h_1 = sqrt(dx_ankle^2+dr_ankle^2); % hyp. to ankle in x-r plane
    phi = asin(dx_ankle/h_1); % angle to h_1 from r
    
    
    if abs((h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h))>1
        ratio = 1; % SV: changed sign, should be >0 now like right leg above
        q2_hl =0;
    else
        ratio = (h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h);
        q2_hl = -phi-acos(ratio); %% SV: -phi because dx>0 in same direction as x, q2>0 when knee behind hip
    end
    % q2_hl = -acos(ratio)+phi; %%%%%%%%%%%%%
    if abs((L3_h^2+L2_h^2-h_1^2)/(2*L2_h*L3_h))>1
        ratio1 = 1;
        q3_hl=0;
    else
        ratio1 = (L3_h^2+L2_h^2-h_1^2)/(2*L2_h*L3_h);
        q3_hl = pi-acos(ratio1);
    end
    
    q4_hl= -q2_hl-q3_hl-alpha;
else 
    %% Hind Right
    L2_h = 246.5/1000;
    L3_h = 190.62/1000;
%     off_h = 206.84/1000;
%     off_h = 145/1000;

    delta_y = abs(r_0_sho_hr(2)-y_hr);
    delta_z = r_0_sho_hr(3)-z_hr;
    
    h = sqrt(delta_y^2+delta_z^2);
    q1_hr= atan(delta_y/delta_z)-asin((L_h(2))/h);
    r_0 = sqrt(delta_y^2+delta_z^2-(L_h(2))^2);
    
    Rq1_hr = rot(1,q1_hr,4);
    r_0_hip=   P_p*R0*P_b_sho_hr*Rq1_hr*P_sho_hip_hr*[0;0;0;1];
    
    delta_x_hip = x_hr-r_0_hip(1);
    
    h_1 = sqrt(delta_x_hip^2+r_0^2);
    phi = asin(delta_x_hip/h_1);
    q3_hr = acos((h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h))-phi+pi/2;  %
    q4_hr = acos((L3_h^2+L2_h^2-h_1^2)/(2*L3_h*L2_h))-pi;
    q2_hr= -pi/2;
    %% Hind Left
    delta_y = abs(r_0_sho_hl(2)-y_hl);
    delta_z = r_0_sho_hl(3)-z_hl;
    
    h = sqrt(delta_y^2+delta_z^2);
    q1_hl= -atan(delta_y/delta_z)+asin((L_h(2))/h);
    r_0 = sqrt(delta_y^2+delta_z^2-(L_h(2))^2);
    
    Rq1_hl = rot(1,q1_hl,4);
    r_0_hip=   P_p*R0*P_b_sho_hl*Rq1_hl*P_sho_hip_hl*[0;0;0;1];
    
    delta_x_hip = x_hl-r_0_hip(1);
    
    h_1 = sqrt(delta_x_hip^2+r_0^2);
    phi = asin(delta_x_hip/h_1);
    q3_hl = acos((h_1^2+L2_h^2-L3_h^2)/(2*h_1*L2_h))-phi+pi/2;
    q4_hl = acos((L3_h^2+L2_h^2-h_1^2)/(2*L3_h*L2_h))-pi;
    q2_hl= -pi/2;

end
%% Output
q_fr = [q1_fr q2_fr q3_fr]'; % Right Angles
q_fl = [q1_fl q2_fl q3_fl]'; % Right Angles
q_hr = [q1_hr q2_hr q3_hr q4_hr]'; % Right Angles
q_hl = [q1_hl q2_hl q3_hl q4_hl]'; % Right Angles

q = [q_fr;q_fl;q_hr;q_hl];
end