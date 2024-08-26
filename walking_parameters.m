global SCR
global Rqa Ds
global RJ Rf Rh ceiling_h1_z ceiling_h2_z ceiling_h1_x ceiling_h2_x ceiling_h3_x ceiling_h3_z offset
global delt lg ls lss hss ini T_b
% global lss hss lac hac ldc hdc
global theta_p L_sh_f L_th_f L_th_h_mid L_sh_h lac hac ldc hdc
%% Ratio
Rqa=0.9;
ini = 0.5;
%% Walking Parameters
lss=(0.22/0.35)*Ds;
hss=0.05; % The maximum height of feet in swing phase
lg=sqrt((L_th_h_mid(3)+L_sh_h(3))^2-(0.5*Ds)^2); 
% ls=L_sh+L_th; 
theta_p=0*(pi/180); % maximum angle of pelvis about z axis 
% ceiling_h1_z =0.25; % ceiling height
% ceiling_h2_z =0.20; % ceiling height
% ceiling_h3_z =0.30; % ceiling height
ceiling_h1_x =30*Ds; % ceiling length
ceiling_h2_x =0*Ds; % ceiling length
ceiling_h3_x =0*Ds; % ceiling length
offset = 0.01;
delt=0.01; % Domain of pelvis movemevt in z direction
%% Cost Function
Rf=0.3; 
Rh=0.4; 
%% Counter
global J_min
J_min=1000; % Initial magnitude of goal function
%% Start
lac=lss/2; hac=hss; % (lac,hac) apex point of ankle joint in AC (acceleration) stage
%% End
ldc=lss/2; hdc=hss; % (ldc,hdc) apex point of ankle joint in DC (declaration) stage