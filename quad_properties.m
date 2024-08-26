% Biped Properties
global L_sh_f L_sh_h L_th_f L_th_h L_th_h_mid L_b W_b L_h L_ff_h L_ff_f L_bb_h L_bb_f
global d_sh_fr d_sh_fl d_sh_hr d_sh_hl d_th_fr d_th_fl d_th_hr d_th_hl d_th_mid_hr d_th_mid_hl d_hip_fr d_hip_fl d_hip_hr d_hip_hl d_b
global m_sh m_th_f m_th_h_mid m_th_h m_hip m_b m_arm m_total
global J_sh_fr J_sh_fl J_sh_hr J_sh_hl J_th_fr J_th_fl J_th_hr J_th_hl J_th_mid_hr J_th_mid_hl J_hip_fr J_hip_fl J_hip_hr J_hip_hl J_b J_arm
global g 
 %% Mass
m_b=10342.49/1000; % Mass of Body
m_hip=1276.28/1000; % Mass of hip
m_sh=759.02/1000; % Mass of shank
m_th_f=1367.54/1000; % Mass of front thigh
m_th_h_mid= 1406.33/1000; % Mass of hind thigh
m_th_h=1315.96/1000; % Mass of middle hind thigh
m_arm=0*500/1000; % Mass of Object
m_total=m_b+m_arm+2*(2*m_hip+2*m_sh+m_th_f+m_th_h+m_th_h_mid);

%% Length OK
L_h=[53.26 61.84 0.1]/1000; % Length of hip

L_th_f=[0 0 246.5]/1000; % Length of front thigh
% L_th_h=[0 46.5 201]/1000; % Length of hind thigh
L_th_h=[0 0 201]/1000; % Length of hind thigh
L_th_h_mid=[0 0 246.5]/1000; % Length of middle hind thigh
% L_th_h_mid=[0 63.5 246.5]/1000; % Length of middle hind thigh

% L_sh_f=[77.21 35 280.67]/1000; % Length of front shank
% L_sh_h=[77.21 35 190.62]/1000; % Length of hind shank  190.62
% L_sh_f=[77.21 81.5 280.67]/1000; % Length of front shank
L_sh_f=[0 0 280.67]/1000; % Length of front shank
% L_sh_h=[77.21 145 190.62]/1000; % Length of hind shank  190.6
L_sh_h=[0 0 190.62]/1000; % Length of hind shank  190.6

L_b=527/1000; % Length of body
W_b=245.81/1000; % Width of body
L_ff_h=369.48/1000; % distance of end_effector to end_effector for hind legs (y direction)
L_ff_f=369.48/1000; % distance of end_effector to end_effector for front legs(y direction)
L_bb_h=316.76/1000;  % distance of body to end_effector for hind legs(x direction)
L_bb_f=316.76/1000;  % distance of body to end_effector for front legs(x direction)
%% Center of Mass
d_sh_fr=[ -41.25,-34.92,-47.57]'/1000; % Center of mass of front right shank
d_sh_fl=[-41.31,34.92,-47.60]'/1000; % Center of mass of left shank
d_sh_hr=[-41.25,-34.92,-47.57]'/1000; % Center of mass of right shank
d_sh_hl=[-41.31,34.92,-47.60]'/1000; % Center of mass of left shank
d_th_fr=[-0.01,-25.63,-165.00]'/1000; % Center of mass of right thigh
d_th_fl=[0.01,25.63,-165.00]'/1000; % Center of mass of left thigh
d_th_hr=[0.00,-25.47,-134.79]'/1000; % Center of mass of right thigh
d_th_hl=[0.00,25.47,-134.79]'/1000; % Center of mass of left thigh
d_th_mid_hr=[0.00,-41.72,-160.77]'/1000; % Center of mass of right thigh
d_th_mid_hl=[0.00,41.72,-160.77]'/1000; % Center of mass of left thigh
d_hip_fr=[51.77,-21.26,0.16]'/1000; % Center of mass of right hip
d_hip_fl=[51.77,21.26,-0.16]'/1000; % Center of mass of left hip
d_hip_hr=[-51.78,-21.26,-0.04]'/1000; % Center of mass of right hip
d_hip_hl=[-51.78,21.26,0.04]'/1000; % Center of mass of left hip

d_b=[-3.11,-0.06,8.44]'/1000; % Center of mass of body

%% Second Moment of Inertia
J_sh_fr=[7967723.06,9977.88,1315723.60;
	     9977.88,9252571.88,2536.62;
	     1315723.60,2536.62,1641940.69]*10^-9; % Second Moment of Inertia of right shank 
    
J_sh_fl=[7966011.91,-9387.70,1312983.56;
	     -9387.70,9247408.95,-2373.51;
	     1312983.56,-2373.51,1638567.05]*10^-9; % Second Moment of Inertia of left shank

J_sh_hr=[7967723.06,9977.88,1315723.60;
	     9977.88,9252571.88,2536.62;
	     1315723.60,2536.62,1641940.69]*10^-9; % Second Moment of Inertia of right shank 
    
J_sh_hl=[7966011.91,-9387.70,1312983.56;
	     -9387.70,9247408.95,-2373.51;
	     1312983.56,-2373.51,1638567.05]*10^-9; % Second Moment of Inertia of left shank

J_th_fr=[16273403.70,-161.14,-12937.36;
	     -161.14,16691309.19,-130585.21;
         -12937.36,-130585.21,1167540.75]*10^-9; % Second Moment of Inertia of right thigh

J_th_fl=[16273403.70,-161.14,12937.36;
         -161.14,16691309.19,130585.21;
	     12937.36,130585.21,1167540.75]*10^-9; % Second Moment of Inertia of left thigh
    
J_th_hr=[11053712.61,-166.90,-13255.15;
	     -166.90,11463665.17,-105489.55;
	     -13255.15,-105489.55,1146965.03]*10^-9; % Second Moment of Inertia of right thigh

J_th_hl=[11053712.61,-166.90,13255.15;
	     -166.90,11463665.17,105489.55;
	     13255.15,105489.55,1146965.03]*10^-9; % Second Moment of Inertia of left thigh    
      
J_th_mid_hr=[17322697.15,-166.30,-13745.85;
	         -166.30,17702007.59,74976.36;
	         -13745.85,74976.36,1218582.60]*10^-9; % Second Moment of Inertia of right thigh

J_th_mid_hl=[17322697.15,-166.30,13745.85;
	         -166.30,17702007.59,-74976.36;
	         13745.85,-74976.36,1218582.60]*10^-9; % Second Moment of Inertia of left thigh 
    
J_hip_fr=[1862413.22,-34307.72,-1836.09;
	      -34307.72,1745876.06,127.53;
	      -1836.09,127.53,1887209.59]*10^-9; % Second Moment of Inertia of right hip
      
J_hip_fl=[1862413.22,34307.72,1836.09;
          34307.72,1745876.06,127.53;
	      1836.09,127.53,1887209.59]*10^-9; % Second Moment of Inertia of left hip
      
J_hip_hr=[1862438.25,34012.00,510.44;
	      34012.00,1745191.99,-556.32;
	      510.44,-556.32,1886523.75]*10^-9; % Second Moment of Inertia of right hip
      
J_hip_hl=[1862438.25,-34012.00,-510.44;
	      -34012.00,1745191.99,-556.32;
	      -510.44,-556.32,1886523.75]*10^-9; % Second Moment of Inertia of left hip
  
J_b=[131477391.56,-35656.79,-257886.74;
     -35656.79,328587491.17,-31766.98;
	 -257886.74,-31766.98,423802600.52]*10^-9; % Second Moment of Inertia of trunk
  
J_arm=[0 0 0;
        0 0 0;
        0 0 0];
%% Physical Parameters

%% Gravity Acceleration
g=[0;0;9.81];      