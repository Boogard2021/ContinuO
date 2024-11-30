function dq = IK_diff(d, p)
% Computes ContinuO's inverse kinematics using a differential
%   formulation from the desired velocities of its feet and body and their 
%   positions.
% 
% Syntax: q = IK_diff(d, p)
% 
% Inputs: 
%   d - trajectory vector: 
%       d = [r_p; q_p; r_fr; r_fl; r_hr; r_hl; 
%           dr_p; dq_p; dr_fr; dr_fl; dr_hr; dr_hl;      
%           ddr_p; ddq_p; ddr_fr; ddr_fl; ddr_hr; ddr_hl]
%   p - world frame position vector:
%       p = [p0b; qb; p0fr; p0fl; p0hr; p0hl]
% 
% Outputs:
%   dq - joint velocity vector (state vector time-derivative): 
%       dq = [dr_p; dq_p; dq_fr; dq_fl; dq_hr; dq_hl]
% 
% By Stefan Van de Mosselaer, modified from code by Hossein Keshavarz and
%   Stefan Van de Mosselaer.
% 
% 13-Dec-2024
% 
% TODO: fix docutext

%% Global
% From quad_properties.m:
global L_h L_b W_b % Base (Body) dimensions

% From quad_parameters.m, limb x, y, and z dimensions:
global L_sh_f_x L_sh_h_x L_th_f_x L_th_h_x L_th_h_mid_x L_h_x 
global L_sh_f_y L_sh_h_y L_th_f_y L_th_h_y L_th_h_mid_y L_h_y 
global L_sh_f_z L_sh_h_z L_th_f_z L_th_h_z L_th_h_mid_z L_h_z

%% Variable Definition
% Actual Base and Foot Positions
p0b = p(1:3); % Base position (world frame)
x_b = p0b(1);
y_b = p0b(2);
z_b = p0b(3);

q0b = p(4:6); % Base rotation angles (world frame)
theta_b = q0b(1); % Roll
phi_b  = q0b(2); % Pitch
psi_b = q0b(3); % Yaw

p0fr = p(7:9); % Front Right foot position (world frame)
x_fr = p0fr(1);
y_fr = p0fr(2);
z_fr = p0fr(3);

p0fl = p(10:12); % Front Left foot position (world frame)
x_fl = p0fl(1);
y_fl = p0fl(2);
z_fl = p0fl(3);

p0hr = p(13:15); % Hind Right foot position (world frame)
x_hr = p0hr(1);
y_hr = p0hr(2);
z_hr = p0hr(3);

p0hl = p(16:18); % Hind Left foot position (world frame)
x_hl = p0hl(1);
y_hl = p0hl(2);
z_hl = p0hl(3);

% Trajectory Velocities
dp0b_d = d(19:21); % Desired base velocity (world frame)
dqb_d = d(22:24); % Desired base rotation rate (world frame) (roll, pitch, yaw)
dp0fr_d = d(25:27); % Desired front right foot velocity (world frame)
dp0fl_d = d(28:30); % Desired front left foot velocity (world frame)
dp0hr_d = d(31:33); % Desired hind right foot velocity (world frame)
dp0hl_d = d(34:36); % Desired hind left foot velocity (world frame)

%% Rotation Matrix
% Body Rotation Matrix
R_p_x =   rot(1,theta_b,4);
R_p_y =   rot(2,phi_b,4);
R_p_z =   rot(3,psi_b,4);
R0b = R_p_z*R_p_y*R_p_x; % Body Rotation Matrix (4x4)

%% Translation Matrix
% Base in the World frame
P0b = trans([],p0b);

% Translation from Base to Shoulder joint (joint 1)
Pb1_fr = trans([],0.5*[L_b,-W_b,0]);  
Pb1_fl = trans([],0.5*[L_b,W_b,0]);
Pb1_hr = trans([],0.5*[-L_b,-W_b,0]);
Pb1_hl = trans([],0.5*[-L_b,W_b,0]);

% Translation from Shoulder (joint 1) to Hip joint (joint 2)
P12_fr = trans([],[L_h(1),-L_h(2),-L_h(3)]);
P12_fl = trans([],[L_h(1),L_h(2),-L_h(3)]);
P12_hr = trans([],[-L_h(1),-L_h(2),-L_h(3)]);
P12_hl = trans([],[-L_h(1),L_h(2),-L_h(3)]);

% Position of Shoulder joints (joint 1) in the World frame
p01_fr =  P0b*R0b*Pb1_fr*[0;0;0;1];
p01_fl =  P0b*R0b*Pb1_fl*[0;0;0;1];
p01_hr =  P0b*R0b*Pb1_hr*[0;0;0;1];
p01_hl =  P0b*R0b*Pb1_hl*[0;0;0;1];

%% Jacobians
% Import foot Jacobians from external script files (computed symbolically,
%   variable values filled from workspace on script run):
run JJv_fr 
run JJv_fl
run JJv_hr
run JJv_hl

% Reshape 1x60 foot Jacobian vectors into 3x20 matrices:
Jv_fr=reshape(Jv_fr,3,20);
Jv_fl=reshape(Jv_fl,3,20);
Jv_hr=reshape(Jv_hr,3,20);
Jv_hl=reshape(Jv_hl,3,20);

% Body spatial Jacobian is I6
Jb = eye(6); 

%% IK
% Extended Jacobian for EE (foot) tasks
Je = [Jv_fr; Jv_fl; Jv_hr; Jv_hl]; 
% Extended task velocity vector for EE (foot) trajectories
dpe = [dp0fr_d; dp0fl_d; dp0hr_d; dp0hl_d];

% 6D body task velocity (linear and angular)
vb = [dp0b_d; dqb_d]; 

% Nullspace projector for foot tasks
N1 = eye(20) - pinv(Je)*Je; 

% Compute joint velocities (state vector time-derivative)
dq = pinv(Je)*dpe + N1*Jb*vb; 

end