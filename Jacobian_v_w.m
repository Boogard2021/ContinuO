%% Dynamic_Equation_3D
clear all
close all
clc
%% Parameters Description
syms x_p y_p z_p dx_p dy_p dz_p ddx_p ddy_p ddz_p real
syms alpha_p beta_p gamma_p dalpha_p dbeta_p dgamma_p ddalpha_p ddbeta_p ddgamma_p real
syms q1_fr q2_fr q3_fr q1_fl q2_fl q3_fl dq1_fr dq2_fr dq3_fr dq1_fl dq2_fl dq3_fl ddq1_fr ddq2_fr ddq3_fr ddq1_fl ddq2_fl ddq3_fl real
syms q1_hr q2_hr q3_hr q4_hr q1_hl q2_hl q3_hl q4_hl dq1_hr dq2_hr dq3_hr dq4_hr dq1_hl dq2_hl dq3_hl dq4_hl ddq1_hr ddq2_hr ddq3_hr ddq4_hr ddq1_hl ddq2_hl ddq3_hl ddq4_hl real

syms L_b W_b L_h L_ff_h L_ff_f L_bb_h L_bb_f

syms L_sh_f_x L_sh_h_x L_th_f_x L_th_h_x L_th_h_mid_x L_h_x 
syms L_sh_f_y L_sh_h_y L_th_f_y L_th_h_y L_th_h_mid_y L_h_y 
syms L_sh_f_z L_sh_h_z L_th_f_z L_th_h_z L_th_h_mid_z L_h_z 

% L_h=[L_h_x;L_h_y;L_h_z];L_sh=[L_sh_x;L_sh_y;L_sh_z];
% L_th_f=[L_th_f_x;L_th_f_y;L_th_f_z];L_th_mid_mid=[L_th_h_mid_x;L_th_h_mid_y;L_th_h_mid_z];L_th_h=[L_th_h_x;L_th_h_y;L_th_h_z];

syms d_sh_fr_x d_sh_fl_x d_sh_hr_x d_sh_hl_x d_th_fr_x d_th_fl_x d_th_hr_x d_th_hl_x d_th_mid_hr_x d_th_mid_hl_x d_hip_fr_x d_hip_fl_x d_hip_hr_x d_hip_hl_x d_b_x
syms d_sh_fr_y d_sh_fl_y d_sh_hr_y d_sh_hl_y d_th_fr_y d_th_fl_y d_th_hr_y d_th_hl_y d_th_mid_hr_y d_th_mid_hl_y d_hip_fr_y d_hip_fl_y d_hip_hr_y d_hip_hl_y d_b_y
syms d_sh_fr_z d_sh_fl_z d_sh_hr_z d_sh_hl_z d_th_fr_z d_th_fl_z d_th_hr_z d_th_hl_z d_th_mid_hr_z d_th_mid_hl_z d_hip_fr_z d_hip_fl_z d_hip_hr_z d_hip_hl_z d_b_z

d_sh_fr=[d_sh_fr_x;d_sh_fr_y;d_sh_fr_z];d_sh_fl=[d_sh_fl_x;d_sh_fl_y;d_sh_fl_z];d_sh_hr=[d_sh_hr_x;d_sh_hr_y;d_sh_hr_z];d_sh_hl=[d_sh_hl_x;d_sh_hl_y;d_sh_hl_z];
d_th_fr=[d_th_fr_x;d_th_fr_y;d_th_fr_z];d_th_fl=[d_th_fl_x;d_th_fl_y;d_th_fl_z];d_th_hr=[d_th_hr_x;d_th_hr_y;d_th_hr_z];d_th_hl=[d_th_hl_x;d_th_hl_y;d_th_hl_z];
d_th_mid_hr=[d_th_mid_hr_x;d_th_mid_hr_y;d_th_mid_hr_z];d_th_mid_hl=[d_th_mid_hl_x;d_th_mid_hl_y;d_th_mid_hl_z];
d_hip_fr=[d_hip_fr_x;d_hip_fr_y;d_hip_fr_z];d_hip_fl=[d_hip_fl_x;d_hip_fl_y;d_hip_fl_z];d_hip_hr=[d_hip_hr_x;d_hip_hr_y;d_hip_hr_z];d_hip_hl=[d_hip_hl_x;d_hip_hl_y;d_hip_hl_z];
d_b=[d_b_x;d_b_y;d_b_z];

syms tau1_fr tau2_fr tau3_fr tau1_fl tau2_fl tau3_fl real
syms tau1_hr tau2_hr tau3_hr tau4_hr tau1_hl tau2_hl tau3_hl tau4_hl real
tau_fr=[tau1_fr tau2_fr tau3_fr]';
tau_fl=[tau1_fl tau2_fl tau3_fl]';
tau_hr=[tau1_hr tau2_hr tau3_hr tau4_hr]';
tau_hl=[tau1_hl tau2_hl tau3_hl tau4_hl]';

% tau_r=[tau_fr;tau_hl];  
% tau_l=[tau_fl;tau_hr];  

syms gx gy gz real;
g=[gx;gy;gz];
    
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
%% Translation Matrix
% Trunk
P_p = trans([],[x_p,y_p,z_p]');
P_p_c = trans([],[d_b_x;d_b_y;d_b_z]);
% Front Right
P_sho_fr = trans([],0.5*[L_b,-W_b,0]');
P_hip_c_fr= trans([],d_hip_fr);
P_hip_fr = trans([],[L_h_x,-L_h_y,-L_h_z]);
P_th_c_fr = trans([],d_th_fr);
P_th_fr = trans([],[L_th_f_x,-L_th_f_y,-L_th_f_z]);
P_sh_c_fr = trans([],d_sh_fr);
P_sh_fr = trans([],[-L_sh_f_x,-L_sh_f_y,-L_sh_f_z]);

% Front Left
P_sho_fl = trans([],0.5*[L_b,W_b,0]);
P_hip_c_fl= trans([],d_hip_fl);
P_hip_fl = trans([],[L_h_x,L_h_y,-L_h_z]);
P_th_c_fl = trans([],d_th_fl);
P_th_fl = trans([],[L_th_f_x,L_th_f_y,-L_th_f_z]);
P_sh_c_fl = trans([],d_sh_fl);
P_sh_fl = trans([],[-L_sh_f_x,L_sh_f_y,-L_sh_f_z]);

% Hind Right
P_sho_hr = trans([],0.5*[-L_b,-W_b,0]);
P_hip_c_hr= trans([],d_hip_hr);
P_hip_hr = trans([],[-L_h_x,-L_h_y,-L_h_z]);
P_th_c_hr = trans([],d_th_hr);
P_th_hr = trans([],[-L_th_h_x,-L_th_h_y,-L_th_h_z]);
P_th_mid_c_hr = trans([],d_th_mid_hr);
P_th_mid_hr = trans([],[-L_th_h_mid_x,-L_th_h_mid_y,-L_th_h_mid_z]);
P_sh_c_hr = trans([],d_sh_hr);
P_sh_hr = trans([],[-L_sh_h_x,-L_sh_h_y,-L_sh_h_z]);

% Hind Left
P_sho_hl = trans([],0.5*[-L_b,W_b,0]);
P_hip_c_hl= trans([],d_hip_hl);
P_hip_hl = trans([],[-L_h_x,L_h_y,-L_h_z]);
P_th_c_hl = trans([],d_th_hl);
P_th_hl = trans([],[-L_th_h_x,L_th_h_y,-L_th_h_z]);
P_th_mid_c_hl = trans([],d_th_mid_hl);
P_th_mid_hl = trans([],[-L_th_h_mid_x,L_th_h_mid_y,-L_th_h_mid_z]);
P_sh_c_hl = trans([],d_sh_hl);
P_sh_hl = trans([],[-L_sh_h_x,L_sh_h_y,-L_sh_h_z]);
%% Position
r_b=        P_p*R0*P_p_c*[0;0;0;1];

r_hip_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_c_fr*[0;0;0;1];
r_hip_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_c_fl*[0;0;0;1];
r_hip_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_c_hr*[0;0;0;1];
r_hip_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_c_hl*[0;0;0;1];

r_th_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_c_fr*[0;0;0;1];
r_th_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_c_fl*[0;0;0;1];
r_th_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_c_hr*[0;0;0;1];
r_th_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_c_hl*[0;0;0;1];
r_th_mid_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_hr*Rq3_hr*P_th_mid_c_hr*[0;0;0;1];
r_th_mid_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_hl*Rq3_hl*P_th_mid_c_hl*[0;0;0;1];

r_sh_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_fr*Rq3_fr*P_sh_c_fr*[0;0;0;1];
r_sh_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_fl*Rq3_fl*P_sh_c_fl*[0;0;0;1];
r_sh_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_hr*Rq3_hr*P_th_mid_hr*Rq4_hr*P_sh_c_hr*[0;0;0;1];
r_sh_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_hl*Rq3_hl*P_th_mid_hl*Rq4_hl*P_sh_c_hl*[0;0;0;1];

% end_effector positions
r_ft_fr=   P_p*R0*P_sho_fr*Rq1_fr*P_hip_fr*Rq2_fr*P_th_fr*Rq3_fr*P_sh_fr*[0;0;0;1];
r_ft_fl=   P_p*R0*P_sho_fl*Rq1_fl*P_hip_fl*Rq2_fl*P_th_fl*Rq3_fl*P_sh_fl*[0;0;0;1];
r_ft_hr=   P_p*R0*P_sho_hr*Rq1_hr*P_hip_hr*Rq2_hr*P_th_hr*Rq3_hr*P_th_mid_hr*Rq4_hr*P_sh_hr*[0;0;0;1];
r_ft_hl=   P_p*R0*P_sho_hl*Rq1_hl*P_hip_hl*Rq2_hl*P_th_hl*Rq3_hl*P_th_mid_hl*Rq4_hl*P_sh_hl*[0;0;0;1]; 

rc0=[r_b(1:3)];
rcfr= [r_hip_fr(1:3) r_th_fr(1:3) r_sh_fr(1:3)];
rcfl= [r_hip_fl(1:3) r_th_fl(1:3) r_sh_fl(1:3)];
rchr= [r_hip_hr(1:3) r_th_hr(1:3) r_th_mid_hr(1:3) r_sh_hr(1:3)];
rchl= [r_hip_hl(1:3) r_th_hl(1:3) r_th_mid_hl(1:3) r_sh_hl(1:3)];

% rcr=[r_hip_fr(1:3) r_th_fr(1:3) r_sh_fr(1:3) r_hip_hl(1:3) r_th_hl(1:3) r_th_mid_hl(1:3) r_sh_hl(1:3)];
% rcl=[r_hip_fl(1:3) r_th_fl(1:3) r_sh_fl(1:3) r_hip_hr(1:3) r_th_hr(1:3) r_th_mid_hr(1:3) r_sh_hr(1:3)];
%% Center of Mass Velocity
clear q dq ddq
q=[x_p y_p z_p alpha_p beta_p gamma_p q1_fr q2_fr q3_fr q1_fl q2_fl q3_fl q1_hr q2_hr q3_hr q4_hr q1_hl q2_hl q3_hl q4_hl]';
dq=[dx_p dy_p dz_p dalpha_p dbeta_p dgamma_p dq1_fr dq2_fr dq3_fr dq1_fl dq2_fl dq3_fl dq1_hr dq2_hr dq3_hr dq4_hr dq1_hl dq2_hl dq3_hl dq4_hl]';
ddq=[ddx_p ddy_p ddz_p ddalpha_p ddbeta_p ddgamma_p ddq1_fr ddq2_fr ddq3_fr ddq1_fl ddq2_fl ddq3_fl ddq1_hr ddq2_hr ddq3_hr ddq4_hr ddq1_hl ddq2_hl ddq3_hl ddq4_hl]';

i0=1;irl=3;irr=4;
for j=1:i0
Vc0(:,j)=jacobian(rc0(:,j),q)*dq;
end

for i=1:irl
Vcfr(:,i)=jacobian(rcfr(:,i),q)*dq; 
Vcfl(:,i)=jacobian(rcfl(:,i),q)*dq;
end
for i=1:irr
Vchr(:,i)=jacobian(rchr(:,i),q)*dq; 
Vchl(:,i)=jacobian(rchl(:,i),q)*dq;
end
Vc=[Vc0 Vcfr Vcfl Vchr Vchl];
%% Angular Velocity of Links
%% Angular Velocity
w_b=[0;dbeta_p;0]+R_p_y(1:3,1:3)*[0;0;dgamma_p]+R_p_y(1:3,1:3)*R_p_z(1:3,1:3)*[dalpha_p;0;0];

w_hip_fr=w_b+R0_fr(1:3,1:3)*[dq1_fr;0;0];
w_th_fr=w_hip_fr+R1_fr(1:3,1:3)*[0;dq2_fr;0];
w_sh_fr=w_th_fr+R2_fr(1:3,1:3)*[0;dq3_fr;0];

w_hip_fl=w_b+R0_fl(1:3,1:3)*[dq1_fl;0;0];
w_th_fl=w_hip_fl+R1_fl(1:3,1:3)*[0;dq2_fl;0];
w_sh_fl=w_th_fl+R2_fl(1:3,1:3)*[0;dq3_fl;0];

w_hip_hr=w_b+R0_hr(1:3,1:3)*[dq1_hr;0;0];
w_th_hr=w_hip_hr+R1_hr(1:3,1:3)*[0;dq2_hr;0];
w_th_mid_hr=w_th_hr+R2_hr(1:3,1:3)*[0;dq3_hr;0];
w_sh_hr=w_th_mid_hr+R3_hr(1:3,1:3)*[0;dq4_hr;0];

w_hip_hl=w_b+R0_hl(1:3,1:3)*[dq1_hl;0;0];
w_th_hl=w_hip_hl+R1_hl(1:3,1:3)*[0;dq2_hl;0];
w_th_mid_hl=w_th_hl+R2_hl(1:3,1:3)*[0;dq3_hl;0];
w_sh_hl=w_th_mid_hl+R3_hl(1:3,1:3)*[0;dq4_hl;0];

% w_ft_r=[w_sh_fr;w_sh_hl];
% w_ft_l=[w_sh_fl;w_sh_hr];

% w00=[w_b];
% wr0=[w_hip_fr  w_th_fr  w_sh_fr  w_hip_hl  w_th_hl  w_th_mid_hl w_sh_hl];
% wl0=[w_hip_fl  w_th_fl  w_sh_fl  w_hip_hr  w_th_hr  w_th_mid_hr w_sh_hr];
% 
% 
% w_body_0=[w00 wr0 wl0];

w00=[w_b];
wfr=[w_hip_fr  w_th_fr  w_sh_fr];
wfl=[w_hip_fl  w_th_fl  w_sh_fl];
whr=[w_hip_hr  w_th_hr w_th_mid_hr  w_sh_hr];
whl=[w_hip_hl  w_th_hl w_th_mid_hl  w_sh_hl];

wc=[w00 wfr wfl whr whl];
%% Jacobian Term
size(Vc)
size(jacobian(Vc(:,1),dq))

for j=1:15
    J_Vc(:,20*(j-1)+1:20*j)=jacobian(Vc(:,j),dq);
    J_wc(:,20*(j-1)+1:20*j)=jacobian(wc(:,j),dq);
end

J_v_e_fr=jacobian(r_ft_fr(1:3),q);
J_v_e_fl=jacobian(r_ft_fl(1:3),q);
J_v_e_hr=jacobian(r_ft_hr(1:3),q);
J_v_e_hl=jacobian(r_ft_hl(1:3),q);


%% Right Term
Qf=sym(zeros(20,1));Qh=sym(zeros(20,1));

for i=1:3
    Qf=Qf+jacobian(dq(i+6),dq)'.*tau_fr(i)+jacobian(dq(i+9),dq)'.*tau_fl(i);
end
for i=1:4
    Qh=Qh+jacobian(dq(i+12),dq)'.*tau_hr(i)+jacobian(dq(i+16),dq)'.*tau_hl(i);
end
Right=Qf+Qh;

tau=[tau_fr;tau_fl;tau_hr;tau_hl];
B=jacobian(Right,tau);

%% Output
clc
J_Vc=reshape(J_Vc,1,3*20*15);
% J_Vc=subs(J_Vc1,{alpha_p,beta_p,gamma_p,dalpha_p,dbeta_p,dgamma_p,ddalpha_p,ddbeta_p,ddgamma_p},{0,0,0,0,0,0,0,0,0}); 
diary('JJ_Vc.m')
J_Vc
diary off
clear J_Vc

clc
J_wc=reshape(J_wc,1,3*20*15);
diary('JJ_wc.m')
J_wc
diary off
clear J_wc

clc
J_e_fr=reshape(J_v_e_fr,1,3*20);
diary('JJ_e_fr.m')
J_e_fr
diary off
clear J_e_fr

clc
J_e_fl=reshape(J_v_e_fl,1,3*20);
diary('JJ_e_fl.m')
J_e_fl
diary off
clear J_e_fl

clc
J_e_hr=reshape(J_v_e_hr,1,3*20);
diary('JJ_e_hr.m')
J_e_hr
diary off
clear J_e_hr

clc
J_e_hl=reshape(J_v_e_hl,1,3*20);
diary('JJ_e_hl.m')
J_e_hl
diary off
clear J_e_hl

clear Right
clc
B=reshape(B,1,20*14);
diary('BB.m')
B
diary off
clear B

clc
disp('Done!')