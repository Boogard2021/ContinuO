clear;close all;clc;
warning('off','all')
%% Parameters
run quad_properties;
%% Generalized coordinates
syms x_p y_p z_p dx_p dy_p dz_p ddx_p ddy_p ddz_p real
syms alpha_p beta_p gamma_p dalpha_p dbeta_p dgamma_p ddalpha_p ddbeta_p ddgamma_p real
syms q1_fr q2_fr q3_fr q1_fl q2_fl q3_fl dq1_fr dq2_fr dq3_fr dq1_fl dq2_fl dq3_fl ddq1_fr ddq2_fr ddq3_fr ddq1_fl ddq2_fl ddq3_fl real
syms q1_hr q2_hr q3_hr q4_hr q1_hl q2_hl q3_hl q4_hl dq1_hr dq2_hr dq3_hr dq4_hr dq1_hl dq2_hl dq3_hl dq4_hl ddq1_hr ddq2_hr ddq3_hr ddq4_hr ddq1_hl ddq2_hl ddq3_hl ddq4_hl real
% syms L_b W_b L_h W_ff L_ff
% syms L_sh L_th L_h_x L_h_y L_h_z

q=[q1_fr q2_fr q3_fr q1_fl q2_fl q3_fl q1_hr q2_hr q3_hr q4_hr q1_hl q2_hl q3_hl q4_hl x_p y_p z_p alpha_p beta_p gamma_p]';
dq=[dq1_fr dq2_fr dq3_fr dq1_fl dq2_fl dq3_fl dq1_hr dq2_hr dq3_hr dq4_hr dq1_hl dq2_hl dq3_hl dq4_hl dx_p dy_p dz_p dalpha_p dbeta_p dgamma_p]';
ddq=[ddq1_fr ddq2_fr ddq3_fr ddq1_fl ddq2_fl ddq3_fl ddq1_hr ddq2_hr ddq3_hr ddq4_hr ddq1_hl ddq2_hl ddq3_hl ddq4_hl ddx_p ddy_p ddz_p ddalpha_p ddbeta_p ddgamma_p]';
%% Rotation Matrix
% Pelvis
R_p_x = rot(1,alpha_p,4);
R_p_y = rot(2,beta_p,4);
R_p_z = rot(3,gamma_p,4);
R0 = R_p_y*R_p_z*R_p_x;

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

%% Translation Matrix
% Trunk
P_p = trans([],[x_p,y_p,z_p]);
%P_pl = trans([],d_b);

%Front Right
P_shd_fr = trans([],[L_b/2,-W_b/2,0]);
P_hip_fr = trans([],[L_h(1);-L_h(2);-L_h(3)]);
P_knee_fr = trans([],[L_th_f(1);-L_th_f(2);-L_th_f(3)]);
P_ankle_fr = trans([],[-L_sh_f(1);-L_sh_f(2);-L_sh_f(3)]);

%Front Left
P_shd_fl = trans([],[L_b/2,W_b/2,0]);
P_hip_fl = trans([],[L_h(1);L_h(2);-L_h(3)]);
P_knee_fl = trans([],[L_th_f(1);L_th_f(2);-L_th_f(3)]);
P_ankle_fl = trans([],[-L_sh_f(1);L_sh_f(2);-L_sh_f(3)]);


%Hind Right
P_shd_hr = trans([],[-L_b/2,-W_b/2,0]);
P_hip_hr = trans([],[-L_h(1);-L_h(2);-L_h(3)]);
P_knee_hr = trans([],[-L_th_h(1);-L_th_h(2);-L_th_h(3)]);
P_knee_mid_hr = trans([],[-L_th_h_mid(1);-L_th_h_mid(2);-L_th_h_mid(3)]);
P_ankle_hr = trans([],[-L_sh_h(1);-L_sh_h(2);-L_sh_h(3)]);

%Hind Left
P_shd_hl = trans([],[-L_b/2,W_b/2,0]);
P_hip_hl = trans([],[-L_h(1);L_h(2);-L_h(3)]);
P_knee_hl = trans([],[-L_th_h(1);L_th_h(2);-L_th_h(3)]);
P_knee_mid_hl = trans([],[-L_th_h_mid(1);L_th_h_mid(2);-L_th_h_mid(3)]);
P_ankle_hl = trans([],[-L_sh_h(1);L_sh_h(2);-L_sh_h(3)]);

%% Joint Positions
r_b=            P_p*R0*[0;0;0;1];

r_shd_fr=        P_p*R0*P_shd_fr*[0;0;0;1];
r_shd_fl=        P_p*R0*P_shd_fl*[0;0;0;1];
r_shd_hr=        P_p*R0*P_shd_hr*[0;0;0;1];
r_shd_hl=        P_p*R0*P_shd_hl*[0;0;0;1];

r_hip_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*[0;0;0;1];
r_hip_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*[0;0;0;1];
r_hip_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*[0;0;0;1];
r_hip_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*[0;0;0;1];

r_knee_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*[0;0;0;1];
r_knee_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*[0;0;0;1];
r_knee_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*[0;0;0;1];
r_knee_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*[0;0;0;1];
r_knee_mid_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hr*P_knee_mid_hr*[0;0;0;1];
r_knee_mid_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_knee_mid_hl*[0;0;0;1];

r_ankle_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*Rq3_fr*P_ankle_fr*[0;0;0;1];
r_ankle_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*Rq3_fl*P_ankle_fl*[0;0;0;1];
r_ankle_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hr*P_knee_mid_hr*Rq4_hr*P_ankle_hr*[0;0;0;1];
r_ankle_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_knee_mid_hl*Rq4_hl*P_ankle_hl*[0;0;0;1];

%% Links CoM
% Trunk
% Trunk
P_p_c = trans([],d_b);
% Front Right
P_hip_c_fr= trans([],d_hip_fr);
P_th_c_fr = trans([],d_th_fr);
P_sh_c_fr = trans([],d_sh_fr);

% Front Left
P_hip_c_fl= trans([],d_hip_fl);
P_th_c_fl = trans([],d_th_fl);
P_sh_c_fl = trans([],d_sh_fl);

% Hind Right
P_hip_c_hr= trans([],d_hip_hr);
P_th_c_hr = trans([],d_th_hr);
P_th_mid_c_hr = trans([],d_th_mid_hr);
P_sh_c_hr = trans([],d_sh_hr);

% Hind Left
P_hip_c_hl= trans([],d_hip_hl);
P_th_c_hl = trans([],d_th_hl);
P_th_mid_c_hl = trans([],d_th_mid_hl);
P_sh_c_hl = trans([],d_sh_hl);

c_b=        P_p*R0*P_p_c*[0;0;0;1];

c_hip_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_c_fr*[0;0;0;1];
Xfr_1= c_hip_fr(1);
Yfr_1= c_hip_fr(2);
Zfr_1= c_hip_fr(3);
c_hip_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_c_fl*[0;0;0;1];
Xfl_1= c_hip_fl(1);
Yfl_1= c_hip_fl(2);
Zfl_1= c_hip_fl(3);
c_hip_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_c_hr*[0;0;0;1];
Xhr_1= c_hip_hr(1);
Yhr_1= c_hip_hr(2);
Zhr_1= c_hip_hr(3);
c_hip_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_c_hl*[0;0;0;1];
Xhl_1= c_hip_hl(1);
Yhl_1= c_hip_hl(2);
Zhl_1= c_hip_hl(3);
c_th_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_c_fr*[0;0;0;1];
Xfr_2= c_th_fr(1);
Yfr_2= c_th_fr(2);
Zfr_2= c_th_fr(3);
c_th_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_c_fl*[0;0;0;1];
Xfl_2= c_th_fl(1);
Yfl_2= c_th_fl(2);
Zfl_2= c_th_fl(3);
c_th_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_c_hr*[0;0;0;1];
Xhr_2= c_th_hr(1);
Yhr_2= c_th_hr(2);
Zhr_2= c_th_hr(3);
c_th_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_c_hl*[0;0;0;1];
Xhl_2= c_th_hl(1);
Yhl_2= c_th_hl(2);
Zhl_2= c_th_hl(3);
c_th_mid_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hr*P_th_mid_c_hr*[0;0;0;1];
Xhr_3= c_th_mid_hr(1);
Yhr_3= c_th_mid_hr(2);
Zhr_3= c_th_mid_hr(3);
c_th_mid_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_th_mid_c_hl*[0;0;0;1];
Xhl_3= c_th_mid_hl(1);
Yhl_3= c_th_mid_hl(2);
Zhl_3= c_th_mid_hl(3);
c_sh_fr=   P_p*R0*P_shd_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_knee_fr*Rq3_fr*P_sh_c_fr*[0;0;0;1];
Xfr_3= c_sh_fr(1);
Yfr_3= c_sh_fr(2);
Zfr_3= c_sh_fr(3);
c_sh_fl=   P_p*R0*P_shd_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_knee_fl*Rq3_fl*P_sh_c_fl*[0;0;0;1];
Xfl_3= c_sh_fl(1);
Yfl_3= c_sh_fl(2);
Zfl_3= c_sh_fl(3);
c_sh_hr=   P_p*R0*P_shd_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_knee_hr*Rq3_hl*P_knee_mid_hr*Rq4_hr*P_sh_c_hr*[0;0;0;1];
Xhr_4= c_sh_hr(1);
Yhr_4= c_sh_hr(2);
Zhr_4= c_sh_hr(3);
c_sh_hl=   P_p*R0*P_shd_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_knee_hl*Rq3_hl*P_knee_mid_hl*Rq4_hl*P_sh_c_hl*[0;0;0;1];
Xhl_4= c_sh_hl(1);
Yhl_4= c_sh_hl(2);
Zhl_4= c_sh_hl(3);

dXfr_1=jacobian(Xfr_1,q)*dq;dYfr_1=jacobian(Yfr_1,q)*dq;dZfr_1=jacobian(Zfr_1,q)*dq;
ddXfr_1=jacobian(dXfr_1,q)*dq+jacobian(dXfr_1,dq)*ddq;ddYfr_1=jacobian(dYfr_1,q)*dq+jacobian(dYfr_1,dq)*ddq;ddZfr_1=jacobian(dZfr_1,q)*dq+jacobian(dZfr_1,dq)*ddq;
dXfr_2=jacobian(Xfr_2,q)*dq;dYfr_2=jacobian(Yfr_2,q)*dq;dZfr_2=jacobian(Zfr_2,q)*dq;
ddXfr_2=jacobian(dXfr_2,q)*dq+jacobian(dXfr_2,dq)*ddq;ddYfr_2=jacobian(dYfr_2,q)*dq+jacobian(dYfr_2,dq)*ddq;ddZfr_2=jacobian(dZfr_2,q)*dq+jacobian(dZfr_2,dq)*ddq;
dXfr_3=jacobian(Xfr_3,q)*dq;dYfr_3=jacobian(Yfr_3,q)*dq;dZfr_3=jacobian(Zfr_3,q)*dq;
ddXfr_3=jacobian(dXfr_3,q)*dq+jacobian(dXfr_3,dq)*ddq;ddYfr_3=jacobian(dYfr_3,q)*dq+jacobian(dYfr_3,dq)*ddq;ddZfr_3=jacobian(dZfr_3,q)*dq+jacobian(dZfr_3,dq)*ddq;
dXfl_1=jacobian(Xfl_1,q)*dq;dYfl_1=jacobian(Yfl_1,q)*dq;dZfl_1=jacobian(Zfl_1,q)*dq;
ddXfl_1=jacobian(dXfl_1,q)*dq+jacobian(dXfl_1,dq)*ddq;ddYfl_1=jacobian(dYfl_1,q)*dq+jacobian(dYfl_1,dq)*ddq;ddZfl_1=jacobian(dZfl_1,q)*dq+jacobian(dZfl_1,dq)*ddq;
dXfl_2=jacobian(Xfl_2,q)*dq;dYfl_2=jacobian(Yfl_2,q)*dq;dZfl_2=jacobian(Zfl_2,q)*dq;
ddXfl_2=jacobian(dXfl_2,q)*dq+jacobian(dXfl_2,dq)*ddq;ddYfl_2=jacobian(dYfl_2,q)*dq+jacobian(dYfl_2,dq)*ddq;ddZfl_2=jacobian(dZfl_2,q)*dq+jacobian(dZfl_2,dq)*ddq;
dXfl_3=jacobian(Xfl_3,q)*dq;dYfl_3=jacobian(Yfl_3,q)*dq;dZfl_3=jacobian(Zfl_3,q)*dq;
ddXfl_3=jacobian(dXfl_3,q)*dq+jacobian(dXfl_3,dq)*ddq;ddYfl_3=jacobian(dYfl_3,q)*dq+jacobian(dYfl_3,dq)*ddq;ddZfl_3=jacobian(dZfl_3,q)*dq+jacobian(dZfl_3,dq)*ddq;
dXhr_1=jacobian(Xhr_1,q)*dq;dYhr_1=jacobian(Yhr_1,q)*dq;dZhr_1=jacobian(Zhr_1,q)*dq;
ddXhr_1=jacobian(dXhr_1,q)*dq+jacobian(dXhr_1,dq)*ddq;ddYhr_1=jacobian(dYhr_1,q)*dq+jacobian(dYhr_1,dq)*ddq;ddZhr_1=jacobian(dZhr_1,q)*dq+jacobian(dZhr_1,dq)*ddq;
dXhr_2=jacobian(Xhr_2,q)*dq;dYhr_2=jacobian(Yhr_2,q)*dq;dZhr_2=jacobian(Zhr_2,q)*dq;
ddXhr_2=jacobian(dXhr_2,q)*dq+jacobian(dXhr_2,dq)*ddq;ddYhr_2=jacobian(dYhr_2,q)*dq+jacobian(dYhr_2,dq)*ddq;ddZhr_2=jacobian(dZhr_2,q)*dq+jacobian(dZhr_2,dq)*ddq;
dXhr_3=jacobian(Xhr_3,q)*dq;dYhr_3=jacobian(Yhr_3,q)*dq;dZhr_3=jacobian(Zhr_3,q)*dq;
ddXhr_3=jacobian(dXhr_3,q)*dq+jacobian(dXhr_3,dq)*ddq;ddYhr_3=jacobian(dYhr_3,q)*dq+jacobian(dYhr_3,dq)*ddq;ddZhr_3=jacobian(dZhr_3,q)*dq+jacobian(dZhr_3,dq)*ddq;
dXhl_1=jacobian(Xhl_1,q)*dq;dYhl_1=jacobian(Yhl_1,q)*dq;dZhl_1=jacobian(Zhl_1,q)*dq;
ddXhl_1=jacobian(dXhl_1,q)*dq+jacobian(dXhl_1,dq)*ddq;ddYhl_1=jacobian(dYhl_1,q)*dq+jacobian(dYhl_1,dq)*ddq;ddZhl_1=jacobian(dZhl_1,q)*dq+jacobian(dZhl_1,dq)*ddq;
dXhl_2=jacobian(Xhl_2,q)*dq;dYhl_2=jacobian(Yhl_2,q)*dq;dZhl_2=jacobian(Zhl_2,q)*dq;
ddXhl_2=jacobian(dXhl_2,q)*dq+jacobian(dXhl_2,dq)*ddq;ddYhl_2=jacobian(dYhl_2,q)*dq+jacobian(dYhl_2,dq)*ddq;ddZhl_2=jacobian(dZhl_2,q)*dq+jacobian(dZhl_2,dq)*ddq;
dXhl_3=jacobian(Xhl_3,q)*dq;dYhl_3=jacobian(Yhl_3,q)*dq;dZhl_3=jacobian(Zhl_3,q)*dq;
ddXhl_3=jacobian(dXhl_3,q)*dq+jacobian(dXhl_3,dq)*ddq;ddYhl_3=jacobian(dYhl_3,q)*dq+jacobian(dYhl_3,dq)*ddq;ddZhl_3=jacobian(dZhl_3,q)*dq+jacobian(dZhl_3,dq)*ddq;

dXhr_4=jacobian(Xhr_4,q)*dq;dYhr_4=jacobian(Yhr_4,q)*dq;dZhr_4=jacobian(Zhr_4,q)*dq;
ddXhr_4=jacobian(dXhr_4,q)*dq+jacobian(dXhr_4,dq)*ddq;ddYhr_4=jacobian(dYhr_4,q)*dq+jacobian(dYhr_4,dq)*ddq;ddZhr_4=jacobian(dZhr_4,q)*dq+jacobian(dZhr_4,dq)*ddq;
dXhl_4=jacobian(Xhl_4,q)*dq;dYhl_4=jacobian(Yhl_4,q)*dq;dZhl_4=jacobian(Zhl_4,q)*dq;
ddXhl_4=jacobian(dXhl_4,q)*dq+jacobian(dXhl_4,dq)*ddq;ddYhl_4=jacobian(dYhl_4,q)*dq+jacobian(dYhl_4,dq)*ddq;ddZhl_4=jacobian(dZhl_4,q)*dq+jacobian(dZhl_4,dq)*ddq;

% end_effector positions
P=r_ankle_fr(1:3);
Xfr_e=P(1);Yfr_e=P(2);Zfr_e=P(3);
P=r_ankle_fl(1:3);
Xfl_e=P(1);Yfl_e=P(2);Zfl_e=P(3);
P=r_ankle_hl(1:3);
Xhl_e=P(1);Yhl_e=P(2);Zhl_e=P(3);
P=r_ankle_hr(1:3);
Xhr_e=P(1);Yhr_e=P(2);Zhr_e=P(3);

dXfl_e=jacobian(Xfl_e,q)*dq;dYfl_e=jacobian(Yfl_e,q)*dq;dZfl_e=jacobian(Zfl_e,q)*dq;
dXfr_e=jacobian(Xfr_e,q)*dq;dYfr_e=jacobian(Yfr_e,q)*dq;dZfr_e=jacobian(Zfr_e,q)*dq;
dXhr_e=jacobian(Xhr_e,q)*dq;dYhr_e=jacobian(Yhr_e,q)*dq;dZhr_e=jacobian(Zhr_e,q)*dq;
dXhl_e=jacobian(Xhl_e,q)*dq;dYhl_e=jacobian(Yhl_e,q)*dq;dZhl_e=jacobian(Zhl_e,q)*dq;

JL_e1=[jacobian(Xfr_e,q);jacobian(Yfr_e,q);jacobian(Zfr_e,q)];
JL_e2=[jacobian(Xfl_e,q);jacobian(Yfl_e,q);jacobian(Zfl_e,q)];
JL_e3=[jacobian(Xhr_e,q);jacobian(Yhr_e,q);jacobian(Zhr_e,q)];
JL_e4=[jacobian(Xhl_e,q);jacobian(Yhl_e,q);jacobian(Zhl_e,q)];

P= c_b(1:3);
Xb_E=P(1);Yb_E=P(2);Zb_E=P(3);
dXb_E=jacobian(Xb_E,q)*dq;dYb_E=jacobian(Yb_E,q)*dq;dZb_E=jacobian(Zb_E,q)*dq;
ddXb_E=jacobian(dXb_E,q)*dq+jacobian(dXb_E,dq)*ddq;ddYb_E=jacobian(dYb_E,q)*dq+jacobian(dYb_E,dq)*ddq;ddZb_E=jacobian(dZb_E,q)*dq+jacobian(dZb_E,dq)*ddq;
%%%%%%%%%%sorat zavie eee%%%%%%%%%%%
%%%body%%%
w_b=[0;dbeta_p;0]+R_p_y(1:3,1:3)*[0;0;dgamma_p]+R_p_y(1:3,1:3)*R_p_z(1:3,1:3)*[dalpha_p;0;0];

qb=[alpha_p;beta_p;gamma_p];
dqb=[dalpha_p;dbeta_p;dgamma_p];
ddqb=[ddalpha_p;ddbeta_p;ddgamma_p];

wx_b=w_b(1);
ax_b=jacobian(wx_b,qb)*dqb+jacobian(wx_b,dqb)*ddqb;
wy_b=w_b(2);
ay_b=jacobian(wy_b,qb)*dqb+jacobian(wy_b,dqb)*ddqb;
wz_b=w_b(3);
az_b=jacobian(wz_b,qb)*dqb+jacobian(wz_b,dqb)*ddqb;
a_b=[ax_b;ay_b;az_b];
%fr
w_hip_fr=w_b+R0(1:3,1:3)*[dq1_fr;0;0];
wx_hip_fr=w_hip_fr(1);
ax_hip_fr=jacobian(wx_hip_fr,q)*dq+jacobian(wx_hip_fr,dq)*ddq;
wy_hip_fr=w_hip_fr(2);
ay_hip_fr=jacobian(wy_hip_fr,q)*dq+jacobian(wy_hip_fr,dq)*ddq;
wz_hip_fr=w_hip_fr(3);
az_hip_fr=jacobian(wz_hip_fr,q)*dq+jacobian(wz_hip_fr,dq)*ddq;
a_hip_fr=[ax_hip_fr;ay_hip_fr;az_hip_fr];

w_th_fr=w_hip_fr+Rq1_fr(1:3,1:3)*[0;dq2_fr;0];
wx_th_fr=w_th_fr(1);
ax_th_fr=jacobian(wx_th_fr,q)*dq+jacobian(wx_th_fr,dq)*ddq;
wy_th_fr=w_th_fr(2);
ay_th_fr=jacobian(wy_th_fr,q)*dq+jacobian(wy_th_fr,dq)*ddq;
wz_th_fr=w_th_fr(3);
az_th_fr=jacobian(wz_th_fr,q)*dq+jacobian(wz_th_fr,dq)*ddq;
a_th_fr=[ax_th_fr;ay_th_fr;az_th_fr];

w_sh_fr=w_th_fr+Rq2_fr(1:3,1:3)*[0;dq3_fr;0];
wx_sh_fr=w_sh_fr(1);
ax_sh_fr=jacobian(wx_sh_fr,q)*dq+jacobian(wx_sh_fr,dq)*ddq;
wy_sh_fr=w_sh_fr(2);
ay_sh_fr=jacobian(wy_sh_fr,q)*dq+jacobian(wy_sh_fr,dq)*ddq;
wz_sh_fr=w_sh_fr(3);
az_sh_fr=jacobian(wz_sh_fr,q)*dq+jacobian(wz_sh_fr,dq)*ddq;
a_sh_fr=[ax_sh_fr;ay_sh_fr;az_sh_fr];
%fl
w_hip_fl=w_b+R0(1:3,1:3)*[dq1_fl;0;0];
wx_hip_fl=w_hip_fl(1);
ax_hip_fl=jacobian(wx_hip_fl,q)*dq+jacobian(wx_hip_fl,dq)*ddq;
wy_hip_fl=w_hip_fl(2);
ay_hip_fl=jacobian(wy_hip_fl,q)*dq+jacobian(wy_hip_fl,dq)*ddq;
wz_hip_fl=w_hip_fl(3);
az_hip_fl=jacobian(wz_hip_fl,q)*dq+jacobian(wz_hip_fl,dq)*ddq;
a_hip_fl=[ax_hip_fl;ay_hip_fl;az_hip_fl];

w_th_fl=w_hip_fl+Rq1_fl(1:3,1:3)*[0;dq2_fl;0];
wx_th_fl=w_th_fl(1);
ax_th_fl=jacobian(wx_th_fl,q)*dq+jacobian(wx_th_fl,dq)*ddq;
wy_th_fl=w_th_fl(2);
ay_th_fl=jacobian(wy_th_fl,q)*dq+jacobian(wy_th_fl,dq)*ddq;
wz_th_fl=w_th_fl(3);
az_th_fl=jacobian(wz_th_fl,q)*dq+jacobian(wz_th_fl,dq)*ddq;
a_th_fl=[ax_th_fl;ay_th_fl;az_th_fl];

w_sh_fl=w_th_fl+Rq2_fl(1:3,1:3)*[0;dq3_fl;0];
wx_sh_fl=w_sh_fl(1);
ax_sh_fl=jacobian(wx_sh_fl,q)*dq+jacobian(wx_sh_fl,dq)*ddq;
wy_sh_fl=w_sh_fl(2);
ay_sh_fl=jacobian(wy_sh_fl,q)*dq+jacobian(wy_sh_fl,dq)*ddq;
wz_sh_fl=w_sh_fl(3);
az_sh_fl=jacobian(wz_sh_fl,q)*dq+jacobian(wz_sh_fl,dq)*ddq;
a_sh_fl=[ax_sh_fl;ay_sh_fl;az_sh_fl];

%hr
w_hip_hr=w_b+R0(1:3,1:3)*[dq1_hr;0;0];
wx_hip_hr=w_hip_hr(1);
ax_hip_hr=jacobian(wx_hip_hr,q)*dq+jacobian(wx_hip_hr,dq)*ddq;
wy_hip_hr=w_hip_hr(2);
ay_hip_hr=jacobian(wy_hip_hr,q)*dq+jacobian(wy_hip_hr,dq)*ddq;
wz_hip_hr=w_hip_hr(3);
az_hip_hr=jacobian(wz_hip_hr,q)*dq+jacobian(wz_hip_hr,dq)*ddq;
a_hip_hr=[ax_hip_hr;ay_hip_hr;az_hip_hr];

w_th_hr=w_hip_hr+Rq1_hr(1:3,1:3)*[0;dq2_hr;0];
wx_th_hr=w_th_hr(1);
ax_th_hr=jacobian(wx_th_hr,q)*dq+jacobian(wx_th_hr,dq)*ddq;
wy_th_hr=w_th_hr(2);
ay_th_hr=jacobian(wy_th_hr,q)*dq+jacobian(wy_th_hr,dq)*ddq;
wz_th_hr=w_th_hr(3);
az_th_hr=jacobian(wz_th_hr,q)*dq+jacobian(wz_th_hr,dq)*ddq;
a_th_hr=[ax_th_hr;ay_th_hr;az_th_hr];

w_th_mid_hr=w_th_hr+Rq2_hr(1:3,1:3)*[0;dq3_hr;0];
wx_th_mid_hr=w_th_mid_hr(1);
ax_th_mid_hr=jacobian(wx_th_mid_hr,q)*dq+jacobian(wx_th_mid_hr,dq)*ddq;
wy_th_mid_hr=w_th_mid_hr(2);
ay_th_mid_hr=jacobian(wy_th_mid_hr,q)*dq+jacobian(wy_th_mid_hr,dq)*ddq;
wz_th_mid_hr=w_th_mid_hr(3);
az_th_mid_hr=jacobian(wz_th_mid_hr,q)*dq+jacobian(wz_th_mid_hr,dq)*ddq;
a_th_mid_hr=[ax_th_mid_hr;ay_th_mid_hr;az_th_mid_hr];

w_sh_hr=w_th_mid_hr+Rq3_hr(1:3,1:3)*[0;dq4_hr;0];
wx_sh_hr=w_sh_hr(1);
ax_sh_hr=jacobian(wx_sh_hr,q)*dq+jacobian(wx_sh_hr,dq)*ddq;
wy_sh_hr=w_sh_hr(2);
ay_sh_hr=jacobian(wy_sh_hr,q)*dq+jacobian(wy_sh_hr,dq)*ddq;
wz_sh_hr=w_sh_hr(3);
az_sh_hr=jacobian(wz_sh_hr,q)*dq+jacobian(wz_sh_hr,dq)*ddq;
a_sh_hr=[ax_sh_hr;ay_sh_hr;az_sh_hr];
%hl
w_hip_hl=w_b+R0(1:3,1:3)*[dq1_hl;0;0];
wx_hip_hl=w_hip_hl(1);
ax_hip_hl=jacobian(wx_hip_hl,q)*dq+jacobian(wx_hip_hl,dq)*ddq;
wy_hip_hl=w_hip_hl(2);
ay_hip_hl=jacobian(wy_hip_hl,q)*dq+jacobian(wy_hip_hl,dq)*ddq;
wz_hip_hl=w_hip_hl(3);
az_hip_hl=jacobian(wz_hip_hl,q)*dq+jacobian(wz_hip_hl,dq)*ddq;
a_hip_hl=[ax_hip_hl;ay_hip_hl;az_hip_hl];

w_th_hl=w_hip_hl+Rq1_hl(1:3,1:3)*[0;dq2_hl;0];
wx_th_hl=w_th_hl(1);
ax_th_hl=jacobian(wx_th_hl,q)*dq+jacobian(wx_th_hl,dq)*ddq;
wy_th_hl=w_th_hl(2);
ay_th_hl=jacobian(wy_th_hl,q)*dq+jacobian(wy_th_hl,dq)*ddq;
wz_th_hl=w_th_hl(3);
az_th_hl=jacobian(wz_th_hl,q)*dq+jacobian(wz_th_hl,dq)*ddq;
a_th_hl=[ax_th_hl;ay_th_hl;az_th_hl];

w_th_mid_hl=w_th_hl+Rq2_hl(1:3,1:3)*[0;dq3_hl;0];
wx_th_mid_hl=w_th_mid_hl(1);
ax_th_mid_hl=jacobian(wx_th_mid_hl,q)*dq+jacobian(wx_th_mid_hl,dq)*ddq;
wy_th_mid_hl=w_th_mid_hl(2);
ay_th_mid_hl=jacobian(wy_th_mid_hl,q)*dq+jacobian(wy_th_mid_hl,dq)*ddq;
wz_th_mid_hl=w_th_mid_hl(3);
az_th_mid_hl=jacobian(wz_th_mid_hl,q)*dq+jacobian(wz_th_mid_hl,dq)*ddq;
a_th_mid_hl=[ax_th_mid_hl;ay_th_mid_hl;az_th_mid_hl];

w_sh_hl=w_th_mid_hl+Rq3_hl(1:3,1:3)*[0;dq3_hl;0];
wx_sh_hl=w_sh_hl(1);
ax_sh_hl=jacobian(wx_sh_hl,q)*dq+jacobian(wx_sh_hl,dq)*ddq;
wy_sh_hl=w_sh_hl(2);
ay_sh_hl=jacobian(wy_sh_hl,q)*dq+jacobian(wy_sh_hl,dq)*ddq;
wz_sh_hl=w_sh_hl(3);
az_sh_hl=jacobian(wz_sh_hl,q)*dq+jacobian(wz_sh_hl,dq)*ddq;
a_sh_hl=[ax_sh_hl;ay_sh_hl;az_sh_hl];
%%%%%%% Moment of inertia in world coordinate
Ib_E=R0(1:3,1:3)*J_b*R0(1:3,1:3)';
Ihk1_E=(R0(1:3,1:3)*Rq1_fr(1:3,1:3))*J_hip_fr*(R0(1:3,1:3)*Rq1_fr(1:3,1:3))';
Ihk2_E=(R0(1:3,1:3)*Rq1_fl(1:3,1:3))*J_hip_fl*(R0(1:3,1:3)*Rq1_fl(1:3,1:3))';
Ihk3_E=(R0(1:3,1:3)*Rq1_hr(1:3,1:3))*J_hip_hr*(R0(1:3,1:3)*Rq1_hr(1:3,1:3))';
Ihk4_E=(R0(1:3,1:3)*Rq1_hl(1:3,1:3))*J_hip_hl*(R0(1:3,1:3)*Rq1_hl(1:3,1:3))';
Ikf1_E=(R0(1:3,1:3)*Rq1_fr(1:3,1:3)*Rq2_fr(1:3,1:3))*J_th_fr*(R0(1:3,1:3)*Rq1_fr(1:3,1:3)*Rq2_fr(1:3,1:3))';
Ikf2_E=(R0(1:3,1:3)*Rq1_fl(1:3,1:3)*Rq2_fl(1:3,1:3))*J_th_fl*(R0(1:3,1:3)*Rq1_fl(1:3,1:3)*Rq2_fl(1:3,1:3))';
Ikf3_E=(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3))*J_th_hr*(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3))';
Ikf4_E=(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3))*J_th_hl*(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3))';
Ikf_mid_3_E=(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3)*Rq3_hr(1:3,1:3))*J_th_mid_hr*(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3)*Rq3_hr(1:3,1:3))';
Ikf_mid_4_E=(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3)*Rq3_hl(1:3,1:3))*J_th_mid_hl*(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3)*Rq3_hl(1:3,1:3))';
Ife1_E=(R0(1:3,1:3)*Rq1_fr(1:3,1:3)*Rq2_fr(1:3,1:3)*Rq3_fr(1:3,1:3))*J_sh_fr*(R0(1:3,1:3)*Rq1_fr(1:3,1:3)*Rq2_fr(1:3,1:3)*Rq3_fr(1:3,1:3))';
Ife2_E=(R0(1:3,1:3)*Rq1_fl(1:3,1:3)*Rq2_fl(1:3,1:3)*Rq3_fl(1:3,1:3))*J_sh_fl*(R0(1:3,1:3)*Rq1_fl(1:3,1:3)*Rq2_fl(1:3,1:3)*Rq3_fl(1:3,1:3))';
Ife3_E=(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3)*Rq3_hr(1:3,1:3)*Rq4_hr(1:3,1:3))*J_sh_hr*(R0(1:3,1:3)*Rq1_hr(1:3,1:3)*Rq2_hr(1:3,1:3)*Rq3_hr(1:3,1:3)*Rq4_hr(1:3,1:3))';
Ife4_E=(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3)*Rq3_hl(1:3,1:3)*Rq4_hl(1:3,1:3))*J_sh_hl*(R0(1:3,1:3)*Rq1_hl(1:3,1:3)*Rq2_hl(1:3,1:3)*Rq3_hl(1:3,1:3)*Rq4_hl(1:3,1:3))';
%% Dynamic Equations
% Left Side
T1=1/2*m_b*(dXb_E^2+dYb_E^2+dZb_E^2)+ ...
+1/2*m_hip*((dXfr_1^2+dYfr_1^2+dZfr_1^2)+(dXfl_1^2+dYfl_1^2+dZfl_1^2)+(dXhr_1^2+dYhr_1^2+dZhr_1^2)+(dXhl_1^2+dYhl_1^2+dZhl_1^2))+...
+1/2*m_th_f*((dXfr_2^2+dYfr_2^2+dZfr_2^2)+(dXfl_2^2+dYfl_2^2+dZfl_2^2))+1/2*m_th_h*((dXhr_2^2+dYhr_2^2+dZhr_2^2)+(dXhl_2^2+dYhl_2^2+dZhl_2^2))+1/2*m_th_h_mid*((dXhr_3^2+dYhr_3^2+dZhr_3^2)+(dXhl_3^2+dYhl_3^2+dZhl_3^2))+...
+1/2*m_sh*((dXfr_3^2+dYfr_3^2+dZfr_3^2)+(dXfl_3^2+dYfl_3^2+dZfl_3^2)+(dXhr_4^2+dYhr_4^2+dZhr_4^2)+(dXhl_4^2+dYhl_4^2+dZhl_4^2));
T2=1/2*w_b'*Ib_E*w_b+1/2*w_hip_fr'*Ihk1_E*w_hip_fr+1/2*w_hip_fl'*Ihk2_E*w_hip_fl+1/2*w_hip_hr'*Ihk3_E*w_hip_hr+1/2*w_hip_hl'*Ihk4_E*w_hip_hl+1/2*w_th_fr'*Ikf1_E*w_th_fr+1/2*w_th_fl'*Ikf2_E*w_th_fl+1/2*w_th_hr'*Ikf3_E*w_th_hr+1/2*w_th_hl'*Ikf4_E*w_th_hl+...
   1/2*w_th_mid_hr'*Ikf_mid_3_E*w_th_mid_hr+1/2*w_th_mid_hl'*Ikf_mid_4_E*w_th_mid_hl+1/2*w_sh_fr'*Ife1_E*w_sh_fr+1/2*w_sh_fl'*Ife2_E*w_sh_fl+1/2*w_sh_hr'*Ife3_E*w_sh_hr+1/2*w_sh_hl'*Ife4_E*w_sh_hl;
T=T1+T2;
U=m_b*g(3)*Zb_E+m_hip*g(3)*(Zfr_1+Zfl_1+Zhr_1+Zhl_1)+m_th_f*g(3)*(Zfr_2+Zfl_2)+m_th_h*g(3)*(Zhr_2+Zhl_2)+m_th_h_mid*g(3)*(Zhr_3+Zhl_3)+m_sh*g(3)*(Zfr_3+Zfl_3+Zhr_4+Zhl_4);

dT=jacobian(T,dq);
LeftSide1=jacobian(dT,q)*dq+jacobian(dT,dq)*ddq-jacobian(T,q).'+jacobian(U,q).';
LeftSide=subs(LeftSide1,{alpha_p,beta_p,gamma_p,dalpha_p,dbeta_p,dgamma_p,ddalpha_p,ddbeta_p,ddgamma_p},{0,0,0,0,0,0,0,0,0});
% Right Side
B=[eye(14);zeros(6,14)];

RightSide_fr1=[B,JL_e2.',JL_e3.']; % front right & hind left legs are in swing phase
RightSide_fr=subs(RightSide_fr1,{alpha_p,beta_p,gamma_p,dalpha_p,dbeta_p,dgamma_p,ddalpha_p,ddbeta_p,ddgamma_p},{0,0,0,0,0,0,0,0,0});
RightSide_fl1=[B,JL_e1.',JL_e4.']; % hind right & front left legs are in swing phase
RightSide_fl=subs(RightSide_fl1,{alpha_p,beta_p,gamma_p,dalpha_p,dbeta_p,dgamma_p,ddalpha_p,ddbeta_p,ddgamma_p},{0,0,0,0,0,0,0,0,0});
RightSide_11=[B,JL_e1.',JL_e2.',JL_e3.',JL_e4.']; % four legs are in support phase
RightSide_1=subs(RightSide_11,{alpha_p,beta_p,gamma_p,dalpha_p,dbeta_p,dgamma_p,ddalpha_p,ddbeta_p,ddgamma_p},{0,0,0,0,0,0,0,0,0});

%% Creating m-file Equations

% Flat_Kane_fl
ID=fopen('Flat_Lagrange_fl.m','w');
fprintf(ID,'function [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange_fl(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p)\n');
fprintf(ID,'RightSide_fl=[\n');
for i=1:size(RightSide_fl,1)
    fprintf(ID,'\t');
    for j=1:size(RightSide_fl,2)
        fprintf(ID,char(RightSide_fl(i,j)));
        if j==size(RightSide_fl,2)
            fprintf(ID,';\n');
        else
            fprintf(ID,',');
        end
    end
end
fprintf(ID,'];\n');
fprintf(ID,'LeftSide=[\n');
for i=1:size(LeftSide,1)
    fprintf(ID,'\t');
    fprintf(ID,['\t',char(LeftSide(i)),';\n']);
end
fprintf(ID,'];\n');
fprintf(ID,'answer=pinv(RightSide_fl)*LeftSide;\n');
fprintf(ID,'Mfr_1=answer(1);\n');
fprintf(ID,'Mfr_2=answer(2);\n');
fprintf(ID,'Mfr_3=answer(3);\n');
fprintf(ID,'Mfl_1=answer(4);\n');
fprintf(ID,'Mfl_2=answer(5);\n');
fprintf(ID,'Mfl_3=answer(6);\n');
fprintf(ID,'Mhr_1=answer(7);\n');
fprintf(ID,'Mhr_2=answer(8);\n');
fprintf(ID,'Mhr_3=answer(9);\n');
fprintf(ID,'Mhr_4=answer(10);\n');
fprintf(ID,'Mhl_1=answer(11);\n');
fprintf(ID,'Mhl_2=answer(12);\n');
fprintf(ID,'Mhl_3=answer(13);\n');
fprintf(ID,'Mhl_4=answer(14);\n');
fprintf(ID,'Fx_fr=answer(15);\n');
fprintf(ID,'Fy_fr=answer(16);\n');
fprintf(ID,'Fz_fr=answer(17);\n');
fprintf(ID,'Fx_hl=answer(18);\n');
fprintf(ID,'Fy_hl=answer(19);\n');
fprintf(ID,'Fz_hl=answer(20);\n');
fprintf(ID,'Fx_hr=0;\n');
fprintf(ID,'Fy_hr=0;\n');
fprintf(ID,'Fz_hr=0;\n');
fprintf(ID,'Fx_fl=0;\n');
fprintf(ID,'Fy_fl=0;\n');
fprintf(ID,'Fz_fl=0;\n');
fprintf(ID,'end');
fclose(ID);

% Flat_Kane_fr
ID=fopen('Flat_Lagrange_fr.m','w');
fprintf(ID,'function [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange_fr(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p)\n');
fprintf(ID,'RightSide_fr=[\n');
for i=1:size(RightSide_fr,1)
    fprintf(ID,'\t');
    for j=1:size(RightSide_fr,2)
        fprintf(ID,char(RightSide_fr(i,j)));
        if j==size(RightSide_fr,2)
            fprintf(ID,';\n');
        else
            fprintf(ID,',');
        end
    end
end
fprintf(ID,'];\n');
fprintf(ID,'LeftSide=[\n');
for i=1:size(LeftSide,1)
    fprintf(ID,'\t');
    fprintf(ID,['\t',char(LeftSide(i)),';\n']);
end
fprintf(ID,'];\n');
fprintf(ID,'answer=pinv(RightSide_fr)*LeftSide;\n');
fprintf(ID,'Mfr_1=answer(1);\n');
fprintf(ID,'Mfr_2=answer(2);\n');
fprintf(ID,'Mfr_3=answer(3);\n');
fprintf(ID,'Mfl_1=answer(4);\n');
fprintf(ID,'Mfl_2=answer(5);\n');
fprintf(ID,'Mfl_3=answer(6);\n');
fprintf(ID,'Mhr_1=answer(7);\n');
fprintf(ID,'Mhr_2=answer(8);\n');
fprintf(ID,'Mhr_3=answer(9);\n');
fprintf(ID,'Mhr_4=answer(10);\n');
fprintf(ID,'Mhl_1=answer(11);\n');
fprintf(ID,'Mhl_2=answer(12);\n');
fprintf(ID,'Mhl_3=answer(13);\n');
fprintf(ID,'Mhl_4=answer(14);\n');
fprintf(ID,'Fx_fl=answer(15);\n');
fprintf(ID,'Fy_fl=answer(16);\n');
fprintf(ID,'Fz_fl=answer(17);\n');
fprintf(ID,'Fx_hl=0;\n');
fprintf(ID,'Fy_hl=0;\n');
fprintf(ID,'Fz_hl=0;\n');
fprintf(ID,'Fx_hr=answer(18);\n');
fprintf(ID,'Fy_hr=answer(19);\n');
fprintf(ID,'Fz_hr=answer(20);\n');
fprintf(ID,'Fx_fr=0;\n');
fprintf(ID,'Fy_fr=0;\n');
fprintf(ID,'Fz_fr=0;\n');
fprintf(ID,'end');
fclose(ID);

% Flat_Kane
ID=fopen('Flat_Lagrange2_1.m','w');
fprintf(ID,'function [Mfr_1,Mfr_2,Mfr_3,Mfl_1,Mfl_2,Mfl_3,Mhr_1,Mhr_2,Mhr_3,Mhr_4,Mhl_1,Mhl_2,Mhl_3,Mhl_4,Fx_fr,Fy_fr,Fz_fr,Fx_fl,Fy_fl,Fz_fl,Fx_hr,Fy_hr,Fz_hr,Fx_hl,Fy_hl,Fz_hl]=Flat_Lagrange2_1(q1_fr,q2_fr,q3_fr,q1_fl,q2_fl,q3_fl,q1_hr,q2_hr,q3_hr,q4_hr,q1_hl,q2_hl,q3_hl,q4_hl,x_p,y_p,z_p,alpha_p,beta_p,gamma_p,dq1_fr,dq2_fr,dq3_fr,dq1_fl,dq2_fl,dq3_fl,dq1_hr,dq2_hr,dq3_hr,dq4_hr,dq1_hl,dq2_hl,dq3_hl,dq4_hl,dx_p,dy_p,dz_p,dalpha_p,dbeta_p,dgamma_p,ddq1_fr,ddq2_fr,ddq3_fr,ddq1_fl,ddq2_fl,ddq3_fl,ddq1_hr,ddq2_hr,ddq3_hr,ddq4_hr,ddq1_hl,ddq2_hl,ddq3_hl,ddq4_hl,ddx_p,ddy_p,ddz_p,ddalpha_p,ddbeta_p,ddgamma_p)\n');
fprintf(ID,'RightSide_1=[\n');
for i=1:size(RightSide_1,1)
    fprintf(ID,'\t');
    for j=1:size(RightSide_1,2)
        fprintf(ID,char(RightSide_1(i,j)));
        if j==size(RightSide_1,2)
            fprintf(ID,';\n');
        else
            fprintf(ID,',');
        end
    end
end
fprintf(ID,'];\n');
fprintf(ID,'LeftSide=[\n');
for i=1:size(LeftSide,1)
    fprintf(ID,'\t');
    fprintf(ID,['\t',char(LeftSide(i)),';\n']);
end
fprintf(ID,'];\n');
fprintf(ID,'answer=pinv(RightSide_1)*LeftSide;\n');
fprintf(ID,'Mfr_1=answer(1);\n');
fprintf(ID,'Mfr_2=answer(2);\n');
fprintf(ID,'Mfr_3=answer(3);\n');
fprintf(ID,'Mfl_1=answer(4);\n');
fprintf(ID,'Mfl_2=answer(5);\n');
fprintf(ID,'Mfl_3=answer(6);\n');
fprintf(ID,'Mhr_1=answer(7);\n');
fprintf(ID,'Mhr_2=answer(8);\n');
fprintf(ID,'Mhr_3=answer(9);\n');
fprintf(ID,'Mhr_4=answer(10);\n');
fprintf(ID,'Mhl_1=answer(11);\n');
fprintf(ID,'Mhl_2=answer(12);\n');
fprintf(ID,'Mhl_3=answer(13);\n');
fprintf(ID,'Mhl_4=answer(14);\n');
fprintf(ID,'Fx_fr=answer(15);\n');
fprintf(ID,'Fy_fr=answer(16);\n');
fprintf(ID,'Fz_fr=answer(17);\n');
fprintf(ID,'Fx_fl=answer(18);\n');
fprintf(ID,'Fy_fl=answer(19);\n');
fprintf(ID,'Fz_fl=answer(20);\n');
fprintf(ID,'Fx_hr=answer(21);\n');
fprintf(ID,'Fy_hr=answer(22);\n');
fprintf(ID,'Fz_hr=answer(23);\n');
fprintf(ID,'Fx_hl=answer(24);\n');
fprintf(ID,'Fy_hl=answer(25);\n');
fprintf(ID,'Fz_hl=answer(26);\n');
fprintf(ID,'end');
fclose(ID);