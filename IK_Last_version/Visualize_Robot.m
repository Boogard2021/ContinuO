function [] = Visualize_Robot(body_pos, foot_Pos, p_global, color_list)
limit = 1.3;
r_shd = foot_Pos(1:3);
r_hip = foot_Pos(4:6);
r_knee_mid = foot_Pos(7:9);
r_knee = foot_Pos(10:12);
r_ankle = foot_Pos(13:15);

r_shd_hr = body_pos(1:3);
r_shd_hl = body_pos(4:6);
r_shd_fr = body_pos(7:9);
r_shd_fl = body_pos(10:12);

%% Plotting
hold on
grid on
line([-limit limit],[0 0],[0 0],'Color','k','LineStyle','--')
line([0 0],[-limit limit],[0 0],'Color','k','LineStyle','--')
line([0 0],[0 0],[-limit limit],'Color','k','LineStyle','--')

config_joint_0 = r_shd;
config_joint_1 = r_hip;
config_joint_2 = r_knee_mid;
config_joint_3 = r_knee;
config_joint_4 = r_ankle;

line([config_joint_0(1) config_joint_1(1)],[config_joint_0(2) config_joint_1(2)],...
    [config_joint_0(3) config_joint_1(3)],'linewidth', 1,'Color',color_list{1}) %, 'LineStyle', '--'
line([config_joint_1(1) config_joint_2(1)],[config_joint_1(2) config_joint_2(2)],...
    [config_joint_1(3) config_joint_2(3)],'linewidth', 1,'Color',color_list{2})
line([config_joint_2(1) config_joint_3(1)],[config_joint_2(2) config_joint_3(2)],...
    [config_joint_2(3) config_joint_3(3)],'linewidth', 1,'Color',color_list{3})
line([config_joint_3(1) config_joint_4(1)],[config_joint_3(2) config_joint_4(2)],...
    [config_joint_3(3) config_joint_4(3)],'linewidth', 1,'Color',color_list{4})

plot3(config_joint_0(1),config_joint_0(2),config_joint_0(3),'go','linewidth', 4,'MarkerSize',4)
plot3(config_joint_1(1),config_joint_1(2),config_joint_1(3),'go','linewidth', 4,'MarkerSize',4)
plot3(config_joint_2(1),config_joint_2(2),config_joint_2(3),'go','linewidth', 4,'MarkerSize',4)
plot3(config_joint_3(1),config_joint_3(2),config_joint_3(3),'go','linewidth', 4,'MarkerSize',4)
plot3(config_joint_4(1),config_joint_4(2),config_joint_4(3),'go','linewidth', 4,'MarkerSize',4)

plot3(config_joint_0(1),config_joint_0(2),config_joint_0(3),'o')
plot3(config_joint_1(1),config_joint_1(2),config_joint_1(3),'o')
plot3(config_joint_2(1),config_joint_2(2),config_joint_2(3),'o')
plot3(config_joint_3(1),config_joint_3(2),config_joint_3(3),'o')
plot3(config_joint_4(1),config_joint_4(2),config_joint_4(3),'o')

plot3(p_global(1),p_global(2),p_global(3),'r*')

plot3([r_shd_hr(1) r_shd_fr(1) r_shd_fl(1) r_shd_hl(1) r_shd_hr(1)],[r_shd_hr(2) r_shd_fr(2) r_shd_fl(2) r_shd_hl(2) r_shd_hr(2)],[r_shd_hr(3) r_shd_fr(3) r_shd_fl(3) r_shd_hl(3) r_shd_hr(3)],'k','LineWidth',2);
xlim([-3,3])
ylim([-3,3])
zlim([-3,3])
xlabel('x')
ylabel('y')
zlabel('z')
end

