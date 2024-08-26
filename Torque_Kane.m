function O=Torque_Kane(P)
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
r_fr = p(7:9); % Right ankle position
    x_fr = r_fr(1);
    y_fr = r_fr(2);
    z_fr = r_fr(3);
r_fl = p(10:12); % Left ankle position
    x_fl = r_fl(1);
    y_fl = r_fl(2);
    z_fl = r_fl(3);
r_hr = p(13:15); % Right ankle rotation
    x_hr = r_hr(1);
    y_hr = r_hr(2);
    z_hr = r_hr(3);
r_hl = p(16:18); % Left ankle rotation
    x_hl = r_hl(1);
    y_hl = r_hl(2);
    z_hl = r_hl(3);    

% Angle Joints
q=P(55:68); %1:14

% dPH  90*1
dPH=P(69:158);  % 
dP=reshape(dPH(1:45),3,15);    % linear momentum
dH_body=reshape(dPH(46:90),3,15);    % angular momentum
    
% Trajectory  19*3=57
v=P(159:215);

% r_b=v(1:3);
% r_shd_fr=v(4:6);
% r_shd_fl=v(7:9);
% r_shd_hr=v(10:12);
% r_shd_hl=v(13:15);
% r_hip_fr=v(16:18);
% r_hip_fl=v(19:21);
% r_hip_hr=v(22:24);
% r_hip_hl=v(25:27);
% r_knee_fr=v(28:30);
% r_knee_fl=v(31:33);
% r_knee_mid_hr=v(34:36);
% r_knee_mid_hl=v(37:39);
% r_knee_hr=v(40:42);
% r_knee_hl=v(43:45);
r_ankle_fr=v(46:48);
r_ankle_fl=v(49:51);
r_ankle_hr=v(52:54);
r_ankle_hl=v(55:57);
 
% Time
t=P(216);

clear p dp ddp P

%% Parameters
global Tc Td T_ac
global m_sh m_th_f m_th_h_mid m_th_h m_hip m_b
global g
global N

%%
run quad_properties
run quad_parameters
%% Extracting T
if or(t<=T_ac,t>(T_ac+N*2*Tc))
    T=t;
else
    T=rem((t-T_ac),2*Tc)+T_ac;
end
%% Angle of Joints
q_fr=q(1:3);q_fl=q(4:6);q_hr=q(7:10);q_hl=q(11:14);
q1_fr=q_fr(1);q2_fr=q_fr(2);q3_fr=q_fr(3);
q1_fl=q_fl(1);q2_fl=q_fl(2);q3_fl=q_fl(3);
q1_hr=q_hr(1);q2_hr=q_hr(2);q3_hr=q_hr(3);q4_hr=q_hr(4);
q1_hl=q_hl(1);q2_hl=q_hl(2);q3_hl=q_hl(3);q4_hl=q_hl(4);
%% Foot Corner Point

%% Inertia Force
F0=dP(:,1)+[m_b*g];
Fr=dP(:,2:7)+[m_hip*g m_th_f*g m_sh*g m_hip*g m_th_f*g m_sh*g];
Fl=dP(:,8:15)+[m_hip*g m_th_h*g m_th_h_mid*g m_sh*g m_hip*g m_th_h*g m_th_h_mid*g m_sh*g];
%% Inertia Moment    
M0=dH_body(:,1);
Mr=dH_body(:,2:7);
Ml=dH_body(:,8:15);
%% Kane Terms
run JJ_Vc
run JJ_wc
run BB
run JJ_e_fr
run JJ_e_fl
run JJ_e_hr
run JJ_e_hl

%% Left Terms
J_Vc=reshape(J_Vc,3,20*15);
J_wc=reshape(J_wc,3,20*15);

O0=zeros(20,1);Or=zeros(20,1);Ol=zeros(20,1);

J_Vc0=J_Vc(:,1:1*20);
J_Vcr=J_Vc(:,1*20+1:7*20);
J_Vcl=J_Vc(:,7*20+1:15*20);

J_w00=J_wc(:,1:1*20);
J_wr0=J_wc(:,1*20+1:7*20);
J_wl0=J_wc(:,7*20+1:15*20);

for j=1:1
    O0=O0+J_Vc0(:,20*(j-1)+1:20*j)'*F0(:,j)+...
          J_w00(:,20*(j-1)+1:20*j)'*M0(:,j);
end
for i=1:6
    Or=Or+J_Vcr(:,20*(i-1)+1:20*i)'*Fr(:,i)+...
          J_wr0(:,20*(i-1)+1:20*i)'*Mr(:,i);
end
for i=1:8
    Ol=Ol+J_Vcl(:,20*(i-1)+1:20*i)'*Fl(:,i)+...
          J_wl0(:,20*(i-1)+1:20*i)'*Ml(:,i);
end
Left=O0+Or+Ol; 

%% Right Terms
B=reshape(B,20,14);

J_e_fr=reshape(J_e_fr,3,20);
J_e_fl=reshape(J_e_fl,3,20);
J_e_hr=reshape(J_e_hr,3,20);
J_e_hl=reshape(J_e_hl,3,20);

%% Actuator Torque & Reaction Force and Moment        
% if T<=T_ac_a_a
%     p_i=1; % 2 leg
% elseif and(T>=T_ac_a_a,T<=T_ac)
%     p_i=2; % R leg
if and(T>=T_ac,T<=(Td+T_ac))   
    p_i=1; % 2 leg
elseif and(T>=(Td+T_ac),T<=(Tc+T_ac))   
    p_i=3;    % HL/FR legs (Swing phase)
elseif and(T>=(Tc+T_ac),T<=(Tc+Td+T_ac))   
    p_i=1;  % 2 leg
elseif and(T>=(Tc+Td+T_ac),T<=(2*Tc+T_ac))
    p_i=2;  % HR/FL legs (Swing phase)
% elseif and(T>=(T_ac+N*2*Tc),T<(T_ac+N*2*Tc+T_dc_a_a))    
%     p_i=1;  % 2 leg
% elseif and(T>=(T_ac+N*2*Tc+T_dc_a_a),T<=(T_ac+N*2*Tc+T_dc_a_c))
%     p_i=3;  % L leg
% elseif T>=(T_ac+N*2*Tc+T_dc_a_c)    
%     p_i=1;   % 2 leg
end


if p_i==1
    % 2 leg
    J_DSP=[B...
           J_e_fr' J_e_fl' J_e_hr' J_e_hl'];
    TF=pinv(J_DSP)*Left;
%     size(TF)
    
    Tau_r=TF(1:6);
    Tau_l=TF(7:14);

    F_fr=TF(15:17);
    F_fl=TF(18:20);
    F_hr=TF(21:23);
    F_hl=TF(24:26);

       
elseif p_i==2
    % HR/FL legs (Swing phase)
    J_SSP=[B J_e_fr' J_e_hl']; 
    TF=pinv(J_SSP)*Left;
%     size(TF)

    Tau_r=TF(1:6);
    Tau_l=TF(7:14);

    F_fl=[0 0 0]';
    F_hr=[0 0 0]';

    F_fr=TF(15:17);
    F_hl=TF(18:20);
        
elseif p_i==3
    % HL/FR legs (Swing phase)
    J_SSP=[B J_e_fl' J_e_hr']; 
    TF=pinv(J_SSP)*Left;
%     size(TF)

    Tau_r=TF(1:6);
    Tau_l=TF(7:14);

    F_fl=TF(15:17);
    F_hr=TF(18:20);
    
    F_fr=[0 0 0]';
    F_hl=[0 0 0]';

end

%% Output
O=[Tau_r;Tau_l;F_fr;F_fl;F_hr;F_hl];
end