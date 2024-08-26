%% Dynamic_Equation_3D
clear all
close all
clc
%% Parameters Description
syms x_p y_p z_p dx_p dy_p dz_p ddx_p ddy_p ddz_p real
syms beta_p alpha_p gama_p dbeta_p dalpha_p dgama_p ddbeta_p ddalpha_p ddgama_p real
syms q1_r q2_r q3_r q4_r q5_r q6_r dq1_r dq2_r dq3_r dq4_r dq5_r dq6_r ddq1_r ddq2_r ddq3_r ddq4_r ddq5_r ddq6_r real
syms q1_l q2_l q3_l q4_l q5_l q6_l dq1_l dq2_l dq3_l dq4_l dq5_l dq6_l ddq1_l ddq2_l ddq3_l ddq4_l ddq5_l ddq6_l real
syms q_tr_roll dq_tr_roll ddq_tr_roll real
syms q_tr_yaw dq_tr_yaw ddq_tr_yaw real

syms tau1_r tau2_r tau3_r tau4_r tau5_r tau6_r real
syms tau1_l tau2_l tau3_l tau4_l tau5_l tau6_l real
syms tau_tr_roll tau_tr_yaw real
tau_r=[tau1_r tau2_r tau3_r tau4_r tau5_r tau6_r]';
tau_l=[tau6_l tau5_l tau4_l tau3_l tau2_l tau1_l]';
tau_tr=[tau_tr_roll tau_tr_yaw]';

run biped_properties
clear la L_sh L_th L_pl L_ws L_tr L_inth m_f m_unia m_sh m_th m_unih m_hip m_pl m_obj m_tr m_ws omega
syms la L_sh L_th L_pl L_ws L_tr L_inth real
syms m_f m_unia m_sh m_th m_unih m_hip m_pl m_obj m_tr m_ws real
syms omega real

global d_f_r d_f_l d_unia_r d_unia_l d_sh_r d_sh_l d_th_r d_th_l d_unih_r d_unih_l d_hip_r d_hip_l d_pl d_obj d_tr d_ws
global J_f_r J_f_l J_unia_r J_unia_l J_sh_r J_sh_l J_th_r J_th_l J_unih_r J_unih_l J_hip_r J_hip_l J_pl J_obj J_tr J_ws
global g

s_inth_r=[0;0;-L_inth];
s_inth_l=[0;0;-L_inth];
m0=[m_pl m_ws m_tr m_obj];
mr=[m_hip m_unih m_th m_sh m_unia m_f];
ml=[m_hip m_unih m_th m_sh m_unia m_f];
%% Rotation Matrix
% R3,R2,R1,T1,R4,T2,R6,R5
% z,x,y,-dz,y,-dz,y,x

% Pelvis 
R_omega = [1 0 0 0;
           0 cos(omega) -sin(omega) 0;
           0 sin(omega) cos(omega) 0;
           0 0 0 1];
       
R_p_x=[1 0 0 0;
       0 cos(alpha_p) -sin(alpha_p) 0;
       0 sin(alpha_p) cos(alpha_p) 0;
       0 0 0 1];  
   
R_p_y=[cos(beta_p) 0 sin(beta_p) 0;
       0 1 0 0;
       -sin(beta_p) 0 cos(beta_p) 0;
       0 0 0 1];
   
R_p_z=[cos(gama_p) -sin(gama_p) 0 0;
       sin(gama_p) cos(gama_p) 0 0;
       0 0 1 0
       0 0 0 1];
  
R_0_p=R_p_y*R_p_z*R_p_x;
 
% Right
Rq1_r=[1 0 0 0;
       0 cos(q1_r) -sin(q1_r) 0;
       0 sin(q1_r) cos(q1_r) 0;
       0 0 0 1];

Rq2_r=[cos(q2_r) 0 sin(q2_r) 0;
       0 1 0 0;
       -sin(q2_r) 0 cos(q2_r) 0;
       0 0 0 1];

Rq3_r=[cos(q3_r) -sin(q3_r) 0 0;
       sin(q3_r) cos(q3_r) 0 0;
       0 0 1 0;
       0 0 0 1];
     
Rq4_r=[cos(q4_r) 0 sin(q4_r) 0;
       0 1 0 0;
       -sin(q4_r) 0 cos(q4_r) 0;
       0 0 0 1];
     
Rq5_r=[1 0 0 0;
       0 cos(q5_r) -sin(q5_r) 0;
       0 sin(q5_r) cos(q5_r) 0;
       0 0 0 1];

Rq6_r=[cos(q6_r) 0 sin(q6_r) 0;
       0 1 0 0;
       -sin(q6_r) 0 cos(q6_r) 0;
       0 0 0 1];
% Left    
Rq1_l=[1 0 0 0;
       0 cos(q1_l) -sin(q1_l) 0;
       0 sin(q1_l) cos(q1_l) 0;
       0 0 0 1];

Rq2_l=[cos(q2_l) 0 sin(q2_l) 0;
       0 1 0 0;
       -sin(q2_l) 0 cos(q2_l) 0;
       0 0 0 1];

Rq3_l=[cos(q3_l) -sin(q3_l) 0 0;
       sin(q3_l) cos(q3_l) 0 0;
       0 0 1 0;
       0 0 0 1];

Rq4_l=[cos(q4_l) 0 sin(q4_l) 0;
       0 1 0 0;
       -sin(q4_l) 0 cos(q4_l) 0;
       0 0 0 1];

Rq5_l=[1 0 0 0;
       0 cos(q5_l) -sin(q5_l) 0;
       0 sin(q5_l) cos(q5_l) 0;
       0 0 0 1];

Rq6_l=[cos(q6_l) 0 sin(q6_l) 0;
       0 1 0 0;
       -sin(q6_l) 0 cos(q6_l) 0;
       0 0 0 1];
   
% Trunk
Rq_tr_roll=[1 0 0 0;
            0 cos(q_tr_roll) -sin(q_tr_roll) 0;
            0 sin(q_tr_roll) cos(q_tr_roll) 0;
            0 0 0 1]; 
   
Rq_tr_yaw=[cos(q_tr_yaw) -sin(q_tr_yaw) 0 0;
            sin(q_tr_yaw) cos(q_tr_yaw) 0 0;
            0 0 1 0;
            0 0 0 1];
Rq_tr=Rq_tr_roll*Rq_tr_yaw;

R0=R_0_p;
R1_r=Rq3_r;
R2_r=R_omega*Rq1_r;
R3_r=Rq2_r;
R4_r=Rq4_r;
R5_r=Rq5_r; % modified
R6_r=Rq6_r; % modified

R1_l=Rq3_l;
R2_l=inv(R_omega)*Rq1_l;
R3_l=Rq2_l;
R4_l=Rq4_l;
R5_l=Rq5_l; % modified
R6_l=Rq6_l; % modified

R_tr=Rq_tr;
%% Translation Matrix
% Trunk
P_p=[1 0 0 x_p;
     0 1 0 y_p;
     0 0 1 z_p;
     0 0 0 1];
 
P_pl=[1 0 0 d_pl(1);
      0 1 0 d_pl(2);
      0 0 1 d_pl(3);
      0 0 0 1];
  
P_ws=[1 0 0 d_ws(1);
      0 1 0 d_ws(2);
      0 0 1 d_ws(3);
      0 0 0 1];
  
P_waist=[1 0 0 -L_ws;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
     
P_head=[1 0 0 0;
      0 1 0 0;
      0 0 1 L_tr;
      0 0 0 1];

P_obj=[1 0 0 d_obj(1);
      0 1 0 d_obj(2);
      0 0 1 d_obj(3);
      0 0 0 1];
  
P_tr=[1 0 0 d_tr(1);
      0 1 0 d_tr(2);
      0 0 1 d_tr(3);
      0 0 0 1];
  
% Right Leg  
P_h_r=[1 0 0 0;
       0 1 0 -0.5*L_pl;
       0 0 1 0;
       0 0 0 1];
   
T_h_r=inv(R_omega)*P_h_r;

P_inth_r=[1 0 0 s_inth_r(1);
          0 1 0 s_inth_r(2);
          0 0 1 s_inth_r(3);
          0 0 0 1];
   
P_hip_r=[1 0 0 d_hip_r(1);
         0 1 0 d_hip_r(2);
         0 0 1 d_hip_r(3);
         0 0 0 1];

P_unih_r=[1 0 0 d_unih_r(1);
          0 1 0 d_unih_r(2);
          0 0 1 d_unih_r(3);
          0 0 0 1];
    
P_th_r=[1 0 0 d_th_r(1);
        0 1 0 d_th_r(2);
        0 0 1 d_th_r(3);
        0 0 0 1];
   
P_knee_r=[1 0 0 0;
          0 1 0 0;
          0 0 1 -L_th;
          0 0 0 1];

P_sh_r=[1 0 0 d_sh_r(1);
        0 1 0 d_sh_r(2);
        0 0 1 d_sh_r(3);
        0 0 0 1];

P_ankle_r=[1 0 0 0;
           0 1 0 0;
           0 0 1 -L_sh;
           0 0 0 1];
       
P_unia_r=[1 0 0 d_unia_r(1);
          0 1 0 d_unia_r(2);
          0 0 1 d_unia_r(3);
          0 0 0 1];
      
P_foot_r=[1 0 0 d_f_r(1);
          0 1 0 d_f_r(2);
          0 0 1 d_f_r(3);
          0 0 0 1];
      
P_s_r=[1 0 0 0;
       0 1 0 0;
       0 0 1 -la;
       0 0 0 1];
   
% Left Leg 
P_h_l=[1 0 0 0;
       0 1 0 0.5*L_pl;
       0 0 1 0;
       0 0 0 1];
   
T_h_l=R_omega*P_h_l;

P_inth_l=[1 0 0 s_inth_l(1);
          0 1 0 s_inth_l(2);
          0 0 1 s_inth_l(3);
          0 0 0 1];
   
P_hip_l=[1 0 0 d_hip_l(1);
         0 1 0 d_hip_l(2);
         0 0 1 d_hip_l(3);
         0 0 0 1];

P_unih_l=[1 0 0 d_unih_l(1);
          0 1 0 d_unih_l(2);
          0 0 1 d_unih_l(3);
          0 0 0 1];
    
P_th_l=[1 0 0 d_th_l(1);
        0 1 0 d_th_l(2);
        0 0 1 d_th_l(3);
        0 0 0 1];
   
P_knee_l=[1 0 0 0;
          0 1 0 0;
          0 0 1 -L_th;
          0 0 0 1];

P_sh_l=[1 0 0 d_sh_l(1);
        0 1 0 d_sh_l(2);
        0 0 1 d_sh_l(3);
        0 0 0 1];

P_ankle_l=[1 0 0 0;
           0 1 0 0;
           0 0 1 -L_sh;
           0 0 0 1];
       
P_unia_l=[1 0 0 d_unia_l(1);
          0 1 0 d_unia_l(2);
          0 0 1 d_unia_l(3);
          0 0 0 1];
      
P_foot_l=[1 0 0 d_f_l(1);
          0 1 0 d_f_l(2);
          0 0 1 d_f_l(3);
          0 0 0 1];
      
P_s_l=[1 0 0 0;
       0 1 0 0;
       0 0 1 -la;
       0 0 0 1];  
%% Center of Mass
r_pl=P_p*R0*P_pl*[0;0;0;1];
r_ws=P_p*R0*Rq_tr_roll*P_ws*[0;0;0;1];
r_tr=P_p*R0*Rq_tr_roll*P_waist*Rq_tr_yaw*P_tr*[0;0;0;1];
r_obj=P_p*R0*Rq_tr_roll*P_waist*Rq_tr_yaw*P_obj*[0;0;0;1];

r_hip_r=P_p*R0*T_h_r*R1_r*P_inth_r*P_hip_r*[0;0;0;1];
r_unih_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*P_unih_r*[0;0;0;1];
r_th_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*R3_r*P_th_r*[0;0;0;1];

r_sh_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*R3_r*P_knee_r*R4_r*P_sh_r*[0;0;0;1];

r_unia_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*R3_r*P_knee_r*R4_r*P_ankle_r*R5_r*P_unia_r*[0;0;0;1];
r_foot_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*R3_r*P_knee_r*R4_r*P_ankle_r*R5_r*R6_r*P_foot_r*[0;0;0;1];
r_s_r=P_p*R0*T_h_r*R1_r*P_inth_r*R2_r*R3_r*P_knee_r*R4_r*P_ankle_r*R5_r*R6_r*P_s_r*[0;0;0;1];

r_hip_l=P_p*R0*T_h_l*R1_l*P_inth_l*P_hip_l*[0;0;0;1];
r_unih_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*P_unih_l*[0;0;0;1];
r_th_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*R3_l*P_th_l*[0;0;0;1];

r_sh_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*R3_l*P_knee_l*R4_l*P_sh_l*[0;0;0;1];

r_unia_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*R3_l*P_knee_l*R4_l*P_ankle_l*R5_l*P_unia_l*[0;0;0;1];
r_foot_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*R3_l*P_knee_l*R4_l*P_ankle_l*R5_l*R6_l*P_foot_l*[0;0;0;1];
r_s_l=P_p*R0*T_h_l*R1_l*P_inth_l*R2_l*R3_l*P_knee_l*R4_l*P_ankle_l*R5_l*R6_l*P_s_l*[0;0;0;1];

rc0=[r_pl(1:3) r_ws(1:3) r_tr(1:3) r_obj(1:3)];
rcr=[r_hip_r(1:3) r_unih_r(1:3) r_th_r(1:3) r_sh_r(1:3) r_unia_r(1:3) r_foot_r(1:3)];
rcl=[r_hip_l(1:3) r_unih_l(1:3) r_th_l(1:3) r_sh_l(1:3) r_unia_l(1:3) r_foot_l(1:3)];
%% Center of Mass Velocity
q=[x_p y_p z_p alpha_p beta_p gama_p q1_r q2_r q3_r q4_r q5_r q6_r q1_l q2_l q3_l q4_l q5_l q6_l q_tr_roll q_tr_yaw]';
dq=[dx_p dy_p dz_p dalpha_p dbeta_p dgama_p dq1_r dq2_r dq3_r dq4_r dq5_r dq6_r dq1_l dq2_l dq3_l dq4_l dq5_l dq6_l dq_tr_roll dq_tr_yaw]';
ddq=[ddx_p ddy_p ddz_p ddalpha_p ddbeta_p ddgama_p ddq1_r ddq2_r ddq3_r ddq4_r ddq5_r ddq6_r ddq1_l ddq2_l ddq3_l ddq4_l ddq5_l ddq6_l ddq_tr_roll ddq_tr_yaw]';

for j=1:4
Vc0(:,j)=jacobian(rc0(:,j),q)*dq;
end

for i=1:6
Vcr(:,i)=jacobian(rcr(:,i),q)*dq;
Vcl(:,i)=jacobian(rcl(:,i),q)*dq;
end

Vc=[Vc0 Vcr Vcl];
%% Angular Velocity
R_0_p; %pelvis
R_0_ws=R_0_p*Rq_tr_roll;

R_0_h_r=R_0_p*inv(R_omega);
R_0_1_r=R_0_h_r*Rq3_r; %hip
R_0_2_r=R_0_1_r*R_omega*Rq1_r; %hip universal
R_0_3_r=R_0_2_r*Rq2_r; %thigh
R_0_4_r=R_0_3_r*Rq4_r; %shank
R_0_5_r=R_0_4_r*Rq5_r; % modified %ankle universal
R_0_6_r=R_0_5_r*Rq6_r; % modified %foot

R_0_h_l=R_0_p*R_omega;
R_0_1_l=R_0_h_l*Rq3_l;
R_0_2_l=R_0_1_l*inv(R_omega)*Rq1_l;
R_0_3_l=R_0_2_l*Rq2_l;
R_0_4_l=R_0_3_l*Rq4_l;
R_0_5_l=R_0_4_l*Rq5_l; % modified
R_0_6_l=R_0_5_l*Rq6_l; % modified

R_0_tr=R_0_p*Rq_tr;
R_0_obj=R_0_tr;

w_pl=[0;dbeta_p;0]+R_p_y(1:3,1:3)*[0;0;dgama_p]+R_p_y(1:3,1:3)*R_p_z(1:3,1:3)*[dalpha_p;0;0];
w_ws=w_pl+R_0_p(1:3,1:3)*[dq_tr_roll;0;0];
w_tr=w_pl+R_0_p(1:3,1:3)*[dq_tr_roll;0;0]+R_0_p(1:3,1:3)*Rq_tr_roll(1:3,1:3)*[0;0;dq_tr_yaw];
w_obj=w_tr;

w_hip_r=w_pl+R_0_h_r(1:3,1:3)*[0;0;dq3_r];
w_unih_r=w_hip_r+R_0_1_r(1:3,1:3)*[dq1_r;0;0];
w_th_r=w_unih_r+R_0_2_r(1:3,1:3)*[0;dq2_r;0];
w_sh_r=w_th_r+R_0_3_r(1:3,1:3)*[0;dq4_r;0];
w_unia_r=w_sh_r+R_0_4_r(1:3,1:3)*[dq5_r;0;0]; % modified
w_foot_r=w_unia_r+R_0_5_r(1:3,1:3)*[0;dq6_r;0]; % modified
w_s_r=w_unia_r+R_0_5_r(1:3,1:3)*[0;dq6_r;0]; % modified

w_hip_l=w_pl+R_0_h_l(1:3,1:3)*[0;0;dq3_l];
w_unih_l=w_hip_l+R_0_1_l(1:3,1:3)*[dq1_l;0;0];
w_th_l=w_unih_l+R_0_2_l(1:3,1:3)*[0;dq2_l;0];
w_sh_l=w_th_l+R_0_3_l(1:3,1:3)*[0;dq4_l;0];
w_unia_l=w_sh_l+R_0_4_l(1:3,1:3)*[dq5_l;0;0]; % modified
w_foot_l=w_unia_l+R_0_5_l(1:3,1:3)*[0;dq6_l;0]; % modified
w_s_l=w_unia_l+R_0_5_l(1:3,1:3)*[0;dq6_l;0]; % modified

w00=[w_pl w_ws w_tr w_obj];
wr0=[w_hip_r w_unih_r w_th_r w_sh_r w_unia_r w_foot_r];
wl0=[w_hip_l w_unih_l w_th_l w_sh_l w_unia_l w_foot_l];

w_body_0=[w00 wr0 wl0];
%% Inertia
J0=[J_pl J_ws J_tr J_obj];
Jr=[J_hip_r J_unih_r J_th_r J_sh_r J_unia_r J_f_r];
Jl=[J_hip_l J_unih_l J_th_l J_sh_l J_unia_l J_f_l];

R00=[R_0_p(1:3,1:3) R_0_ws(1:3,1:3) R_0_tr(1:3,1:3) R_0_obj(1:3,1:3)];
Rr=[R_0_1_r(1:3,1:3) R_0_2_r(1:3,1:3) R_0_3_r(1:3,1:3) R_0_4_r(1:3,1:3) R_0_5_r(1:3,1:3) R_0_6_r(1:3,1:3)];
Rl=[R_0_1_l(1:3,1:3) R_0_2_l(1:3,1:3) R_0_3_l(1:3,1:3) R_0_4_l(1:3,1:3) R_0_5_l(1:3,1:3) R_0_6_l(1:3,1:3)];
%% Kinematic & Potentioal Energy
for j=1:4
    
    K0(j)=0.5*(m0(j)*(Vc0(:,j))'*Vc0(:,j)+...
               w00(:,j)'*R00(:,3*j-2:3*j)*J0(:,3*j-2:3*j)*R00(:,3*j-2:3*j)'*w00(:,j));
    P0(j)=m0(j)*g'*rc0(:,j);
    
end

for i=1:6
    
    Kr(i)=0.5*(mr(i)*(Vcr(:,i))'*Vcr(:,i)+wr0(:,i)'*Rr(:,3*i-2:3*i)*Jr(:,3*i-2:3*i)*Rr(:,3*i-2:3*i)'*wr0(:,i));
    Kl(i)=0.5*(ml(i)*(Vcl(:,i))'*Vcl(:,i)+wl0(:,i)'*Rl(:,3*i-2:3*i)*Jl(:,3*i-2:3*i)*Rl(:,3*i-2:3*i)'*wl0(:,i));
    
    Pr(i)=mr(i)*g'*rcr(:,i);
    Pl(i)=ml(i)*g'*rcl(:,i);
end
K=sum(K0)+sum(Kr+Kl);
P=sum(P0)+sum(Pr+Pl);
%% Clear Unnecessary Terms
clear K0 Kr Kl P0 Pr Pl
clear J0 Jr Jl Rr Rl
clear w00 wr0 wl0
clear w_pelvis w_ws w_tr w_hip_r w_unih_r w_th_r w_sh_r w_unia_r w_foot_r w_hip_l w_unih_l w_th_l w_sh_l w_unia_l w_foot_l
clear Vc0 Vcr Vcl
clear rc0 rcr rcl
clear r_ws r_tr r_hip_r r_unih_r r_th_r r_sh_r r_unia_r r_foot_r r_hip_l r_unih_l r_th_l r_sh_l r_unia_l r_foot_l
clear P_p P_ws P_h_r P_inth_r P_knee_r P_ankle_r P_foot_r P_h_l P_inth_l P_knee_l P_ankle_l P_foot_l
clear R_0_p Rq1_r Rq2_r Rq3_r Rq4_r Rq5_r Rq6_r Rq1_l Rq2_l Rq3_l Rq4_l Rq5_l Rq6_l
clear R0 R1_r R2_r R3_r R4_r R5_r R6_r R1_l R2_l R3_l R4_l R5_l R6_l
clear J_f_r J_f_l J_unia_r J_unia_l J_sh_r J_sh_l J_th_r J_th_l J_unih_r J_unih_l J_hip_r J_hip_l J_tr J_ws
clear d_f_r d_f_l d_unia_r d_unia_l d_sh_r d_sh_l d_th_r d_th_l d_unih_r d_unih_l d_hip_r d_hip_l d_tr d_ws
clear m mr ml
clear s_inth_r s_inth_l
%% Lagrang Terms
L=K-P;
Ldq=jacobian(L,dq);
dLdq=jacobian(Ldq,[q;dq])*[dq;ddq];
Lq=jacobian(L,q)';
Left=dLdq-Lq;

Q0=zeros(20,1);Qr=zeros(20,1);Ql=zeros(20,1);

for j=1:2
    Q0=Q0+jacobian(dq(j+18),dq)'.*tau_tr(j);
end
for i=1:6
    Qr=Qr+jacobian(dq(i+6),dq)'.*tau_r(i);
    Ql=Ql+jacobian(dq(i+12),dq)'.*tau_l(i);
end
Right=Q0+Qr+Ql;
%% Clear Unnecessary Terms
clear L Lq Ldq dLdq
%% Left Terms
clc
diary('Left_L1')
Lag1=Left(1)
diary off
clear Lag1

clc
diary('Left_L2')
Lag2=Left(2)
diary off
clear Lag2

clc
diary('Left_L3')
Lag3=Left(3)
diary off
clear Lag3

clc
diary('Left_L4')
Lag4=Left(4)
diary off
clear Lag4

clc
diary('Left_L5')
Lag5=Left(5)
diary off
clear Lag5

clc
diary('Left_L6')
Lag6=Left(6)
diary off
clear Lag6

clc
diary('Left_L7')
Lag7=Left(7)
diary off
clear Lag7

clc
diary('Left_L8')
Lag8=Left(8)
diary off
clear Lag8

clc
diary('Left_L9')
Lag9=Left(9)
diary off
clear Lag9

clc
diary('Left_L10')
Lag10=Left(10)
diary off
clear Lag10

clc
diary('Left_L11')
Lag11=Left(11)
diary off
clear Lag11

clc
diary('Left_L12')
Lag12=Left(12)
diary off
clear Lag12

clc
diary('Left_L13')
Lag13=Left(13)
diary off
clear Lag13

clc
diary('Left_L14')
Lag14=Left(14)
diary off
clear Lag14

clc
diary('Left_L15')
Lag15=Left(15)
diary off
clear Lag15

clc
diary('Left_L16')
Lag16=Left(16)
diary off
clear Lag16

clc
diary('Left_L17')
Lag17=Left(17)
diary off
clear Lag17

clc
diary('Left_L18')
Lag18=Left(18)
diary off
clear Lag18

clc
diary('Left_L19')
Lag19=Left(19)
diary off
clear Lag19

clc
diary('Left_L20')
Lag20=Left(20)
diary off
clear Lag20