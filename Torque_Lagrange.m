function O=Torque_Lagrange(P)
%% Input

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
dq=P(69:82);
ddq=P(83:96);

r= P(97:165); 

t=P(end);

run biped_properties
%% Parameters
global Tc Td T_ac
global m_sh m_th_f m_th_h_mid m_th_h m_hip m_b
global g
global N
if or(t<=T_ac,t>(T_ac+N*2*Tc))
    T=t;
else
    T=rem((t-T_ac),2*Tc)+T_ac;
end
%% q & dq & ddq
q_f=q(1:6);q_h=q(7:14);
dq_f=dq(1:6);dq_h=dq(7:14);
ddq_f=ddq(1:6);ddq_h=ddq(7:14);

q1_fr=q_f(1);q2_fr=q_f(2);q3_fr=q_f(3);q1_fl=q_f(4);q2_fl=q_f(5);q3_fl=q_f(6);
q1_hr=q_h(1);q2_hr=q_h(2);q3_hr=q_h(3);q4_hr=q_h(4);q1_hl=q_h(5);q2_hl=q_h(6);q3_hl=q_h(7);q4_hl=q_h(8);

dq1_fr=dq_f(1);dq2_fr=dq_f(2);dq3_fr=dq_f(3);dq1_fl=dq_f(4);dq2_fl=dq_f(5);dq3_fl=dq_f(6);
dq1_hr=dq_h(1);dq2_hr=dq_h(2);dq3_hr=dq_h(3);dq4_hr=dq_h(4);dq1_hl=dq_h(5);dq2_hl=dq_h(6);dq3_hl=dq_h(7);dq4_hl=dq_h(8);


ddq1_fr=ddq_f(1);ddq2_fr=ddq_f(2);ddq3_fr=ddq_f(3);ddq1_fl=ddq_f(4);ddq2_fl=ddq_f(5);ddq3_fl=ddq_f(6);
ddq1_hr=ddq_h(1);ddq2_hr=ddq_h(2);ddq3_hr=ddq_h(3);ddq4_hr=ddq_h(4);ddq1_hl=ddq_h(5);ddq2_hl=ddq_h(6);ddq3_hl=ddq_h(7);ddq4_hl=ddq_h(8);

%% Lagrange Terms

run Left_L1
run Left_L2
run Left_L3
run Left_L4
run Left_L5
run Left_L6
run Left_L7
run Left_L8
run Left_L9
run Left_L10
run Left_L11
run Left_L12
run Left_L13
run Left_L14
run Left_L15
run Left_L16
run Left_L17
run Left_L18
run Left_L19
run Left_L20

run BB
run JJ_a_r
run JJ_b_r
run JJ_c_r
run JJ_d_r
run JJ_a_l
run JJ_b_l
run JJ_c_l
run JJ_d_l

%% Left Term   
Left=[Lag1 Lag2 Lag3 Lag4 Lag5 Lag6 Lag7 Lag8 Lag9 Lag10 Lag11 Lag12 Lag13 Lag14 Lag15 Lag16 Lag17 Lag18 Lag19 Lag20]';
%% Right Term
B=reshape(B,20,14);

J_a_r=reshape(J_a_r,3,20);
J_b_r=reshape(J_b_r,3,20);
J_c_r=reshape(J_c_r,3,20);
J_d_r=reshape(J_d_r,3,20);

J_a_l=reshape(J_a_l,3,20);
J_b_l=reshape(J_b_l,3,20);
J_c_l=reshape(J_c_l,3,20);
J_d_l=reshape(J_d_l,3,20);
%% Actuator Torque & Reaction Force and Moment
if and(t>=0,t<T_st_a_a)
    % 2 leg
    J_DSP=[B...
           J_a_l' J_b_l' J_c_l' J_d_l'...
           J_a_r' J_b_r' J_c_r' J_d_r'];
    TF=pinv(J_DSP)*Left;
    
    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=TF(27:29);
    Fb_r=TF(30:32);
    Fc_r=TF(33:35);
    Fd_r=TF(36:38);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
elseif and(t>=T_st_a_a,t<T_st)
    % R leg
    J_SSP=[B J_a_r' J_b_r' J_c_r' J_d_r']; 
    TF=pinv(J_SSP)*Left;


    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=[0 0 0]';
    Fb_l=[0 0 0]';
    Fc_l=[0 0 0]';
    Fd_l=[0 0 0]';

    Fa_r=TF(15:17);
    Fb_r=TF(18:20);
    Fc_r=TF(21:23);
    Fd_r=TF(24:26);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
elseif and(t>=T_st,t<(T_st+Td))
    % 2 leg    
    J_DSP=[B...
           J_a_l' J_b_l' J_c_l' J_d_l'...
           J_a_r' J_b_r' J_c_r' J_d_r'];
    TF=pinv(J_DSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=TF(27:29);
    Fb_r=TF(30:32);
    Fc_r=TF(33:35);
    Fd_r=TF(36:38);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);

elseif and(t>=(T_st+Td),t<(T_st+Tc))
    % L leg
    J_SSP=[B J_a_l' J_b_l' J_c_l' J_d_l']; 
    TF=pinv(J_SSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=[0 0 0]';
    Fb_r=[0 0 0]';
    Fc_r=[0 0 0]';
    Fd_r=[0 0 0]';

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);

elseif and(t>=(T_st+Tc),t<(T_st+Td+Tc))
    % 2 leg
    J_DSP=[B...
           J_a_l' J_b_l' J_c_l' J_d_l'...
           J_a_r' J_b_r' J_c_r' J_d_r'];
    TF=pinv(J_DSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=TF(27:29);
    Fb_r=TF(30:32);
    Fc_r=TF(33:35);
    Fd_r=TF(36:38);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);

elseif and(t>=(T_st+Td+Tc),t<=(T_st+2*Tc))
    % R leg
    J_SSP=[B J_a_r' J_b_r' J_c_r' J_d_r']; 
    TF=pinv(J_SSP)*Left;


    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=[0 0 0]';
    Fb_l=[0 0 0]';
    Fc_l=[0 0 0]';
    Fd_l=[0 0 0]';

    Fa_r=TF(15:17);
    Fb_r=TF(18:20);
    Fc_r=TF(21:23);
    Fd_r=TF(24:26);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
elseif and(t>=T_Gait,t<T_end_a_a)
    % 2 leg
    J_DSP=[B...
           J_a_l' J_b_l' J_c_l' J_d_l'...
           J_a_r' J_b_r' J_c_r' J_d_r'];
    TF=pinv(J_DSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=TF(27:29);
    Fb_r=TF(30:32);
    Fc_r=TF(33:35);
    Fd_r=TF(36:38);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
elseif and(t>=T_end_a_a,t<T_end_a_c)
    % L leg
    J_SSP=[B J_a_l' J_b_l' J_c_l' J_d_l']; 
    TF=pinv(J_SSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=[0 0 0]';
    Fb_r=[0 0 0]';
    Fc_r=[0 0 0]';
    Fd_r=[0 0 0]';

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
elseif and(t>=T_end_a_c,t<=(T_Gait+Td+T_end))
    % 2 leg
    J_DSP=[B...
           J_a_l' J_b_l' J_c_l' J_d_l'...
           J_a_r' J_b_r' J_c_r' J_d_r'];
    TF=pinv(J_DSP)*Left;

    Tau_r=TF(1:6);
    Tau_l=TF(7:12);
    Tau_tr=TF(13:14);

    Fa_l=TF(15:17);
    Fb_l=TF(18:20);
    Fc_l=TF(21:23);
    Fd_l=TF(24:26);

    Fa_r=TF(27:29);
    Fb_r=TF(30:32);
    Fc_r=TF(33:35);
    Fd_r=TF(36:38);

    F_l=Fa_l+Fb_l+Fc_l+Fd_l;
    F_r=Fa_r+Fb_r+Fc_r+Fd_r;

    M_l=cross(p_a_l,Fa_l)+cross(p_b_l,Fb_l)+cross(p_c_l,Fc_l)+cross(p_d_l,Fd_l);
    M_r=cross(p_a_r,Fa_r)+cross(p_b_r,Fb_r)+cross(p_c_r,Fc_r)+cross(p_d_r,Fd_r);
    
end

%% Output
O=[Tau_r;Tau_l;Tau_tr;F_r;F_l;M_r;M_l];
end
