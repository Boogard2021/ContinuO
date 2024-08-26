clear all
clc
syms q1 q2 q3 q4 q5 q6 L_sh L_th L_pl L_inth real
syms alpha_p beta_p gama_p omega real
syms alpha_a beta_a real
syms x_p y_p z_p real
syms x_a y_a z_a real
r_p=[x_p y_p z_p]';
% r_a=[x_a y_a z_a]';
syms rx ry rz real
r=[rx ry rz]';
syms A B C
%% Rotation Matrix
R_omega = [1 0 0 0;
           0 cos(omega) -sin(omega) 0;
           0 sin(omega) cos(omega) 0;
           0 0 0 1];
   
Rq1 = [1 0 0 0;
       0 cos(q1) -sin(q1) 0;
       0 sin(q1) cos(q1) 0;
       0 0 0 1];

Rq2 = [cos(q2) 0 sin(q2) 0;
       0 1 0 0;
       -sin(q2) 0 cos(q2) 0;
       0 0 0 1];

Rq3 = [cos(q3) -sin(q3) 0 0;
       sin(q3) cos(q3) 0 0;
       0 0 1 0;
       0 0 0 1];
     
Rq4 = [cos(q4) 0 sin(q4) 0;
       0 1 0 0;
       -sin(q4) 0 cos(q4) 0;
       0 0 0 1];
     
Rq5 = [1 0 0 0;
       0 cos(q5) -sin(q5) 0;
       0 sin(q5) cos(q5) 0;
       0 0 0 1];

Rq6 = [cos(q6) 0 sin(q6) 0;
       0 1 0 0;
       -sin(q6) 0 cos(q6) 0;
       0 0 0 1];

%% Translation Matrix
P_shank=[1 0 0 0;
         0 1 0 0;
         0 0 1 -L_sh;
         0 0 0 1];

P_thigh=[1 0 0 0;
         0 1 0 0;
         0 0 1 -L_th;
         0 0 0 1];
     
P_p_h=[1 0 0 0;
          0 1 0 -0.5*L_pl;
          0 0 1 -L_inth;
          0 0 0 1];      
%% Translation Matrix
% R_p_x=[1 0 0 0;
%        0 cos(alpha_p) -sin(alpha_p) 0;
%        0 sin(alpha_p) cos(alpha_p) 0;
%        0 0 0 1];
%    
% R_p_y=[cos(beta_p) 0 sin(beta_p) 0;
%        0 1 0 0;
%        -sin(beta_p) 0 cos(beta_p) 0;
%        0 0 0 1];
%    
% R_p_z=[cos(gama_p) -sin(gama_p) 0 0;
%        sin(gama_p) cos(gama_p) 0 0;
%        0 0 1 0;
%        0 0 0 1];
% R_0_p=R_p_y*R_p_z*R_p_x;
% P_0_p=[[eye(3,3);zeros(1,3)] [r_p;1]];
% 
% T_0_p=simple(P_0_p*R_0_p);
%  
% T_p_h=P_p_h;
% 
% T_0_h=T_0_p*T_p_h;

% T_2_5=P_thigh*Rq4*P_shank*Rq6*Rq5;
% T_5_2=simple(inv(T_2_5));
% 
% r_5_2=T_5_2(1:3,4) %for q5
% 
% EQ4=simple(sum(r_5_2.^2)) % for q4
% EQ6=[r_5_2(1);simple(sqrt(sum(r_5_2(2:3).^2)))] % for q6
% 
% T_h_6=simple(Rq3*R_omega*Rq1*Rq2*P_thigh*Rq4*P_shank*Rq6);
% T_6_h=simple(inv(T_h_6)) % for q1 q3 q2

T_2_6=P_thigh*Rq4*P_shank*Rq6*Rq5;
T_6_2=simple(inv(T_2_6))

r_6_2=T_6_2(1:3,4) %for q6
% rr_6_2=[-cos(q5)*sin(q6)*(L_sh + L_th*cos(q4))- L_th*cos(q6)*sin(q4);
%         sin(q5)*(L_sh + L_th*cos(q4));
%         cos(q5)*cos(q6)*(L_sh + L_th*cos(q4))- L_th*sin(q6)*sin(q4)];
%     
% A=[-cos(q5)*(L_sh + L_th*cos(q4)) -L_th*sin(q4);
%    -L_th*sin(q4)                 cos(q5)*(L_sh + L_th*cos(q4))];   
%     
% err=simple(r_6_2([1 3])-A*[sin(q6);cos(q6)])
% break

EQ4_=simple(sum(r_6_2.^2)) % for q4
% EQ6_=[r_6_2(2);simple(sqrt(sum(r_6_2([1 3]).^2)))] % for q6
% EQ66_=simple(sum(r_6_2([1 3]))) % for q6
% EQQ=simple(r_6_2(1)*cos(q6)+r_6_2(3)*sin(q6))
break
T_h_5=simplify(Rq3*R_omega*Rq1*Rq2*P_thigh*Rq4*P_shank*Rq5);
T_5_h=simplify(inv(T_h_5)) % for q1 q3 q2

T_h_2=simplify(Rq3*R_omega*Rq1*Rq2);
T_2_h=simplify(inv(T_h_2)) % for q1 q3 q2

break
%%
syms alpha_a beta_a gama_a
R_a_x=[1 0 0 0;
       0 cos(alpha_a) -sin(alpha_a) 0;
       0 sin(alpha_a) cos(alpha_a) 0;
       0 0 0 1];
   
R_a_y=[cos(beta_a) 0 sin(beta_a) 0;
       0 1 0 0;
       -sin(beta_a) 0 cos(beta_a) 0;
       0 0 0 1];

R_p_z=[cos(gama_a) -sin(gama_a) 0 0;
       sin(gama_a) cos(gama_a) 0 0;
       0 0 1 0;
       0 0 0 1];

R_0_foot=R_a_y*R_p_z*R_a_x