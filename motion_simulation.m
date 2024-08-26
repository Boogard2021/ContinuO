function motion_simulation
%% Input
global Ds Motion_Time
global W_b ceiling_h1_z ceiling_h2_z ceiling_h3_z ceiling_h1_x ceiling_h2_x ceiling_h3_x 
global N

sim('test_trajectories',Motion_Time)
% sim('test_trajectories_num',Motion_Time)
r=simout1.signals.values;
t=simout1.time;


r_b = r(:,1:3);
r_shd_fr = r(:,4:6);
r_shd_fl = r(:,7:9);
r_shd_hr = r(:,10:12);
r_shd_hl = r(:,13:15);
r_hip_fr = r(:,16:18);
r_hip_fl = r(:,19:21);
r_hip_hr = r(:,22:24);
r_hip_hl = r(:,25:27);
r_knee_fr = r(:,28:30);
r_knee_fl = r(:,31:33);
r_knee_mid_hr = r(:,34:36);
r_knee_mid_hl = r(:,37:39);
r_knee_hr = r(:,40:42);
r_knee_hl = r(:,43:45);
r_ankle_fr = r(:,46:48);
r_ankle_fl = r(:,49:51);
r_ankle_hr = r(:,52:54);
r_ankle_hl = r(:,55:57);

%% prespective view
% az = 45;
% el = 25;
%% front view
% az = 90;  
% el = 0;
%% side view
az = 0;  
el = 0;
%% 3D PLOT
% N=floor(t(end-1)-T_ac-T_dc-Td/(2*Tc));
j=1;

% figure
k=5;
% x_p=r_p(:,1);
% X_p=(min(x_p):(max(x_p)-min(x_p))/k:max(x_p))';

for u=1:k:length(t)
    %     [ti,i]=min(abs(x_p-X_p(u)));
    i=u;
    j=j+1;
    
    %% Links
    
    plot3([r_shd_fr(i,1) r_shd_fl(i,1) r_shd_hl(i,1) r_shd_hr(i,1) r_shd_fr(i,1)],[r_shd_fr(i,2) r_shd_fl(i,2) r_shd_hl(i,2) r_shd_hr(i,2) r_shd_fr(i,2)],[r_shd_fr(i,3) r_shd_fl(i,3) r_shd_hl(i,3) r_shd_hr(i,3) r_shd_fr(i,3)],'k','LineWidth',2);
    hold on
    plot3([r_shd_fr(i,1) r_hip_fr(i,1)],[r_shd_fr(i,2) r_hip_fr(i,2)],[r_shd_fr(i,3) r_hip_fr(i,3)],'m','LineWidth',2);
    plot3([r_shd_hr(i,1) r_hip_hr(i,1)],[r_shd_hr(i,2) r_hip_hr(i,2)],[r_shd_hr(i,3) r_hip_hr(i,3)],'m','LineWidth',2);
    plot3([r_shd_hl(i,1) r_hip_hl(i,1)],[r_shd_hl(i,2) r_hip_hl(i,2)],[r_shd_hl(i,3) r_hip_hl(i,3)],'m','LineWidth',2);
    plot3([r_shd_fl(i,1) r_hip_fl(i,1)],[r_shd_fl(i,2) r_hip_fl(i,2)],[r_shd_fl(i,3) r_hip_fl(i,3)],'m','LineWidth',2);
    
    plot3([r_hip_fr(i,1) r_knee_fr(i,1)],[r_hip_fr(i,2) r_knee_fr(i,2)],[r_hip_fr(i,3) r_knee_fr(i,3)],'b','LineWidth',2);
    plot3([r_hip_hr(i,1) r_knee_mid_hr(i,1)],[r_hip_hr(i,2) r_knee_mid_hr(i,2)],[r_hip_hr(i,3) r_knee_mid_hr(i,3)],'b','LineWidth',2);
    plot3([r_hip_hl(i,1) r_knee_mid_hl(i,1)],[r_hip_hl(i,2) r_knee_mid_hl(i,2)],[r_hip_hl(i,3) r_knee_mid_hl(i,3)],'b','LineWidth',2);
    plot3([r_hip_fl(i,1) r_knee_fl(i,1)],[r_hip_fl(i,2) r_knee_fl(i,2)],[r_hip_fl(i,3) r_knee_fl(i,3)],'b','LineWidth',2);
        
    plot3([r_knee_fr(i,1) r_ankle_fr(i,1)],[r_knee_fr(i,2) r_ankle_fr(i,2)],[r_knee_fr(i,3) r_ankle_fr(i,3)],'r','LineWidth',2);
    plot3([r_knee_hr(i,1) r_ankle_hr(i,1)],[r_knee_hr(i,2) r_ankle_hr(i,2)],[r_knee_hr(i,3) r_ankle_hr(i,3)],'r','LineWidth',2);
    plot3([r_knee_hl(i,1) r_ankle_hl(i,1)],[r_knee_hl(i,2) r_ankle_hl(i,2)],[r_knee_hl(i,3) r_ankle_hl(i,3)],'r','LineWidth',2);
    plot3([r_knee_fl(i,1) r_ankle_fl(i,1)],[r_knee_fl(i,2) r_ankle_fl(i,2)],[r_knee_fl(i,3) r_ankle_fl(i,3)],'r','LineWidth',2);
    plot3([r_knee_mid_hr(i,1) r_knee_hr(i,1)],[r_knee_mid_hr(i,2) r_knee_hr(i,2)],[r_knee_mid_hr(i,3) r_knee_hr(i,3)],'b','LineWidth',2);
    plot3([r_knee_mid_hl(i,1) r_knee_hl(i,1)],[r_knee_mid_hl(i,2) r_knee_hl(i,2)],[r_knee_mid_hl(i,3) r_knee_hl(i,3)],'b','LineWidth',2);

    ceiling_h_x = ceiling_h1_x+ceiling_h2_x+ceiling_h3_x; %+2*N*Ds*[0 1 1 0 0]
    plot3(-5*Ds+[0 ceiling_h_x ceiling_h_x 0 0],1.5*[-W_b -W_b W_b W_b -W_b],-0.005*[1 1 1 1 1],'k','LineWidth',2)
%     plot3(-4*Ds+[ceiling_h1_x ceiling_h1_x ceiling_h1_x ceiling_h1_x 0],3*[-W_b -W_b W_b W_b -W_b],[ceiling_h1_z ceiling_h1_z ceiling_h1_z ceiling_h1_z ceiling_h1_z],'k','LineWidth',2) %+2*N*Ds*[0 1 1 0 0]
%     plot3(-4*Ds+ceiling_h1_x+[0 0 0 0 0],3*[-W_b -W_b W_b W_b -W_b],[ceiling_h1_z ceiling_h2_z ceiling_h2_z ceiling_h1_z ceiling_h1_z],'k','LineWidth',2) %+2*N*Ds*[0 1 1 0 0]
%     plot3(-4*Ds+ceiling_h1_x+[0 +ceiling_h2_x +ceiling_h2_x 0 0],3*[-W_b -W_b W_b W_b -W_b],[ceiling_h2_z ceiling_h2_z ceiling_h2_z ceiling_h2_z ceiling_h2_z],'k','LineWidth',2)
%     plot3(-4*Ds+ceiling_h1_x+ceiling_h2_x+[0 0 0 0 0],3*[-W_b -W_b W_b W_b -W_b],[ceiling_h2_z ceiling_h3_z ceiling_h3_z ceiling_h2_z ceiling_h2_z],'k','LineWidth',2)
%     plot3(-4*Ds+ceiling_h1_x+ceiling_h2_x+[0 ceiling_h3_x ceiling_h3_x 0 0],3*[-W_b -W_b W_b W_b -W_b],[ceiling_h3_z ceiling_h3_z ceiling_h3_z ceiling_h3_z ceiling_h3_z],'k','LineWidth',2)
    %% Center of Mass
    %     plot3(r_foot_r(i,1),r_foot_r(i,2),r_foot_r(i,3),'ok','LineWidth',1)
    %     plot3(r_unia_r(i,1),r_unia_r(i,2),r_unia_r(i,3),'ok','LineWidth',1)
    %     plot3(r_sh_r(i,1),r_sh_r(i,2),r_sh_r(i,3),'ok','LineWidth',1)
    %     plot3(r_th_r(i,1),r_th_r(i,2),r_th_r(i,3),'ok','LineWidth',1)
    %     plot3(r_unih_r(i,1),r_unih_r(i,2),r_unih_r(i,3),'ok','LineWidth',1)
    %     plot3(r_hip_r(i,1),r_hip_r(i,2),r_hip_r(i,3),'ok','LineWidth',1)
    %
    %     plot3(r_foot_l(i,1),r_foot_l(i,2),r_foot_l(i,3),'ok','LineWidth',1)
    %     plot3(r_unia_l(i,1),r_unia_l(i,2),r_unia_l(i,3),'ok','LineWidth',1)
    %     plot3(r_sh_l(i,1),r_sh_l(i,2),r_sh_l(i,3),'ok','LineWidth',1)
    %     plot3(r_th_l(i,1),r_th_l(i,2),r_th_l(i,3),'ok','LineWidth',1)
    %     plot3(r_unih_l(i,1),r_unih_l(i,2),r_unih_l(i,3),'ok','LineWidth',1)
    %     plot3(r_hip_l(i,1),r_hip_l(i,2),r_hip_l(i,3),'ok','LineWidth',1)
    %     plot3(r_tr(i,1),r_tr(i,2),r_tr(i,3),'ok','LineWidth',1)
    %% Settings
    view(az, el);
%     view(90, 0);
    axis(0.45*[-3.6 3.6 -1.8 1.8 -2.4 2.4],'square')
    axis square
    axis off
    grid off
    figure(gcf)
    drawnow
    hold off
    %% Save Frames
    Fi(j-1)=getframe;   
    if i==1
        pause
        %     pause(3)
    end
end
hold off
end