clear all
clc
syms q1 q2 q3 L_h_x L_h_y L_h_z L_sh_x L_sh_y L_sh_z L_th_x L_th_y L_th_z L_b W_b
syms alpha_b beta_b gama_b 
syms x_b y_b z_b 
r_b=[x_b y_b z_b]';
syms x_e y_e z_e
%% Rotation Matrix  
Rq1 = [1 0 0 0;
       0 cos(q1) -sin(q1) 0;
       0 sin(q1) cos(q1) 0;
       0 0 0 1];

Rq2 = [cos(q2) 0 sin(q2) 0;
       0 1 0 0;
       -sin(q2) 0 cos(q2) 0;
       0 0 0 1];
   
Rq3 = [cos(q3) 0 sin(q3) 0;
       0 1 0 0;
       -sin(q3) 0 cos(q3) 0;
       0 0 0 1];    

%% Translation Matrix
P_shank=[1 0 0 -L_sh_x;
         0 1 0 -L_sh_y;
         0 0 1 -L_sh_z;
         0 0 0 1];

P_thigh=[1 0 0 0;
         0 1 0 -L_th_y;
         0 0 1 -L_th_z;
         0 0 0 1];
     
P_hip=[1 0 0 -L_h_x;
       0 1 0 -L_h_y;
       0 0 1 0;
       0 0 0 1];  
%%
T_e_h=P_hip*Rq1*P_thigh*Rq2*P_shank*Rq3;
T_h_e=simplify(inv(T_e_h));
P_e=T_h_e(1:3,4);

q1= acos((P_e(2)-L_sh_y - L_th_y)/L_h_y); 
C=simplify((P_e(1))^2+(P_e(3))^2-(L_h_x^2 - L_h_y^2*cos(q1)^2 + L_h_y^2 + L_sh_x^2 + L_sh_z^2 + L_th_z^2 - 2*L_h_y*L_th_z*sin(q1)));
A=2*L_h_x*L_sh_x+2*L_sh_z*L_th_z-2*L_h_y*L_sh_z*sin(q1) ; 
B=2*L_h_x*L_sh_z-2*L_sh_x*L_th_z+2*L_h_y*L_sh_x*sin(q1) ;
q2=2*atan((A+sqrt(A^2+B^2-C^2))/(B-C));   %q2=2*atan((A-sqrt(A^2+B^2-C^2))/(-C+B));

C1=P_e(1);
A1=(-L_h_y*sin(q2 - q1))/2 - L_h_x*sin(q2) - L_th_z*cos(q2)- L_sh_z + (L_h_y*sin(q1 + q2))/2;
B1=(L_h_y*cos(q2 - q1))/2 + L_h_x*cos(q2) - L_th_z*sin(q2) + L_sh_x - (L_h_y*cos(q1 + q2))/2;
q3=2*atan((A1+sqrt(A1^2+B1^2-C1^2))/(B1-C1));   %q3=2*atan((A1-sqrt(A1^2+B1^2-C1^2))/(-C1+B1))
%%
X0 = [theta1, theta2, theta3, theta4];

%fsolve solves for the roots for the equation X-XDES
[X,FVAL,EXITFLAG] = fsolve('find_joint_angles',X0);
theta1 = X(1);
theta2 = X(2);
theta3 = X(3);
theta4 = X(4);
disp(['Exitflag after running fsolve = ', num2str(EXITFLAG) ]) %Tells if fsolve converged or not
               %1 means converged else not converged 