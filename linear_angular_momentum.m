function PH=linear_angular_momentum(P)
% size(P)
%% Input
% Task Space
p=P(1:18);
dp=P(19:36);
ddp=P(37:54);

r_p = p(1:3); % pelvis position
x_p = r_p(1);
y_p = r_p(2);
z_p = r_p(3);
q_p = p(4:6); % pelvis rotation
alpha_p = q_p(1);
beta_p = q_p(2);
gamma_p = q_p(3);

% Angle Joints
q=P(55:68); % Joints angles and velocity

% d.COM
v_=P(69:113);%1:45);
v_sh_fr=v_(1:3);
v_sh_fl=v_(4:6);
v_sh_hr=v_(7:9);
v_sh_hl=v_(10:12);
v_th_fr=v_(13:15);
v_th_fl=v_(16:18);
v_th_hr=v_(19:21);
v_th_hl=v_(22:24);
v_th_mid_hr=v_(25:27);
v_th_mid_hl=v_(28:30);
v_hip_fr=v_(31:33);
v_hip_fl=v_(34:36);
v_hip_hr=v_(37:39);
v_hip_hl=v_(40:42);
v_b=v_(43:45);


% Angular Velocity
w_=P(114:158);%46:96);
w_sh_fr=w_(1:3);
w_sh_fl=w_(4:6);
w_sh_hr=w_(7:9);
w_sh_hl=w_(10:12);
w_th_fr=w_(13:15);
w_th_fl=w_(16:18);
w_th_hr=w_(19:21);
w_th_hl=w_(22:24);
w_th_mid_hr=w_(25:27);
w_th_mid_hl=w_(28:30);
w_hip_fr=w_(31:33);
w_hip_fl=w_(34:36);
w_hip_hr=w_(37:39);
w_hip_hl=w_(40:42);
w_b=w_(43:45);

%% Global
global m_sh m_th_f m_th_h_mid m_th_h m_hip m_b
global J_sh_fr J_sh_fl J_sh_hr J_sh_hl J_th_fr J_th_fl J_th_hr J_th_hl J_th_mid_hr J_th_mid_hl J_hip_fr J_hip_fl J_hip_hr J_hip_hl J_b J_arm

%% Angle and Velocity of Joints
q_fr = q(1:3);
q_fl = q(4:6);
q_hr = q(7:10);
q_hl = q(11:14);

q1_fr=q_fr(1);q2_fr=q_fr(2);q3_fr=q_fr(3);
q1_fl=q_fl(1);q2_fl=q_fl(2);q3_fl=q_fl(3);
q1_hr=q_hr(1);q2_hr=q_hr(2);q3_hr=q_hr(3);q4_hr=q_hr(4);
q1_hl=q_hl(1);q2_hl=q_hl(2);q3_hl=q_hl(3);q4_hl=q_hl(4);

%% Rotation Matrix
% Pelvis
R_p_x =   rot(1,alpha_p,4);
R_p_y =   rot(2,beta_p,4);
R_p_z =   rot(3,gamma_p,4);
R_0_p=R_p_y*R_p_z*R_p_x; % Pelvis Rotation Matrix

R0 = R_0_p;
% Front Right
Rq1_fr = rot(1,q1_fr,4);
Rq2_fr = rot(2,q2_fr,4);
Rq3_fr = rot(2,q3_fr,4);

% Front Left
Rq1_fl = rot(1,q1_fl,4);
Rq2_fl = rot(2,q2_fl,4);
Rq3_fl = rot(2,q3_fl,4);

% Hind Right
Rq1_hr = rot(1,q1_hr,4);
Rq2_hr = rot(2,q2_hr,4);
Rq3_hr = rot(2,q3_hr,4);
Rq4_hr = rot(2,q4_hr,4);

% Hind Left
Rq1_hl = rot(1,q1_hl,4);
Rq2_hl = rot(2,q2_hl,4);
Rq3_hl = rot(2,q3_hl,4);
Rq4_hl = rot(2,q4_hl,4);


R0_fr = R0;
R1_fr = R0_fr*Rq1_fr; % Hip_z Rotation Matrix from pelvis
R2_fr = R1_fr*Rq2_fr; % Hip_x Rotation Matrix from pelvis
R3_fr = R2_fr*Rq3_fr; % Hip Rotation Matrix from pelvis


R0_fl = R0;
R1_fl = R0_fl*Rq1_fl;
R2_fl = R1_fl*Rq2_fl;
R3_fl = R2_fl*Rq3_fl;

R0_hr = R0;
R1_hr = R0_hr*Rq1_hr; % Hip_z Rotation Matrix from pelvis
R2_hr = R1_hr*Rq2_hr; % Hip_x Rotation Matrix from pelvis
R3_hr = R2_hr*Rq3_hr; % Hip Rotation Matrix from pelvis
R4_hr = R3_hr*Rq4_hr; % Hip Rotation Matrix from pelvis


R0_hl = R0;
R1_hl = R0_hl*Rq1_hl; % Hip_z Rotation Matrix from pelvis
R2_hl = R1_hl*Rq2_hl; % Hip_x Rotation Matrix from pelvis
R3_hl = R2_hl*Rq3_hl; % Hip Rotation Matrix from pelvis
R4_hl = R3_hl*Rq4_hl; % Hip Rotation Matrix from pelvis
%% Angular Velocity of Rotors
R_0_h_fr=R_0_p;
R_0_1_fr=R_0_h_fr*Rq1_fr; %hip
R_0_2_fr=R_0_1_fr*Rq2_fr; %hip universal
R_0_3_fr=R_0_2_fr*Rq3_fr; %thigh

R_0_h_fl=R_0_p;
R_0_1_fl=R_0_h_fl*Rq1_fl;
R_0_2_fl=R_0_1_fl*Rq2_fl;
R_0_3_fl=R_0_2_fl*Rq3_fl;

R_0_h_hr=R_0_p;
R_0_1_hr=R_0_h_hr*Rq1_hr; %hip
R_0_2_hr=R_0_1_hr*Rq2_hr; %hip universal
R_0_3_hr=R_0_2_hr*Rq3_hr; %thigh
R_0_4_hr=R_0_3_hr*Rq4_hr; %thigh

R_0_h_hl=R_0_p;
R_0_1_hl=R_0_h_hl*Rq1_hl;
R_0_2_hl=R_0_1_hl*Rq2_hl;
R_0_3_hl=R_0_2_hl*Rq3_hl;
R_0_4_hl=R_0_3_hl*Rq4_hl;

%%
m0=[m_b];
mr=[m_hip m_th_f m_sh m_hip m_th_f m_sh];
ml=[m_hip m_th_h m_th_h_mid m_sh m_hip m_th_h m_th_h_mid m_sh];

Vc0=[v_b];
Vc_r=[v_hip_fr v_th_fr v_sh_fr v_hip_fl v_th_fl v_sh_fl];  %
Vc_l=[v_hip_hr v_th_hr v_th_mid_hr v_sh_hr v_hip_hl v_th_hl v_th_mid_hl v_sh_hl];

J0=[J_b];
J_r=[J_hip_fr J_th_fr J_sh_fr J_hip_fl J_th_fl J_sh_fl];
J_l=[J_hip_hr J_th_hr J_th_mid_hr J_sh_hr J_hip_hl J_th_hl J_th_mid_hl J_sh_hl];

w00=[w_b];
wr0=[w_hip_fr w_th_fr w_sh_fr w_hip_fl w_th_fl w_sh_fl];
wl0=[w_hip_hr w_th_hr w_th_mid_hr w_sh_hr w_hip_hl w_th_hl w_th_mid_hl w_sh_hl];

R00=[R_0_p(1:3,1:3)];
R_r=[R_0_1_fr(1:3,1:3) R_0_2_fr(1:3,1:3)  R_0_3_fr(1:3,1:3) R_0_1_fl(1:3,1:3) R_0_2_fl(1:3,1:3) R_0_3_fl(1:3,1:3)];
R_l=[R_0_1_hr(1:3,1:3) R_0_2_hr(1:3,1:3)  R_0_3_hr(1:3,1:3)  R_0_4_hr(1:3,1:3)  R_0_1_hl(1:3,1:3) R_0_2_hl(1:3,1:3)  R_0_3_hl(1:3,1:3)  R_0_4_hl(1:3,1:3)];
%% Linear and Angular Momentum
i0=1;irl=6; irr=8;

P0=zeros(3,i0);
for j=1:i0
    P0(:,j)=m0(j)*Vc0(:,j);
end
Pr=zeros(3,irl);
Pl=zeros(3,irr);
for i=1:irl
    Pr(:,i)=mr(i)*Vc_r(:,i);
end
for i=1:irr
    Pl(:,i)=ml(i)*Vc_l(:,i);
end
P=[reshape(P0,3*i0,1);reshape(Pr,3*irl,1);reshape(Pl,3*irr,1)];


H0=zeros(3,i0);
for j=1:i0
    H0(:,j)=R00(:,3*j-2:3*j)*J0(:,3*j-2:3*j)*R00(:,3*j-2:3*j)'*w00(:,j);
end
Hr=zeros(3,irl);
Hl=zeros(3,irr);
for i=1:irl
    Hr(:,i)=R_r(:,3*i-2:3*i)*J_r(:,3*i-2:3*i)*R_r(:,3*i-2:3*i)'*wr0(:,i);
end
for i=1:irr
    Hl(:,i)=R_l(:,3*i-2:3*i)*J_l(:,3*i-2:3*i)*R_l(:,3*i-2:3*i)'*wl0(:,i);
end
H_body=[reshape(H0,3*i0,1);reshape(Hr,3*irl,1);reshape(Hl,3*irr,1)];

PH=[P;H_body];
end