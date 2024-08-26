function [] = Visualize_Robot(Pos, p_global, color_list)
limit = 1.3;
r_shd = Pos(1:3);
r_hip = Pos(4:6);
r_knee_mid = Pos(7:9);
r_knee = Pos(10:12);
r_ankle = Pos(13:15);

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

% if flag==0
line([config_joint_0(1) config_joint_1(1)],[config_joint_0(2) config_joint_1(2)],...
    [config_joint_0(3) config_joint_1(3)],'linewidth', 1,'Color',color_list{1}) %, 'LineStyle', '--'
line([config_joint_1(1) config_joint_2(1)],[config_joint_1(2) config_joint_2(2)],...
    [config_joint_1(3) config_joint_2(3)],'linewidth', 1,'Color',color_list{2})
line([config_joint_2(1) config_joint_3(1)],[config_joint_2(2) config_joint_3(2)],...
    [config_joint_2(3) config_joint_3(3)],'linewidth', 1,'Color',color_list{3})
line([config_joint_3(1) config_joint_4(1)],[config_joint_3(2) config_joint_4(2)],...
    [config_joint_3(3) config_joint_4(3)],'linewidth', 1,'Color',color_list{4})
% else
%   line([config_joint_0(1) config_joint_1(1)],[config_joint_0(2) config_joint_1(2),],...
%     [config_joint_0(3) config_joint_1(3)],'linewidth', 1,'Color',color_list{1},'LineStyle', '--') %, 'LineStyle', '--'
% line([config_joint_1(1) config_joint_2(1)],[config_joint_1(2) config_joint_2(2)],...
%     [config_joint_1(3) config_joint_2(3)],'linewidth', 1,'Color',color_list{2},'LineStyle', '--')
% line([config_joint_2(1) config_joint_3(1)],[config_joint_2(2) config_joint_3(2)],...
%     [config_joint_2(3) config_joint_3(3)],'linewidth', 1,'Color',color_list{3},'LineStyle', '--')
% line([config_joint_3(1) config_joint_4(1)],[config_joint_3(2) config_joint_4(2)],...
%     [config_joint_3(3) config_joint_4(3)],'linewidth', 1,'Color',color_list{4},'LineStyle', '--')  
% end

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

% text(1.5, 0, 2.8, 'Joint state', 'color', 'red', 'FontSize', 14)
% str = {string(q(1)), string(q(2)), string(q(3)), string(q(4))};
% text(1.6, 0, 1.5, str)
%
% text(2.5, 0, 2.4,'Joint state velocities', 'color', 'blue', 'FontSize', 14)
% str = {string(q_dot(1)), string(q_dot(2)), string(q_dot(3)), string(q_dot(4))};
% text(2.8, 0, 1.05, str)
% %
% % text(1.5, 0, 0, {'End-effector','position'}, 'color', 'red', 'FontSize', 14)
% % str = {string(cur_pos(1)), string(cur_pos(2)), string(cur_pos(3)), string(cur_pos(4)), string(cur_pos(5)), string(cur_pos(6))};
% % text(1.65, 0, -1.35, str)
%
% text(2.6, 0, -0.35, {'End-effector','desired position'}, 'color', 'blue', 'FontSize', 14)
% str = {string(p_global(1)), string(p_global(2)), string(p_global(3))};
% text(2.9, 0, -1.75, str)

xlim([-3,3])
ylim([-3,3])
zlim([-3,3])
xlabel('x')
ylabel('y')
zlabel('z')
%title('KUKA on Linear Axis', 'FontSize', 14)
end

