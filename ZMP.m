function Z=ZMP(O)
% size(O)
%% Input
% size(O)
% COM
v_=O(1:45);%1:45;

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

% dPH
dPH=O(46:135);  % 
dP=reshape(dPH(1:45),3,15);    % linear momentum
dH_body=reshape(dPH(46:90),3,15);    % angular momentum
dH=[dH_body];

% Trajectory  1:57
v=O(136:192);

r_b=v(1:3);
r_shd_fr=v(4:6);
r_shd_fl=v(7:9);
r_shd_hr=v(10:12);
r_shd_hl=v(13:15);
r_hip_fr=v(16:18);
r_hip_fl=v(19:21);
r_hip_hr=v(22:24);
r_hip_hl=v(25:27);
r_knee_fr=v(28:30);
r_knee_fl=v(31:33);
r_knee_hr=v(34:36);
r_knee_hl=v(37:39);
r_knee_mid_hr=v(40:42);
r_knee_mid_hl=v(43:45);
r_ankle_fr=v(46:48);
r_ankle_fl=v(49:51);
r_ankle_hr=v(52:54);
r_ankle_hl=v(55:57);
  
% Time
t=O(193);

a_=O(194:238);%1:45;

a_sh_fr=a_(1:3);
a_sh_fl=a_(4:6);
a_sh_hr=a_(7:9);
a_sh_hl=a_(10:12);
a_th_fr=a_(13:15);
a_th_fl=a_(16:18);
a_th_hr=a_(19:21);
a_th_hl=a_(22:24);
a_th_mid_hr=a_(25:27);
a_th_mid_hl=a_(28:30);
a_hip_fr=a_(31:33);
a_hip_fl=a_(34:36);
a_hip_hr=a_(37:39);
a_hip_hl=a_(40:42);
a_b=a_(43:45);

a_COG_0=[a_b];
a_COG_r=[a_hip_fr a_th_fr a_sh_fr a_hip_fl a_th_fl a_sh_fl];
a_COG_l=[a_hip_hr a_th_hr a_th_mid_hr a_sh_hr a_hip_hl a_th_hl a_th_mid_hl a_sh_hl];
a_COG=[a_COG_0 a_COG_r a_COG_l];

ddq1=O(239:252); % Joints angles and velocity
ddq = [ddq1;0];
%% Global
global Tc Td T_ac T_ac_a_a
global m_sh m_th_f m_th_h_mid m_th_h m_hip m_b
global g
global N
global J_sh_fr J_sh_fl J_sh_hr J_sh_hl J_th_fr J_th_fl J_th_hr J_th_hl J_th_mid_hr J_th_mid_hl J_hip_fr J_hip_fl J_hip_hr J_hip_hl J_b 
%% ZMP relation
J = [J_hip_fr J_th_fr J_sh_fr J_hip_fl J_th_fl J_sh_fl J_hip_hr J_th_hr J_th_mid_hr J_sh_hr J_hip_hl J_th_hl J_th_mid_hl J_sh_hl J_b];

m0=[m_b];
mr=[m_hip m_th_f m_sh m_hip m_th_f m_sh];
ml=[m_hip m_th_h m_th_h_mid m_sh m_hip m_th_h m_th_h_mid m_sh];

m=[m0 mr ml];

r_COG_0=[v_b];
r_COG_r=[v_hip_fr v_th_fr v_sh_fr v_hip_fl v_th_fl v_sh_fl];
r_COG_l=[v_hip_hr v_th_hr v_th_mid_hr v_sh_hr v_hip_hl v_th_hl v_th_mid_hl v_sh_hl];

r_COG=[r_COG_0 r_COG_r r_COG_l];
Nu=zeros(3,1);
De=zeros(3,1);
for i=1:15
    r_COG_i=r_COG(:,i);
    mi=m(i);
    dP_i=dP(:,i);
    Nu=Nu+cross(r_COG_i,dP_i+mi*g);
    De=De+(dP_i+mi*g);
end
Nu=Nu+sum(dH')';
r_zmp=[-Nu(2);Nu(1)]/(De'*[0;0;1]); % Flat

%Another way
% sum_x = 0;
% sum1_x = 0; 
% for i=1:15
%     z_COG_i = r_COG(3,i);
%     mi = m(i);
%     JJ = J(1:3,3*(i-1)+1:3*i);
%     ss(i)= mi*(a_COG(3,i)+g(3))*r_COG(1,i)-mi*z_COG_i*a_COG(1,i)-JJ(5)*ddq(i);
%     sum_x = sum_x+ss(i);
%     s(i)= mi*(a_COG(3,i)+g(3));
%     sum1_x= sum1_x+s(i);
% end
% Xzmp= sum_x/sum1_x;
% 
% sum_y = 0;
% sum1_y = 0; 
% for i=1:15
%     z_COG_i = r_COG(3,i);
%     mi = m(i);
%     JJ = J(1:3,3*(i-1)+1:3*i);
%     ss(i)= mi*(a_COG(3,i)+g(3))*r_COG(2,i)-mi*z_COG_i*a_COG(2,i)-JJ(5)*ddq(i);
%     sum_y = sum_y+ss(i);
%     s(i)= mi*(a_COG(3,i)+g(3));
%     sum1_y= sum1_y+s(i);
% end
% Yzmp= sum_y/sum1_y;
% r_zmp= [Xzmp,Yzmp]';
%% Center of COM
NNu=zeros(3,1);
for i=1:15
    r_COG_i=r_COG(:,i);
    mi=m(i);
    NNu=NNu+mi*r_COG_i;
end
r_com=NNu/sum(m);
x=r_com(1);
y=r_com(2);
z=r_com(3);
%% Extracting T
if or(t<=T_ac,t>(T_ac+N*2*Tc))
    T=t;
else
    T=rem((t-T_ac),2*Tc)+T_ac;
end
%% Support polygon Boundary     1: double support 2: HR/FL legs (Swing phase) 3: HL/FR legs (Swing phase)
% if T<=T_ac_a_a
%     p_i=1; % 2 leg
% elseif and(T>=T_ac_a_a,T<=T_ac)
%     p_i=2; % R leg
if and(T>=T_ac,T<=(Td+T_ac))   
    p_i=1; % 2 leg
elseif and(T>=(Td+T_ac),T<=(Tc+T_ac))   
    p_i=2;    % HL/FR legs (Swing phase)
elseif and(T>=(Tc+T_ac),T<=(Tc+Td+T_ac))   
    p_i=1;  % 2 leg
elseif and(T>=(Tc+Td+T_ac),T<=(2*Tc+T_ac))
    p_i=3;  % HR/FL legs (Swing phase)
% elseif and(T>=(T_ac+N*2*Tc),T<(T_ac+N*2*Tc+T_dc_a_a))    
%     p_i=1;  % 2 leg
% elseif and(T>=(T_ac+N*2*Tc+T_dc_a_a),T<=(T_ac+N*2*Tc+T_dc_a_c))
%     p_i=3;  % L leg
% elseif T>=(T_ac+N*2*Tc+T_dc_a_c)    
%     p_i=1;   % 2 leg
end
% p_i
% pause
if p_i == 1 % double support
    d = abs(r_zmp(2));
elseif p_i == 2  %  HL/FR legs (Swing phase)
    p_fl = r_ankle_fl;
    p_hr = r_ankle_hr;
    coefficients1 = polyfit([p_fl(1), p_hr(1)], [p_fl(2), p_hr(2)], 1); % y= a*x +b
    a1 = coefficients1(1);
    b1 = coefficients1(2);
    d = abs(-r_zmp(2)+a1*r_zmp(1)+b1)/(sqrt(a1^2+1));
elseif p_i == 3 % HR/FL legs (Swing phase)
    p_fr = r_ankle_fr;
    p_hl = r_ankle_hl;
    coefficients = polyfit([p_fr(1), p_hl(1)], [p_fr(2), p_hl(2)], 1); % y= a*x +b
    a = coefficients(1);
    b = coefficients(2);
    d = abs(-r_zmp(2)+a*r_zmp(1)+b)/(sqrt(a^2+1));
end
%% Output
Z=[r_zmp' d];
% pause
end