clear all
clc
syms q1 q2 q3 L_h off_h_y off_sh_x off_sh_y L_sh off_th_y L_th L_b W_b
syms alpha_p beta_p gamma_p 
syms x_b y_b z_b 
r_p=[x_b y_b z_b]';
syms x_e y_e z_e
syms q1 q2 q3
%% Rotation Matrix
% Pelvis
R_p_x =   rot(1,alpha_p,4);
R_p_y =   rot(2,beta_p,4);  
R_p_z =   rot(3,gamma_p,4);  
R_0_p=R_p_y*R_p_z*R_p_x; % Pelvis Rotation Matrix

R0 = R_0_p;
% Front Right 
Rq1 = rot(1,q1,4);
Rq2 = rot(2,q2,4);
Rq3 = rot(2,q3,4);


R1 = R0*Rq1; % Hip_z Rotation Matrix from pelvis
R2 = R1*Rq2; % Hip_x Rotation Matrix from pelvis
R3 = R2*Rq3; % Hip Rotation Matrix from pelvis

%% Translation Matrix
% Trunk
P_p = trans([],r_p);
% Front Right
P_b_sho = trans([],0.5*[L_b,-W_b,0]);
P_sho_hip = trans([],[L_h,-off_h_y,0]);
P_hip_th = trans([],[0,off_th_y,-L_th]); %L_th_y
P_th_sh = trans([],[-off_sh_x,-off_sh_y,-L_sh]); %-L_sh_x,-L_sh_y

T_0_b= P_p*R0;
%% Position

r_0_sho =  T_0_b*P_b_sho;
r_0_hip=   T_0_b*P_b_sho*P_sho_hip*Rq1;

r_e= [x_e y_e z_e]';
r_0_e = trans([],r_e);
% T_sho_e = inv(r_0_sho)*r_0_e;
% r_sho_e = T_sho_e(1:3,4); 
% X= simplify(r_sho_e(1))
% Y= simplify(r_sho_e(2))
% Z= simplify(r_sho_e(3))

T_hip_e = inv(r_0_hip)*r_0_e;
r_hip_e = T_hip_e(1:3,4); 
X= simplify(r_hip_e(1))
Y= simplify(r_hip_e(2))
Z= simplify(r_hip_e(3))

c3_r = (r_hip_e^2-L_sh^2-L_th^2)/(2*L_sh*L_th);
if abs(c3_r)<1
    q3 = atan2(sqrt(1-c3_r^2),c3_r); % Knee Joint Y
elseif abs(c3_r)>=1
    q3 = 0;
end
% r_r = sqrt(sum(r_hip_e.^2))

% r_hip_fl=   P_p*R0*P_sho_fl*R1_fl*P_hip_c_fl*[0;0;0;1];

% r_th_fr=   P_p*R0*P_sho_fr*R1_fr*P_hip_fr*R2_fr*P_th_fr*[0;0;0;1];
% r_th_fl=   P_p*R0*P_sho_fl*R1_fl*P_hip_fl*R2_fl*P_th_c_fl*[0;0;0;1];

% r_sh_fr=   P_p*R0*P_sho_fr*R1_fr*P_hip_fr*R2_fr*P_th_fr*R3_fr*P_sh_fr*[0;0;0;1];
% r_sh_fl=   P_p*R0*P_sho_fl*R1_fl*P_hip_fl*R2_fl*P_th_fl*R3_fl*P_sh_c_fl*[0;0;0;1];


% T_e_h=P_hip*Rq1*P_thigh*Rq2*P_shank*Rq3;
% T_h_e=simplify(inv(T_e_h));
% P_e=T_h_e(1:3,4);
% 

% r_delta = r_sh_fr-r_sho_fr;
% T_h_e=simplify(inv(T_e_h));
% 
% X= simplify(r_delta(1));
% Y= simplify(r_delta(2));
% Z= simplify(r_delta(3));

% q1= acos((P_e(2)-L_sh_y - L_th_y)/L_h_y); 
% C=simplify((P_e(1))^2+(P_e(3))^2-(L_h_x^2 - L_h_y^2*cos(q1)^2 + L_h_y^2 + L_sh_x^2 + L_sh_z^2 + L_th_z^2 - 2*L_h_y*L_th_z*sin(q1)));
% A=2*L_h_x*L_sh_x+2*L_sh_z*L_th_z-2*L_h_y*L_sh_z*sin(q1) ; 
% B=2*L_h_x*L_sh_z-2*L_sh_x*L_th_z+2*L_h_y*L_sh_x*sin(q1) ;
% q2=2*atan((A+sqrt(A^2+B^2-C^2))/(B-C));   %q2=2*atan((A-sqrt(A^2+B^2-C^2))/(-C+B));
% 
% C1=P_e(1);
% A1=(-L_h_y*sin(q2 - q1))/2 - L_h_x*sin(q2) - L_th_z*cos(q2)- L_sh_z + (L_h_y*sin(q1 + q2))/2;
% B1=(L_h_y*cos(q2 - q1))/2 + L_h_x*cos(q2) - L_th_z*sin(q2) + L_sh_x - (L_h_y*cos(q1 + q2))/2;
% q3=2*atan((A1+sqrt(A1^2+B1^2-C1^2))/(B1-C1));   %q3=2*atan((A1-sqrt(A1^2+B1^2-C1^2))/(-C1+B1))
% %%
% X0 = [theta1, theta2, theta3, theta4];
% 
% %fsolve solves for the roots for the equation X-XDES
% [X,FVAL,EXITFLAG] = fsolve('find_joint_angles',X0);
% theta1 = X(1);
% theta2 = X(2);
% theta3 = X(3);
% theta4 = X(4);
% disp(['Exitflag after running fsolve = ', num2str(EXITFLAG) ]) %Tells if fsolve converged or not
%                %1 means converged else not converged 