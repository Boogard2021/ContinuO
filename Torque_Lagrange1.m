function O=Torque_Lagrange1(P)
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

dr_p = dp(1:3); % pelvis position
dx_p = dr_p(1);
dy_p = dr_p(2);
dz_p = dr_p(3);
dq_p = dp(4:6); % pelvis rotation
dalpha_p = dq_p(1);
dbeta_p = dq_p(2);
dgamma_p = dq_p(3);

ddr_p = ddp(1:3); % pelvis position
ddx_p = ddr_p(1);
ddy_p = ddr_p(2);
ddz_p = ddr_p(3);
ddq_p = ddp(4:6); % pelvis rotation
ddalpha_p = ddq_p(1);
ddbeta_p = ddq_p(2);
ddgamma_p = ddq_p(3);

% Angle Joints
q=P(55:68); %1:14
q1_fr=q(1);q2_fr=q(2);q3_fr=q(3);
q1_fl=q(4);q2_fl=q(5);q3_fl=q(6);
q1_hr=q(7);q2_hr=q(8);q3_hr=q(9);q4_hr=q(10);
q1_hl=q(11);q2_hl=q(12);q3_hl=q(13);q4_hl=q(14);

dq=P(69:82); %1:14
dq1_fr=dq(1);dq2_fr=dq(2);dq3_fr=dq(3);
dq1_fl=dq(4);dq2_fl=dq(5);dq3_fl=dq(6);
dq1_hr=dq(7);dq2_hr=dq(8);dq3_hr=dq(9);dq4_hr=dq(10);
dq1_hl=dq(11);dq2_hl=dq(12);dq3_hl=dq(13);dq4_hl=dq(14);

ddq=P(83:96); %1:14
ddq1_fr=ddq(1);ddq2_fr=ddq(2);ddq3_fr=ddq(3);
ddq1_fl=ddq(4);ddq2_fl=ddq(5);ddq3_fl=ddq(6);
ddq1_hr=ddq(7);ddq2_hr=ddq(8);ddq3_hr=ddq(9);ddq4_hr=ddq(10);
ddq1_hl=ddq(11);ddq2_hl=ddq(12);ddq3_hl=ddq(13);ddq4_hl=ddq(14);
% Time
t=P(97);

% clear p dp ddp P
%% Parameters
global Tc Td T_ac      %T_ac_a_a T_dc_a_a T_dc_a_c
global m_sh m_th m_hip m_b
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

%% Actuator Torque & Reaction Force and Moment
if and(T>=T_ac,T<=(Td+T_ac))
    % Double Support Phase
    [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange2_1(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p);
elseif and(T>=(Td+T_ac),T<=(Tc+T_ac))
    % HL/FR legs (Swing phase)
    [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange_fr(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p);
elseif and(T>=(Tc+T_ac),T<=(Tc+Td+T_ac))
    % Double Support Phase
    [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange2_1(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p);
elseif and(T>=(Tc+Td+T_ac),T<=(2*Tc+T_ac))
    % HR/FL legs (Swing phase)
    [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange_fl(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p);
end
%%
Tau_f=[Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3]';
Tau_h=[Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4]';
F_fr=[Fx_fr,Fy_fr,Fz_fr]';
F_fl=[Fx_fl,Fy_fl,Fz_fl]';
F_hr=[Fx_hr,Fy_hr,Fz_hr]';
F_hl=[Fx_hl,Fy_hl,Fz_hl]';
%% Output
O=[Tau_f;Tau_h;F_fr;F_fl;F_hr;F_hl];
end