close all
global m
global Tc Td Tm Ts Ds V
global W_ff Step_Time
global Motion_Time
global N
%%
K_deg=180/pi;
K_rpm=30/pi;
if m==1
    sim('test_taskspace_traj',Motion_Time)
    v=simout1.signals.values;
    t=simout1.time;
    
    w=v(:,1:18);
    dw=v(:,19:36);
    ddw=v(:,37:54);
    
    w(:,4:6)=K_deg*w(:,4:6); % rad ---> deg
    dw(:,4:6)=K_rpm*dw(:,4:6); % rad/s ---> rpm
    
    P.x=w(:,1);               P.y=w(:,2);               P.z=w(:,3);
    P.alpha=w(:,4);           P.beta=w(:,5);            P.gamma=w(:,6);
    A.fr.x=w(:,7);            A.fr.y=w(:,8);            A.fr.z=w(:,9);
    A.fl.x=w(:,10);           A.fl.y=w(:,11);           A.fl.z=w(:,12);
    A.hr.x=w(:,13);           A.hr.y=w(:,14);           A.hr.z=w(:,15);
    A.hl.x=w(:,16);           A.hl.y=w(:,17);           A.hl.z=w(:,18);
    
    P.dx=dw(:,1);             P.dy=dw(:,2);             P.dz=dw(:,3);
    P.dalpha=dw(:,4);         P.dbeta=dw(:,5);          P.dgamma=dw(:,6);
    A.fr.dx=dw(:,7);          A.fr.dy=dw(:,8);          A.fr.dz=dw(:,9);
    A.fl.dx=dw(:,10);         A.fl.dy=dw(:,11);         A.fl.dz=dw(:,12);
    A.hr.dx=dw(:,13);         A.hr.dy=dw(:,14);         A.hr.dz=dw(:,15);
    A.hl.dx=dw(:,16);         A.hl.dy=dw(:,17);         A.hl.dz=dw(:,18);
    
    P.ddx=ddw(:,1);           P.ddy=ddw(:,2);           P.ddz=ddw(:,3);
    P.ddalpha=ddw(:,4);       P.ddbeta=ddw(:,5);        P.ddgamma=ddw(:,6);
    A.fr.ddx=ddw(:,7);        A.fr.ddy=ddw(:,8);        A.fr.ddz=ddw(:,9);
    A.fl.ddx=ddw(:,10);       A.fl.ddy=ddw(:,11);       A.fl.ddz=ddw(:,12);
    A.hr.ddx=ddw(:,13);       A.hr.ddy=ddw(:,14);       A.hr.ddz=ddw(:,15);
    A.hl.ddx=ddw(:,16);       A.hl.ddy=ddw(:,17);       A.hl.ddz=ddw(:,18);
    
    time=t; x_fr=A.fr.x; y_fr=A.fr.y; z_fr=A.fr.z;
    save('Ankle_Position_fr.mat','time','x_fr','y_fr','z_fr')
    clear x_fr y_fr z_fr
    
    time=t; x_fl=A.fl.x; y_fl=A.fl.y; z_fl=A.fl.z;
    save('Ankle_Position_fl.mat','time','x_fl','y_fl','z_fl')
    clear x_fl y_fl z_fl
    
    x_p=P.x; y_p=P.y; z_p=P.z;
    save('Pelvis_Position.mat','time','x_p','y_p','z_p')
    clear time x_p y_p z_p
    
    %%% Pelvis
    figure
    
    %     subplot(3,1,[2 3])
    plot(t,P.x,'b','LineWidth',2);
    xlabel('time (sec)','FontWeight','bold')
    ylabel('x_p (m)')
    title({'Pelvis Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\1.png')
    
    figure
    subplot(3,1,[2 3])
    plot(t,P.y,'b','LineWidth',2);
    xlabel('time (sec)')
    ylabel('y_p (m)')
    title({'Pelvis Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\2.png')
    
    figure
    subplot(3,1,[2 3])
    plot(t,P.z,'b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_p (m)')
    title({'Pelvis Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\3.png')
    
    figure
    subplot(3,1,[2 3])
    plot(t,P.alpha,'b','LineWidth',2);
    xlabel('time (sec)')
    ylabel('\alpha_p (deg)')
    title({'Pelvis Roll Orientation (\alpha)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\4.png')
    
    figure
    subplot(3,1,[2 3])
    plot(t,P.beta,'b','LineWidth',2);
    xlabel('time (sec)')
    ylabel('\beta_p (deg)')
    title({'Pelvis Pitch Orientation (\beta)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\5.png')
    
    figure
    subplot(3,1,[2 3])
    plot(t,P.gamma,'b','LineWidth',2);
    xlabel('time (sec)')
    ylabel('\gamma_p (deg)')
    title({'Pelvis Yaw Orientation (\gamma)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Pelvis\6.png')
    
    %%% Ankle
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,A.fr.x,'b','LineWidth',2);
    hold on
    Pfl=plot(t,A.fl.x,'r','LineWidth',2);
    Phr=plot(t,A.hr.x,'--b','LineWidth',2);
    Phl=plot(t,A.hl.x,'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('x_a (m)')
    title({'Ankle Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\1.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,A.fr.y,'b','LineWidth',2);
    hold on
    Pfl=plot(t,A.fl.y,'r','LineWidth',2);
    Phl=plot(t,A.hl.y,'--r','LineWidth',2);
    Phr=plot(t,A.hr.y,'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('y_a (m)')
    title({'Ankle Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\2.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,A.fr.z,'b','LineWidth',2);
    hold on
    Pfl=plot(t,A.fl.z,'r','LineWidth',2);
    Phl=plot(t,A.hl.z,'--r','LineWidth',2);
    Phr=plot(t,A.hr.z,'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_a (m)')
    title({'Ankle Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\3.png')
    
    %%% Pelvis Velocity
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dx,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('dx_p (m/s)')
    %     title({'Pelvis Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\1.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dy,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('dy_p (m/s)')
    %     title({'Pelvis Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\2.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dz,'b','LineWidth',2);
    %     hold off
    %     xlabel('time (sec)')
    %     ylabel('dz_p (m/s)')
    %     title({'Pelvis Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\3.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dalpha,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('d\alpha_p (rpm)')
    %     title({'Pelvis Roll Orientation (\alpha)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\4.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dbeta,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('d\beta_p (rpm)')
    %     title({'Pelvis Pitch Orientation (\beta)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\5.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.dgamma,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('d\gamma_p (rpm)')
    %     title({'Pelvis Yaw Orientation (\gamma)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\6.png')
    %
    %     %%% Pelvis Acceleration
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddx,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('ddx_p (m/s^2)')
    %     title({'Pelvis Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\1.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddy,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('ddy_p (m/s^2)')
    %     title({'Pelvis Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\2.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddz,'b','LineWidth',2);
    %     hold off
    %     xlabel('time (sec)')
    %     ylabel('ddz_p (m/s^2)')
    %     title({'Pelvis Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\3.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddalpha,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('dd\alpha_p (rad/s^2)')
    %     title({'Pelvis Roll Orientation (\alpha)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\4.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddbeta,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('dd\beta_p (rad/s^2)')
    %     title({'Pelvis Pitch Orientation (\beta)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\5.png')
    %
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(t,P.ddgamma,'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('dd\gamma_p (rad/s^2)')
    %     title({'Pelvis Yaw Orientation (\gamma)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Motion_Time])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     %     saveas(gcf,'Figures\Pelvis\6.png')
    %
elseif m==2
    
    sim('test_angle_joint',Motion_Time)
    v=simout1.signals.values;
    dv=simout2.signals.values;
    ddv=simout3.signals.values;
    t=simout1.time;
    
    K1=180/pi; % rad to deg
    K2=60/(2*pi); % rad/s to rpm
    
    Q=K1*v(:,1:14);
    dQ=K2*dv(:,1:14);
    ddQ=ddv(:,1:14);
    
    q.fr=Q(:,1:3);       q.fl=Q(:,4:6);      q.hr=Q(:,7:10);      q.hl=Q(:,11:14);
    dq.fr=dQ(:,1:3);     dq.fl=dQ(:,4:6);    dq.hr=dQ(:,7:10);    dq.hl=dQ(:,11:14);
    ddq.fr=ddQ(:,1:3);   ddq.fl=ddQ(:,4:6);  ddq.hr=ddQ(:,7:10);  ddq.hl=ddQ(:,11:14);
    
    
    w_max=max(abs(dq.fr(3:end-3,:)));
    
    %%
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,q.fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,q.fl(:,1),'r','LineWidth',2);
    Phr=plot(t,q.hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,q.hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('q_1 (Deg)')
    title({'Angle position of Shoulder Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Position\1.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,q.fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,q.fl(:,2),'r','LineWidth',2);
    Phr=plot(t,q.hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,q.hl(:,2),'--r','LineWidth',2);
    Phr_mid=plot(t,q.hr(:,3),'--g','LineWidth',2);
    Phl_mid=plot(t,q.hl(:,3),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('q_2 (Deg)')
    title({'Angle position of Hip Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(Phr_mid,'DisplayName','HindRightMid');
    set(Phl_mid,'DisplayName','HindLeftMid');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Position\2.png')
       
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,q.fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,q.fl(:,3),'r','LineWidth',2);
    Phr=plot(t,q.hr(:,4),'--b','LineWidth',2);
    Phl=plot(t,q.hl(:,4),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('q_3 (Deg)')
    title({'Angle position of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Position\4.png')
    %% Angular velocity
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,dq.fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,dq.fl(:,1),'r','LineWidth',2);
    Phr=plot(t,dq.hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,dq.hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('$\dot{{q}_{1}}$ (rad/s)','interpreter','latex')
    title({'Angular velocity of Shoulder Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Velocity\1.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,dq.fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,dq.fl(:,2),'r','LineWidth',2);
    Phr=plot(t,dq.hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,dq.hl(:,2),'--r','LineWidth',2);
    Phr_mid=plot(t,dq.hr(:,3),'--g','LineWidth',2);
    Phl_mid=plot(t,dq.hl(:,3),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('$\dot{{q}_{2}}$ (rad/s)','interpreter','latex')
    title({'Angular velocity of Hip Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(Phr_mid,'DisplayName','HindRightMid');
    set(Phl_mid,'DisplayName','HindLeftMid');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Velocity\2.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,dq.fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,dq.fl(:,3),'r','LineWidth',2);
    Phr=plot(t,dq.hr(:,4),'--b','LineWidth',2);
    Phl=plot(t,dq.hl(:,4),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('$\dot{{q}_{3}}$ (rad/s)','interpreter','latex')
    title({'Angular velocity of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',24);
    set(get(gca,'XLabel'),'FontSize',24);
    set(get(gca,'YLabel'),'FontSize',24);
    set(get(gca,'title'),'FontSize',18);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Joint Angle\Velocity\3.png')
    
elseif m==3
    sim('test_angular_velocity',Motion_Time)
    v=simout.signals.values;
    t=simout.time;
    %     size(v)
    w_sh_fr=v(:,1:3);
    w_sh_fl=v(:,4:6);
    w_sh_hr=v(:,7:9);
    w_sh_hl=v(:,10:12);
    w_th_fr=v(:,13:15);
    w_th_fl=v(:,16:18);
    w_th_hr=v(:,19:21);
    w_th_hl=v(:,22:24);
    w_th_mid_hr=v(:,25:27);
    w_th_mid_hl=v(:,28:30);
    w_hip_fr=v(:,31:33);
    w_hip_fl=v(:,34:36);
    w_hip_hr=v(:,37:39);
    w_hip_hl=v(:,40:42);
    w_b=v(:,43:45);
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,w_hip_fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,w_hip_fl(:,1),'r','LineWidth',2);
    Phr=plot(t,w_hip_hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,w_hip_hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('\omega_h_i_p (rad/s)')
    title({'Angular Velocity (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Anglular Velocity\Hip.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,w_th_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,w_th_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,w_th_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,w_th_hl(:,2),'--r','LineWidth',2);
    Phr_mid=plot(t,w_th_mid_hr(:,2),'--g','LineWidth',2);
    Phl_mid=plot(t,w_th_mid_hl(:,2),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('\omega_t_h_i_g_h (rad/s)')
    title({'Angular Velocity (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(Phr_mid,'DisplayName','HindRightMid');
    set(Phl_mid,'DisplayName','HindLeftMid');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Anglular Velocity\Thigh.png')
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,w_sh_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,w_sh_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,w_sh_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,w_sh_hl(:,2),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('\omega_s_h_a_n_k (rad/s)')
    title({'Angular Velocity';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','FrontRight');
    set(Pfl,'DisplayName','FrontLeft');
    set(Phr,'DisplayName','HindRight');
    set(Phl,'DisplayName','HindLeft');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Anglular Velocity\Shank.png')
    
    figure
    subplot(3,1,[2 3])
    w_x=plot(t,w_b(:,1),'b','LineWidth',2);
    hold on
    w_y=plot(t,w_b(:,2),'r','LineWidth',2);
    w_z=plot(t,w_b(:,3),'--b','LineWidth',2);
%     Phl=plot(t,w_sh_hl(:,2),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('\omega_b_o_d_y (rad/s)')
    title({'Angular Velocity';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Motion_Time])
    set(w_x,'DisplayName','Body_x');
    set(w_y,'DisplayName','Body_y');
    set(w_z,'DisplayName','Body_z');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Anglular Velocity\Body.png')
    
elseif m==4
    sim('test_trajectories',Motion_Time)
    r=simout1.signals.values;
    dr=simout2.signals.values;
    ddr=simout3.signals.values;
    t=simout1.time;
    
    r_b=r(:,1:3);
    r_shd_fr=r(:,4:6);
    r_shd_fl=r(:,7:9);
    r_shd_hr=r(:,10:12);
    r_shd_hl=r(:,13:15);
    r_hip_fr=r(:,16:18);
    r_hip_fl=r(:,19:21);
    r_hip_hr=r(:,22:24);
    r_hip_hl=r(:,25:27);
    r_knee_fr=r(:,28:30);
    r_knee_fl=r(:,31:33);
    r_knee_hr=r(:,34:36);
    r_knee_hl=r(:,37:39);
    r_knee_mid_hr=r(:,40:42);
    r_knee_mid_hl=r(:,43:45);
    r_ankle_fr=r(:,46:48);
    r_ankle_fl=r(:,49:51);
    r_ankle_hr=r(:,52:54);
    r_ankle_hl=r(:,55:57);
    
    
    dr_b=dr(:,1:3);
    dr_shd_fr=dr(:,4:6);
    dr_shd_fl=dr(:,7:9);
    dr_shd_hr=dr(:,10:12);
    dr_shd_hl=dr(:,13:15);
    dr_hip_fr=dr(:,16:18);
    dr_hip_fl=dr(:,19:21);
    dr_hip_hr=dr(:,22:24);
    dr_hip_hl=dr(:,25:27);
    dr_knee_fr=dr(:,28:30);
    dr_knee_fl=dr(:,31:33);
    dr_knee_mid_hr=dr(:,34:36);
    dr_knee_mid_hl=dr(:,37:39);
    dr_knee_hr=dr(:,40:42);
    dr_knee_hl=dr(:,43:45);
    dr_ankle_fr=dr(:,46:48);
    dr_ankle_fl=dr(:,49:51);
    dr_ankle_hr=dr(:,52:54);
    dr_ankle_hl=dr(:,55:57);
    
    %%
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_shd_fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_shd_fl(:,1),'r','LineWidth',2);
    Phr=plot(t,r_shd_hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,r_shd_hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Shoulder position x(m)')
    title('Shoulder Position x')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_shd_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_shd_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,r_shd_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,r_shd_hl(:,2),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Shoulder position y(m)')
    title('Shoulder Position y')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_shd_fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_shd_fl(:,3),'r','LineWidth',2);
    Phr=plot(t,r_shd_hr(:,3),'--b','LineWidth',2);
    Phl=plot(t,r_shd_hl(:,3),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Shoulder position z(m)')
    title('Shoulder Position z')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    %%
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_hip_fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_hip_fl(:,1),'r','LineWidth',2);
    Phr=plot(t,r_hip_hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,r_hip_hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Hip position x(m)')
    title('Hip Position x')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_hip_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_hip_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,r_hip_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,r_hip_hl(:,2),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Hip position y(m)')
    title('Hip Position y')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_hip_fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_hip_fl(:,3),'r','LineWidth',2);
    Phr=plot(t,r_hip_hr(:,3),'--b','LineWidth',2);
    Phl=plot(t,r_hip_hl(:,3),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Hip position z(m)')
    title('Hip Position z')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    %%
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_knee_fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_knee_fl(:,1),'r','LineWidth',2);
    Phr=plot(t,r_knee_hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,r_knee_hl(:,1),'--r','LineWidth',2);
    Phr_mid=plot(t,r_knee_mid_hr(:,1),'--g','LineWidth',2);
    Phl_mid=plot(t,r_knee_mid_hl(:,1),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Knee position x(m)')
    title('Knee Position x')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(Phr_mid,'DisplayName','Hind Right mid');
    set(Phl_mid,'DisplayName','Hind Left mid');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_knee_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_knee_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,r_knee_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,r_knee_hl(:,2),'--r','LineWidth',2);
    Phr_mid=plot(t,r_knee_mid_hr(:,2),'--g','LineWidth',2);
    Phl_mid=plot(t,r_knee_mid_hl(:,2),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Knee position y(m)')
    title('Knee Position y')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(Phr_mid,'DisplayName','Hind Right mid');
    set(Phl_mid,'DisplayName','Hind Left mid');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_knee_fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_knee_fl(:,3),'r','LineWidth',2);
    Phr=plot(t,r_knee_hr(:,3),'--b','LineWidth',2);
    Phl=plot(t,r_knee_hl(:,3),'--r','LineWidth',2);
    Phr_mid=plot(t,r_knee_mid_hr(:,3),'--g','LineWidth',2);
    Phl_mid=plot(t,r_knee_mid_hl(:,3),'--m','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Knee position z(m)')
    title('Knee Position z')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(Phr_mid,'DisplayName','Hind Right mid');
    set(Phl_mid,'DisplayName','Hind Left mid');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    %%
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_ankle_fr(:,1),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_ankle_fl(:,1),'r','LineWidth',2);
    Phr=plot(t,r_ankle_hr(:,1),'--b','LineWidth',2);
    Phl=plot(t,r_ankle_hl(:,1),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Ankle position x(m)')
    title('Ankle Position x')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_ankle_fr(:,2),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_ankle_fl(:,2),'r','LineWidth',2);
    Phr=plot(t,r_ankle_hr(:,2),'--b','LineWidth',2);
    Phl=plot(t,r_ankle_hl(:,2),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Ankle position y(m)')
    title('Ankle Position y')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
    figure
    subplot(3,1,[2 3])
    Pfr=plot(t,r_ankle_fr(:,3),'b','LineWidth',2);
    hold on
    Pfl=plot(t,r_ankle_fl(:,3),'r','LineWidth',2);
    Phr=plot(t,r_ankle_hr(:,3),'--b','LineWidth',2);
    Phl=plot(t,r_ankle_hl(:,3),'--r','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('Ankle position z(m)')
    title('Ankle Position z')
    xlim([0 Motion_Time])
    set(Pfr,'DisplayName','Front Right');
    set(Pfl,'DisplayName','Front Left');
    set(Phr,'DisplayName','Hind Right');
    set(Phl,'DisplayName','Hind Left');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    
elseif m==5
    run motion_simulation
    
elseif m==6
    sim('test_COM',Motion_Time)
    v=simout.signals.values;
    t=simout.time;
    
    plot(t,v)
    
elseif m==7
    sim('test_ZMP',Motion_Time)
    v=simout.signals.values;  % ZMP
    u=simout1.signals.values;  % Trajectories
    w=simout2.signals.values;   % r_COM
    t=simout.time;
    
    x_zmp=v(:,1);
    y_zmp=v(:,2);
    d=v(:,3);
    
    J=Limit_ZMP
    x_com=w(:,43);
    y_com=w(:,44);
    % end_effector position
    r= u(:,40:42);
    ankle_fr_x = r(:,1);
    ankle_fr_y = r(:,2);
    ankle_fr_z = r(:,3);
    
    r= u(:,43:45);
    ankle_fl_x = r(:,1);
    ankle_fl_y = r(:,2);
    ankle_fl_z = r(:,3);
    
    r= u(:,46:48);
    ankle_hr_x = r(:,1);
    ankle_hr_y = r(:,2);
    ankle_hr_z = r(:,3);
    
    r= u(:,49:51);
    ankle_hl_x = r(:,1);
    ankle_hl_y = r(:,2);
    ankle_hl_z = r(:,3);
    
    
    figure
    subplot(3,1,[2 3])
    Px=plot(t(4:end-3),x_zmp(4:end-3),'k','LineWidth',2);
    hold on
    Pu=plot(t(4:end-3),x_com(4:end-3),'r','LineWidth',2);
    %     Pl=plot(t(1:end-1),x_low(1:end-1),'r','LineWidth',2);
    xlim([0 Motion_Time])
    ylim([-Ds (3+2*N)*Ds])
    xlabel('time (sec)')
    ylabel('x_z_m_p (m)')
    title({'Stability Region (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    hold off
    set(Px,'DisplayName','x_z_m_p');
    set(Pu,'DisplayName','x_c_o_m');
    %     set(Pl,'DisplayName','lower bound');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\ZMP\1.png')
    
    figure
    subplot(3,1,[2 3])
    Py=plot(t(4:end-3),y_zmp(4:end-3),'k','LineWidth',2);
    hold on
    Pu=plot(t(4:end-3),y_com(4:end-3),'r','LineWidth',2);
    %     Pl=plot(t(1:end-1),y_low(1:end-1),'r','LineWidth',2);
    xlim([0 Motion_Time])
    ylim([-0.02 0.02])
    xlabel('time (sec)')
    ylabel('y_z_m_p (m)')
    title({'Stability Region (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    hold off
    set(Py,'DisplayName','y_z_m_p');
    set(Pu,'DisplayName','y_c_o_m');
    %     set(Pl,'DisplayName','lower bound');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\ZMP\2.png')
    
    figure
    subplot(3,1,[2 3])
    Py=plot(x_zmp(4:end-3),y_zmp(4:end-3),'k','LineWidth',2);
    hold on
    Pu=plot(x_com(4:end-3),y_com(4:end-3),'r','LineWidth',2);
    n1= floor(Td/Step_Time)+5;
    n2= floor((2*Td+Tc)/Step_Time)+5;
%     n3= floor((3*Td+2*Tc)/Step_Time)+5;
%     n4= floor((4*Td+3*Tc)/Step_Time)+5;
    
    plot([ankle_fl_x(n1),ankle_hr_x(n1)],[ankle_fl_y(n1),ankle_hr_y(n1)],'r','LineWidth',2);
    plot([ankle_fr_x(n2),ankle_hl_x(n2)],[ankle_fr_y(n2),ankle_hl_y(n2)],'g','LineWidth',2);
%     plot([ankle_fl_x(n3),ankle_hr_x(n3)],[ankle_fl_y(n3),ankle_hr_y(n3)],'r','LineWidth',2);
%     plot([ankle_fr_x(n4),ankle_hl_x(n4)],[ankle_fr_y(n4),ankle_hl_y(n4)],'g','LineWidth',2);
    
    
    xlim([-Ds (3+2*N)*Ds])
    ylim([-0.02 0.02])
    xlabel('x_z_m_p (m)')
    ylabel('y_z_m_p (m)')
    title({'Stability Region (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    hold off
    set(Py,'DisplayName','y_z_m_p');
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\ZMP\3.png')
    
     figure
    subplot(3,1,[2 3])
    Py=plot(t,d,'k','LineWidth',2);
    
    xlim([0 Motion_Time])
    ylim([-Ds (3+2*N)*Ds])
    xlabel('Time (sec)')
    ylabel('distance (m)')
    title({'Stability Region (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    hold off
    legend(gca,'show','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\ZMP\4.png')
    
    
elseif m==8
    run quad_parameters
%     if mt==1
        sim('test_Torque_Kane',Motion_Time)
        %         sim('test_Torque_Kane1',Motion_Time)
%     elseif mt==2
%         sim('test_Torque_Lagrange1',Motion_Time)
%     end
    v=simout1.signals.values;
    dQ=simout2.signals.values;
    t=simout1.time;
    
    dq.fr=dQ(:,1:3);
    dq.fl=dQ(:,4:6);
    dq.hr=dQ(:,7:10);
    dq.hl=dQ(:,11:14);

    w_max=K_rpm*max(abs(dq.fr(3:end-3,:)))
    
    time=t;
    if mt==1
        TFM_Kane=[time v];
        save('TFM_Kane.mat', 'time', 'v')
    elseif mt==2
        TFM_Lagrange=[time v];
        save('TFM_Lagrange.mat', 'time', 'v')
    end
    clear time
    
    Tau_fr=v(:,1:3);
    Tau_fl=v(:,4:6);
    Tau_hr=v(:,7:10);
    Tau_hl=v(:,11:14);
    F_fr=v(:,15:17);
    F_fl=v(:,18:20);
    F_hr=v(:,21:23);
    F_hl=v(:,24:26);
%     Tau_Cont=sqrt(trapz(t(5:end-5),Tau_f(5:end-5,1:6).^2)/(t(end-5)-t(5)))
%     
%     tau_w=trapz(t(5:end-5),abs(Tau_f(5:end-5,1:6).^3.*dq.f(5:end-5,:)));
%     int_w=trapz(t(5:end-5),abs(dq.f(5:end-5,:)));
%     Tau_Avg=(tau_w./int_w).^(1/3)
%     
%     Tau_Peak=max(abs(Tau_f(5:end-5,1:6)))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     Max_tau=max([Tau_f(5:end-5,1:6);Tau_h(5:end-5,1:6)]);
    %     Min_tau=min([Tau_f(5:end-5,1:6);Tau_h(5:end-5,1:6)]);
    %     Mu_tau=sign(Max_tau).*ceil(abs(Max_tau/50))*50;
    %     Ml_tau=sign(Min_tau).*ceil(abs(Min_tau/50))*50;
    %
    %
    %     Max_F_f=max(F_f(5:end-5,1:3));
    %     Min_F_f=min(F_f(5:end-5,1:3));
    %     Mu_F_f=sign(Max_F_f).*ceil(abs(Max_F_f/200))*200;
    %     Ml_F_f=sign(Min_F_f).*ceil(abs(Min_F_f/200))*200;
    %
    %     Max_F_h=max(F_h(5:end-5,1:3));
    %     Min_F_h=min(F_h(5:end-5,1:3));
    %     Mu_F_h=sign(Max_F_h).*ceil(abs(Max_F_h/200))*200;
    %     Ml_F_h=sign(Min_F_h).*ceil(abs(Min_F_h/200))*200;
    
    %     Max_M_r=max(M_f(5:end-5,1:3));
    %     Min_M_r=min(M_r(5:end-5,1:3));
    %     Mu_M_r=sign(Max_M_r).*ceil(abs(Max_M_r/50))*50;
    %     Ml_M_r=sign(Min_M_r).*ceil(abs(Min_M_r/50))*50;
    %
    %     Max_M_l=max(M_l(5:end-5,1:3));
    %     Min_M_l=min(M_l(5:end-5,1:3));
    %     Mu_M_l=sign(Max_M_l).*ceil(abs(Max_M_l/50))*50;
    %     Ml_M_l=sign(Min_M_l).*ceil(abs(Min_M_l/50))*50;
    %
%     figure
%     subplot(3,1,[2 3])
%     Pfr=plot(t(3:end-3),Tau_fr(3:end-3,1),'b','LineWidth',2);
%     hold on
%     Pfl=plot(t(3:end-3),Tau_fl(3:end-3,1),'r','LineWidth',2);
%     Phr=plot(t(3:end-3),Tau_hr(3:end-3,1),'--b','LineWidth',2);
%     Phl=plot(t(3:end-3),Tau_hl(3:end-3,1),'--r','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(1) Mu_tau(1)])
%     xlabel('time (sec)')
%     ylabel('\tau_1 (N.m)')
%     title({'Torque of Hip Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Pfr,'DisplayName','FR');
%     set(Pfl,'DisplayName','FL');
%     set(Phr,'DisplayName','HR');
%     set(Phl,'DisplayName','HL');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\Hip.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\Hip.png')
%     end
%     
%     figure
%     subplot(3,1,[2 3])
%     Pfr=plot(t(3:end-3),Tau_fr(3:end-3,2),'b','LineWidth',2);
%     hold on
%     Pfl=plot(t(3:end-3),Tau_fl(3:end-3,2),'r','LineWidth',2);
%     Phr=plot(t(3:end-3),Tau_hr(3:end-3,2),'--b','LineWidth',2);
%     Phl=plot(t(3:end-3),Tau_hl(3:end-3,2),'--r','LineWidth',2);
%     Phr_mid=plot(t(3:end-3),Tau_hr(3:end-3,3),'--g','LineWidth',2);
%     Phl_mid=plot(t(3:end-3),Tau_hl(3:end-3,3),'--m','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(2) Mu_tau(2)])
%     xlabel('time (sec)')
%     ylabel('\tau_2 (N.m)')
%     title({'Torque of Shoulder Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Pfr,'DisplayName','FR');
%     set(Pfl,'DisplayName','FL');
%     set(Phr,'DisplayName','HR');
%     set(Phl,'DisplayName','HL');
%     set(Phr_mid,'DisplayName','HR_MID');
%     set(Phl_mid,'DisplayName','HL_MID');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\Shoulder.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\Shoulder.png')
%     end
%     
%     figure
%     subplot(3,1,[2 3])
%     Pfr=plot(t(3:end-3),Tau_fr(3:end-3,3),'b','LineWidth',2);
%     hold on
%     Pfl=plot(t(3:end-3),Tau_fl(3:end-3,3),'r','LineWidth',2);
%     Phr=plot(t(3:end-3),Tau_hr(3:end-3,4),'--b','LineWidth',2);
%     Phl=plot(t(3:end-3),Tau_hl(3:end-3,4),'--r','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(3) Mu_tau(3)])
%     xlabel('time (sec)')
%     ylabel('\tau_3 (N.m)')
%     title({'Torque of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Pfr,'DisplayName','FR');
%     set(Pfl,'DisplayName','FL');
%     set(Phr,'DisplayName','HR');
%     set(Phl,'DisplayName','HL');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\Knee.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\Knee.png')
%     end
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Force
%     figure
%     subplot(3,1,[2 3])
%     Ffr=plot(t(3:end-3),F_fr(3:end-3,1),'b','LineWidth',2);
%     hold on
%     Ffl=plot(t(3:end-3),F_fl(3:end-3,1),'r','LineWidth',2);
%     Fhr=plot(t(3:end-3),F_hr(3:end-3,1),'--b','LineWidth',2);
%     Fhl=plot(t(3:end-3),F_hl(3:end-3,1),'--r','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(3) Mu_tau(3)])
%     xlabel('time (sec)')
%     ylabel('F_x (N)')
%     title({'Reaction Force x';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Ffr,'DisplayName','FR');
%     set(Ffl,'DisplayName','FL');
%     set(Fhr,'DisplayName','HR');
%     set(Fhl,'DisplayName','HL');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\F_x.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\F_x.png')
%     end
%     
%     figure
%     subplot(3,1,[2 3])
%     Ffr=plot(t(3:end-3),F_fr(3:end-3,2),'b','LineWidth',2);
%     hold on
%     Ffl=plot(t(3:end-3),F_fl(3:end-3,2),'r','LineWidth',2);
%     Fhr=plot(t(3:end-3),F_hr(3:end-3,2),'--b','LineWidth',2);
%     Fhl=plot(t(3:end-3),F_hl(3:end-3,2),'--r','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(3) Mu_tau(3)])
%     xlabel('time (sec)')
%     ylabel('F_y (N)')
%     title({'Reaction Force y';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Ffr,'DisplayName','FR');
%     set(Ffl,'DisplayName','FL');
%     set(Fhr,'DisplayName','HR');
%     set(Fhl,'DisplayName','HL');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\F_y.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\F_y.png')
%     end
%     
%     figure
%     subplot(3,1,[2 3])
%     Ffr=plot(t(3:end-3),F_fr(3:end-3,3),'b','LineWidth',2);
%     hold on
%     Ffl=plot(t(3:end-3),F_fl(3:end-3,3),'r','LineWidth',2);
%     Fhr=plot(t(3:end-3),F_hr(3:end-3,3),'--b','LineWidth',2);
%     Fhl=plot(t(3:end-3),F_hl(3:end-3,3),'--r','LineWidth',2);
%     hold off
%     xlim([0 t(end)])
%     %     ylim([Ml_tau(3) Mu_tau(3)])
%     xlabel('time (sec)')
%     ylabel('F_z (N)')
%     title({'Reaction Force z';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%     xlim([0 Motion_Time])
%     set(Ffr,'DisplayName','FR');
%     set(Ffl,'DisplayName','FL');
%     set(Fhr,'DisplayName','HR');
%     set(Fhl,'DisplayName','HL');
%     set(gca,'FontSize',18);
%     set(get(gca,'XLabel'),'FontSize',18);
%     set(get(gca,'YLabel'),'FontSize',18);
%     set(get(gca,'title'),'FontSize',14);
%     legend(gca,'show','Orientation','horizontal');
%     set(gcf,'unit','normalized','position',[0,0,1,1]);
%     if mt==1
%         saveas(gcf,'Figures\Torque & Force\Kane\F_z.png')
%     elseif mt==2
%         saveas(gcf,'Figures\Torque & Force\Lagrange\F_z.png')
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Power
    
        Power=[dq.fr.*Tau_fr dq.fl.*Tau_fl dq.hr.*Tau_hr dq.hl.*Tau_hl];
        Power_fr=Power(:,1:3);
        Power_fl=Power(:,4:6);
        Power_hr=Power(:,7:10);
        Power_hl=Power(:,11:14);
        
        Total_Power = sum(sum(abs(Power)))
        Total_Power_fr=sum(abs(Power_fr))        
        Total_Power_hr=sum(abs(Power_hr))
%         Total_Power_fl=sum(abs(Power_fl))        
%         Total_Power_hl=sum(abs(Power_hl))


        %         P_Cont=sqrt(trapz(t(5:end-5),Power(5:end-5,1:6).^2)/(t(end-5)-t(5)))
        %         P_Peak=max(abs(Power(5:end-5,1:3)))
        
%         figure
%         subplot(3,1,[2 3])
%         Pfr=plot(t(5:end-5),Power_fr(5:end-5,1),'b','LineWidth',2);
%         hold on
%         Pfl=plot(t(5:end-5),Power_fl(5:end-5,1),'r','LineWidth',2);
%         Phr=plot(t(5:end-5),Power_hr(5:end-5,1),'--b','LineWidth',2);
%         Phl=plot(t(5:end-5),Power_hl(5:end-5,1),'--r','LineWidth',2);
%         hold off
%         xlim([0 t(end)])
%         xlabel('time (sec)')
%         ylabel('P_1 (watt)')
%         title({'Power of Shoulder Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%         xlim([0 Motion_Time])
%         set(Pfr,'DisplayName','Front Right');
%         set(Pfl,'DisplayName','Front Left');
%         set(Phr,'DisplayName','Hind Right');
%         set(Phl,'DisplayName','Hind Left');
%         set(gca,'FontSize',18);
%         set(get(gca,'XLabel'),'FontSize',18);
%         set(get(gca,'YLabel'),'FontSize',18);
%         set(get(gca,'title'),'FontSize',14);
%         legend(gca,'show','Orientation','horizontal');
%     
%         figure
%         subplot(3,1,[2 3])
%         Pfr=plot(t(5:end-5),Power_fr(5:end-5,2),'b','LineWidth',2);
%         hold on
%         Pfl=plot(t(5:end-5),Power_fl(5:end-5,2),'r','LineWidth',2);
%         Phr=plot(t(5:end-5),Power_hr(5:end-5,2),'--b','LineWidth',2);
%         Phl=plot(t(5:end-5),Power_hl(5:end-5,2),'--r','LineWidth',2);
%         Phr_mid=plot(t(5:end-5),Power_hr(5:end-5,3),'--g','LineWidth',2);
%         Phl_mid=plot(t(5:end-5),Power_hl(5:end-5,3),'--m','LineWidth',2);
%         hold off
%         xlim([0 t(end)])
%         xlabel('time (sec)')
%         ylabel('P_2 (watt)')
%         title({'Power of Hip Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%         xlim([0 Motion_Time])
%         set(Pfr,'DisplayName','Front Right');
%         set(Pfl,'DisplayName','Front Left');
%         set(Phr,'DisplayName','Hind Right');
%         set(Phl,'DisplayName','Hind Left');
%         set(Phr_mid,'DisplayName','Hind Right Middle');
%         set(Phl_mid,'DisplayName','Hind Left Middle');
%         set(gca,'FontSize',18);
%         set(get(gca,'XLabel'),'FontSize',18);
%         set(get(gca,'YLabel'),'FontSize',18);
%         set(get(gca,'title'),'FontSize',14);
%         legend(gca,'show','Orientation','horizontal');
%         
%         figure
%         subplot(3,1,[2 3])
%         Pfr=plot(t(5:end-5),Power_fr(5:end-5,3),'b','LineWidth',2);
%         hold on
%         Pfl=plot(t(5:end-5),Power_fl(5:end-5,3),'r','LineWidth',2);
%         Phr=plot(t(5:end-5),Power_hr(5:end-5,3),'--b','LineWidth',2);
%         Phl=plot(t(5:end-5),Power_hl(5:end-5,3),'--r','LineWidth',2);
%         hold off
%         xlim([0 t(end)])
%         xlabel('time (sec)')
%         ylabel('P_3 (watt)')
%         title({'Power of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
%         xlim([0 Motion_Time])
%         set(Pfr,'DisplayName','Front Right');
%         set(Pfl,'DisplayName','Front Left');
%         set(Phr,'DisplayName','Hind Right');
%         set(Phl,'DisplayName','Hind Left');
%         set(gca,'FontSize',18);
%         set(get(gca,'XLabel'),'FontSize',18);
%         set(get(gca,'YLabel'),'FontSize',18);
%         set(get(gca,'title'),'FontSize',14);
%         legend(gca,'show','Orientation','horizontal');
    
elseif m==11
    
    sim('test_angle_joint',Motion_Time)
    v=simout1.signals.values;
    dv=simout2.signals.values;
    ddv=simout3.signals.values;
    t=simout1.time;
    
    Q=v(:,1:15);
    dQ=dv(:,1:15);
    ddQ=ddv(:,1:15);
    
    q.r=Q(:,1:6);       q.l=Q(:,7:12);          q.ws=Q(:,13:15);
    dq.r=dQ(:,1:6);     dq.l=dQ(:,7:12);        dq.ws=dQ(:,13:15);
    ddq.r=ddQ(:,1:6);   ddq.l=ddQ(:,7:12);      ddq.ws=ddQ(:,13:15);
    
    qr=q.r;
    ql=q.l;
    qws=q.ws;
    
    save('q_Swing.mat','t','qr')
    save('q_Stance.mat','t','ql')
    save('q_Waist.mat','t','qws')
    clear qr ql qws
    
    xlswrite('q_Swing.xlsx',[t q.r])
    xlswrite('q_Stace.xlsx',[t q.l])
    xlswrite('q_Waist.xlsx',[t q.ws])
    
    nt=find(t>Td & t<Tc);
    time=t(nt)-t(nt(1));
    
    clear v dv ddv t
    clear Q dQ ddQ
    %%%%%%%%%%%%%%%%%%%%%%%
    tq_1R=[time q.r(nt,1)-0*q.r(1,1)];
    tq_2R=[time q.r(nt,2)-0*q.r(1,2)];
    tq_3R=[time q.r(nt,3)-0*q.r(1,3)];
    tq_4R=[time q.r(nt,4)-0*q.r(1,4)];
    tq_5R=[time q.r(nt,5)-0*q.r(1,5)];
    tq_6R=[time q.r(nt,6)-0*q.r(1,6)];
    
    tq_1L=[time q.l(nt,1)-0*q.l(1,1)];
    tq_2L=[time q.l(nt,2)-0*q.l(1,2)];
    tq_3L=[time q.l(nt,3)-0*q.l(1,3)];
    tq_4L=[time q.l(nt,4)-0*q.l(1,4)];
    tq_5L=[time q.l(nt,5)-0*q.l(1,5)];
    tq_6L=[time q.l(nt,6)-0*q.l(1,6)];
    
    tq_1W=[time q.ws(nt,1)-0*q.ws(1,1)];
    tq_2W=[time q.ws(nt,2)-0*q.ws(1,2)];
    tq_3W=[time q.ws(nt,3)-0*q.ws(1,3)];
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
    tdq_1R=[time dq.r(nt,1)];
    tdq_2R=[time dq.r(nt,2)];
    tdq_3R=[time dq.r(nt,3)];
    tdq_4R=[time dq.r(nt,4)];
    tdq_5R=[time dq.r(nt,5)];
    tdq_6R=[time dq.r(nt,6)];
    
    tdq_1L=[time dq.l(nt,1)];
    tdq_2L=[time dq.l(nt,2)];
    tdq_3L=[time dq.l(nt,3)];
    tdq_4L=[time dq.l(nt,4)];
    tdq_5L=[time dq.l(nt,5)];
    tdq_6L=[time dq.l(nt,6)];
    
    tdq_1W=[time dq.ws(nt,1)];
    tdq_2W=[time dq.ws(nt,2)];
    tdq_3W=[time dq.ws(nt,3)];
    
    %%%%%%%%%%%%%%%%%%%%%%%
    tddq_1R=[time ddq.r(nt,1)];
    tddq_2R=[time ddq.r(nt,2)];
    tddq_3R=[time ddq.r(nt,3)];
    tddq_4R=[time ddq.r(nt,4)];
    tddq_5R=[time ddq.r(nt,5)];
    tddq_6R=[time ddq.r(nt,6)];
    
    tddq_1L=[time ddq.l(nt,1)];
    tddq_2L=[time ddq.l(nt,2)];
    tddq_3L=[time ddq.l(nt,3)];
    tddq_4L=[time ddq.l(nt,4)];
    tddq_5L=[time ddq.l(nt,5)];
    tddq_6L=[time ddq.l(nt,6)];
    
    tddq_1W=[time ddq.ws(nt,1)];
    tddq_2W=[time ddq.ws(nt,2)];
    tddq_3W=[time ddq.ws(nt,3)];
    
    clear time
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sim('Surena4EX.slx',Ts)
    %     sim('HRP_Left_Support_Follower.slx',Ts)
    
    L_1=L1.signals.values;
    L_2=L2.signals.values;
    L_3=L3.signals.values;
    L_4=L4.signals.values;
    L_5=L5.signals.values;
    L_6=L6.signals.values;
    
    R_1=R1.signals.values;
    R_2=R2.signals.values;
    R_3=R3.signals.values;
    R_4=R4.signals.values;
    R_5=R5.signals.values;
    R_6=R6.signals.values;
    
    W_1=W1.signals.values;
    W_2=W2.signals.values;
    W_3=W3.signals.values;
    
    R_ankle=Ra.signals.values;
    R_foot=Rf.signals.values;
    
    R_pelvis=Rp.signals.values;
    
    t=L1.time;
    
    %%%%%% Pelvis Position
    load Pelvis_Position.mat
    nt=find(time>Td & time<Tc);
    time_=time(nt)-time(nt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,x_p(nt)-Ds,'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,1),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('x_p (m)')
    title({'pelvis Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\1.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,y_p(nt),'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,2),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('y_p (m)')
    title({'pelvis Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\2.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,z_p(nt),'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,3),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_p (m)')
    title({'Pelvis Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\3.png')
    
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(time_,y_p(nt)-R_pelvis(1:end-1,2),'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('y_p (m)')
    %     title({'Ankle Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Tc])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     saveas(gcf,'Figures\Ankle\2.png')
    
    %     figure
    %     subplot(3,1,[2 3])
    %     plot(time_,z_p(nt)-R_pelvis(1:end-1,3),'b','LineWidth',2);
    %     xlabel('time (sec)')
    %     ylabel('z_p (m)')
    %     title({'Ankle Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %     xlim([0 Tc])
    %     set(gca,'FontSize',18);
    %     set(get(gca,'XLabel'),'FontSize',18);
    %     set(get(gca,'YLabel'),'FontSize',18);
    %     set(get(gca,'title'),'FontSize',14);
    %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    %     saveas(gcf,'Figures\Ankle\3.png')
    
    clear ntt time time_ x_p y_p z_p
    
    %%%%%% Ankle Position
    load Ankle_Position.mat
    nt=find(time>Td & time<Tc);
    time_=time(nt)-time(nt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,x_ar(nt)-Ds,'b','LineWidth',2);
    hold on
    plot(t,R_ankle(:,1),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('x_a (m)')
    title({'Ankle Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\1.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,y_ar(nt),'b','LineWidth',2);
    hold on
    plot(t(1:end-2),R_ankle(1:end-2,2),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('y_a (m)')
    title({'Ankle Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\2.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,z_ar(nt),'b','LineWidth',2);
    hold on
    plot(t,R_ankle(:,3),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_a (m)')
    title({'Ankle Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\3.png')
    
    clear ntt time time_ x_ar y_ar z_ar
    
    %%%%%% Torques
    Tau_r_sim= [R_1(:,4) R_2(:,4) R_3(:,4) R_4(:,4) R_5(:,4) R_6(:,4)];
    Tau_l_sim= [L_1(:,4) L_2(:,4) L_3(:,4) L_4(:,4) L_5(:,4) L_6(:,4)];
    Tau_ws_sim=[W_1(:,4) W_2(:,4) W_3(:,4)];
    
    %     Tau_Cont_r=sqrt(trapz(t(5:end-5),Tau_r(5:end-5,1:6).^2)/(t(end-5)-t(5)))
    %     Tau_Cont_l=sqrt(trapz(t(5:end-5),Tau_l(5:end-5,1:6).^2)/(t(end-5)-t(5)))
    %     Tau_Peak=max(abs([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6)]))
    
    load TFM_Kane.mat
    Tau_r_th=v(:,1:6);
    Tau_l_th=v(:,7:12);
    Tau_ws_th=v(:,13:15);
    ntt=find(time>Td & time<(Tc+Td));
    time_=time(ntt)-time(ntt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,1),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,1),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,1),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,1),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_1 (N.m)')
    title({'Torque of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,2),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,2),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,2),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,2),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_2 (N.m)')
    title({'Torque of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,3),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,3),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,3),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,3),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_3 (N.m)')
    title({'Torque of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,4),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,4),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,4),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,4),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_4 (N.m)')
    title({'Torque of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,5),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,5),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,5),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,5),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_5 (N.m)')
    title({'Torque of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,6),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,6),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,6),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,6),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_6 (N.m)')
    title({'Torque of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_ws_th(ntt,1),'b','LineWidth',2);
    hold on
    plot(t,Tau_ws_sim(:,1),'--b','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_w_s_,_ _r_o_l_l (N.m)')
    title({'Torque of Waist Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_ws_th(ntt,2),'b','LineWidth',2);
    hold on
    plot(t,Tau_ws_sim(:,2),'--b','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_w_s_,_ _p_i_t_c_h (N.m)')
    title({'Torque of Waist Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_ws_th(ntt,3),'b','LineWidth',2);
    hold on
    plot(t,Tau_ws_sim(:,3),'--b','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_w_s_,_ _y_a_w (N.m)')
    title({'Torque of Waist Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    %     q3_L=h_yaw_L(:,1);
    %     dq3_L=h_yaw_L(:,2);
    %     ddq3_L=h_yaw_L(:,3);
    %     tau3_L=h_yaw_L(:,4);
    %     M3_L=h_yaw_L(:,5:7);
    %     F3_L=h_yaw_L(:,8:10);
    
    %%%%%% Internal Force
    
    F_Hip_Roll_Swing=R_1(:,8:10);
    F_Hip_Roll_Stance=L_1(:,8:10);
    
    F_Hip_Pitch_Swing=R_2(:,8:10);
    F_Hip_Pitch_Stance=L_2(:,8:10);
    
    F_Hip_Yaw_Swing=R_3(:,8:10);
    F_Hip_Yaw_Stance=L_3(:,8:10);
    
    F_Knee_Swing=R_4(:,8:10);
    F_Knee_Stance=L_4(:,8:10);
    
    F_Ankle_Roll_Swing=R_5(:,8:10);
    F_Ankle_Roll_Stance=L_5(:,8:10);
    
    F_Ankle_Pitch_Swing=R_6(:,8:10);
    F_Ankle_Pitch_Stance=L_6(:,8:10);
    
    F_Waist_Roll=W_1(:,8:10);
    F_Waist_Pitch=W_2(:,8:10);
    F_Waist_Yaw=W_3(:,8:10);
    
    save('Internal_Force.mat','t',...
        'F_Hip_Roll_Swing',      'F_Hip_Roll_Stance',...
        'F_Hip_Pitch_Swing',     'F_Hip_Pitch_Stance',...
        'F_Hip_Yaw_Swing',       'F_Hip_Yaw_Stance',...
        'F_Knee_Swing',          'F_Knee_Stance',...
        'F_Ankle_Roll_Swing',    'F_Ankle_Roll_Stance',...
        'F_Ankle_Pitch_Swing',   'F_Ankle_Pitch_Stance',...
        'F_Waist_Roll',...
        'F_Waist_Pitch',...
        'F_Waist_Yaw');
    
    xlswrite('F_Hip_Roll_Swing.xlsx',     [t F_Hip_Roll_Swing])
    xlswrite('F_Hip_Roll_Stance.xlsx',    [t F_Hip_Roll_Stance])
    
    xlswrite('F_Hip_Pitch_Swing.xlsx',    [t F_Hip_Pitch_Swing])
    xlswrite('F_Hip_Pitch_Stance.xlsx',   [t F_Hip_Pitch_Stance])
    
    xlswrite('F_Hip_Yaw_Swing.xlsx',      [t F_Hip_Yaw_Swing])
    xlswrite('F_Hip_Yaw_Stance.xlsx',     [t F_Hip_Yaw_Stance])
    
    xlswrite('F_Knee_Swing.xlsx',         [t F_Knee_Swing])
    xlswrite('F_Knee_Stance.xlsx',        [t F_Knee_Stance])
    
    xlswrite('F_Ankle_Roll_Swing.xlsx',   [t F_Ankle_Roll_Swing])
    xlswrite('F_Ankle_Roll_Stance.xlsx',  [t F_Ankle_Roll_Stance])
    
    xlswrite('F_Ankle_Pitch_Swing.xlsx',  [t F_Ankle_Pitch_Swing])
    xlswrite('F_Ankle_Pitch_Stance.xlsx', [t F_Ankle_Pitch_Stance])
    
    xlswrite('F_Waist_Roll.xlsx',         [t F_Waist_Roll])
    xlswrite('F_Waist_Pitch.xlsx',        [t F_Waist_Pitch])
    xlswrite('F_Waist_Yaw.xlsx',          [t F_Waist_Yaw])
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_1(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_1(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_1(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_2(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_2(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_2(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_3(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_3(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_3(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_4(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_4(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_4(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_5(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_5(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_5(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_6(:,8),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,8),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_x (N)')
    title({'Internal Force of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_6(:,9),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,9),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('F_y(N)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_6(:,10),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,10),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('F_z (N)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    %%%%%% Internal Moment
    
    M_Hip_Roll_Swing=R_1(:,5:7);
    M_Hip_Roll_Stance=L_1(:,5:7);
    
    M_Hip_Pitch_Swing=R_2(:,5:7);
    M_Hip_Pitch_Stance=L_2(:,5:7);
    
    M_Hip_Yaw_Swing=R_3(:,5:7);
    M_Hip_Yaw_Stance=L_3(:,5:7);
    
    M_Knee_Swing=R_4(:,5:7);
    M_Knee_Stance=L_4(:,5:7);
    
    M_Ankle_Roll_Swing=R_5(:,5:7);
    M_Ankle_Roll_Stance=L_5(:,5:7);
    
    M_Ankle_Pitch_Swing=R_6(:,5:7);
    M_Ankle_Pitch_Stance=L_6(:,5:7);
    
    M_Waist_Roll=W_1(:,5:7);
    M_Waist_Pitch=W_2(:,5:7);
    M_Waist_Yaw=W_3(:,5:7);
    
    save('Internal_Moment.mat','t',...
        'M_Hip_Roll_Swing',      'M_Hip_Roll_Stance',...
        'M_Hip_Pitch_Swing',     'M_Hip_Pitch_Stance',...
        'M_Hip_Yaw_Swing',       'M_Hip_Yaw_Stance',...
        'M_Knee_Swing',          'M_Knee_Stance',...
        'M_Ankle_Roll_Swing',    'M_Ankle_Roll_Stance',...
        'M_Ankle_Pitch_Swing',   'M_Ankle_Pitch_Stance',...
        'M_Waist_Roll',...
        'M_Waist_Pitch',...
        'M_Waist_Yaw');
    
    xlswrite('M_Hip_Roll_Swing.xlsx',     [t M_Hip_Roll_Swing])
    xlswrite('M_Hip_Roll_Stance.xlsx',    [t M_Hip_Roll_Stance])
    
    xlswrite('M_Hip_Pitch_Swing.xlsx',    [t M_Hip_Pitch_Swing])
    xlswrite('M_Hip_Pitch_Stance.xlsx',   [t M_Hip_Pitch_Stance])
    
    xlswrite('M_Hip_Yaw_Swing.xlsx',      [t M_Hip_Yaw_Swing])
    xlswrite('M_Hip_Yaw_Stance.xlsx',     [t M_Hip_Yaw_Stance])
    
    xlswrite('M_Knee_Swing.xlsx',         [t M_Knee_Swing])
    xlswrite('M_Knee_Stance.xlsx',        [t M_Knee_Stance])
    
    xlswrite('M_Ankle_Roll_Swing.xlsx',   [t M_Ankle_Roll_Swing])
    xlswrite('M_Ankle_Roll_Stance.xlsx',  [t M_Ankle_Roll_Stance])
    
    xlswrite('M_Ankle_Pitch_Swing.xlsx',  [t M_Ankle_Pitch_Swing])
    xlswrite('M_Ankle_Pitch_Stance.xlsx', [t M_Ankle_Pitch_Stance])
    
    xlswrite('M_Waist_Roll.xlsx',         [t M_Waist_Roll])
    xlswrite('M_Waist_Pitch.xlsx',        [t M_Waist_Pitch])
    xlswrite('M_Waist_Yaw.xlsx',          [t M_Waist_Yaw])
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_1(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_1(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_1(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_1(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_2(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_2(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_2(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_2(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_3(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_3(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_3(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_3(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_4(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_4(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_4(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_4(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_5(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_5(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_5(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_5(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    
    figure %%%%%%
    subplot(3,1,1)
    plot(t,R_6(:,5),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,5),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_x (N.m)')
    title({'Internal Moment of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,2)
    plot(t,R_6(:,6),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,6),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    ylabel('M_y (N.m)')
    xlim([0 Ts])
    set(gca,'XTick',[])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    
    subplot(3,1,3)
    plot(t,R_6(:,7),'b','LineWidth',2);
    hold on
    plot(t,L_6(:,7),'r','LineWidth',2);
    hold off
    xlim([0 t(end)])
    xlabel('time (sec)')
    ylabel('M_z (N.m)')
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing','Stance');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    % %% IK Validation
    % % elseif m==8
    % %     sim('test_IK_validation',Motion_Time)
    % %     v=simout1.signals.values;
    % %     e=simout2.signals.values;
    % %     t=simout1.time;
    % %
    % %     r_ar=v(:,1:3);
    % %     q_ar=v(:,4:6)*(180/pi);
    % %     r_al=v(:,7:9);
    % %     q_al=v(:,10:12)*(180/pi);
    % %
    % %     er_ar=e(:,1:3);
    % %     eq_ar=e(:,4:6)*(180/pi);
    % %     er_al=e(:,7:9);
    % %     eq_al=e(:,10:12)*(180/pi);
    % %
    % %     figure('NumberTitle','off','Name','E_x')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,er_ar(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,er_al(:,1),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_x (m)')
    % %     title({'Ankle Position Error (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     saveas(gca,'E_x.png')
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\1.png')
    % %
    % %     figure('NumberTitle','off','Name','E_y')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,er_ar(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,er_al(:,2),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_y (m)')
    % %     title({'Ankle Position Error (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\2.png')
    % %
    % %     figure('NumberTitle','off','Name','E_z')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(1:end-3),er_ar(1:end-3,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(1:end-3),er_al(1:end-3,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_z (m)')
    % %     title({'Ankle Position Error (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\3.png')
    % %
    % %     figure('NumberTitle','off','Name','E_alpha')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,1),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\alpha (deg)')
    % %     title({'Foot Orientation Error (Roll)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\4.png')
    % %
    % %     figure('NumberTitle','off','Name','E_beta')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,2),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\beta (deg)')
    % %     title({'Foot Orientation Error (Pitch)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\5.png')
    % %
    % %     figure('NumberTitle','off','Name','E_gama')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\gamma (deg)')
    % %     title({'Foot Orientation Error (Yaw)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\IKV\6.png')
    % %     %% Inverse Dynamic Validation
    % % elseif m==9
    % %
    % %     run biped_parameters
    % %
    % %     load TFM_Kane.mat
    % %     size(TFM_Kane)
    % %     t=TFM_Kane(:,1);v=TFM_Kane(:,2:27);u=TFM_Kane(:,28:29);w=TFM_Kane(:,30:33);
    % %
    % %     Tau_r(:,1:6)=v(:,1:6);
    % %     Tau_l(:,1:6)=v(:,7:12);
    % %     Tau_tr(:,1:2)=v(:,13:14);
    % %     F_r(:,1:3)=v(:,15:17);
    % %     F_l(:,1:3)=v(:,18:20);
    % %     M_r(:,1:3)=v(:,21:23);
    % %     M_l(:,1:3)=v(:,24:26);
    % %
    % %     F_knee_r(:,1)=u(:,1);
    % %     F_knee_l(:,1)=u(:,2);
    % %
    % %     F_ankle_r(:,1:2)=w(:,1:2);
    % %     F_ankle_int_r(:,1)=F_ankle_r(:,1);
    % %     F_ankle_ext_r(:,1)=F_ankle_r(:,2);
    % %
    % %     F_ankle_l(:,1:2)=w(:,3:4);
    % %     F_ankle_int_l(:,1)=F_ankle_l(:,1);
    % %     F_ankle_ext_l(:,1)=F_ankle_l(:,2);
    % %
    % %     clear t v u w
    % %     load TFM_Lagrange.mat
    % %     t=TFM_Lagrange(:,1);v=TFM_Lagrange(:,2:27);u=TFM_Lagrange(:,28:29);w=TFM_Lagrange(:,30:33);
    % %
    % %     Tau_r(:,7:12)=v(:,1:6);
    % %     Tau_l(:,7:12)=v(:,7:12);
    % %     Tau_tr(:,3:4)=v(:,13:14);
    % %     F_r(:,4:6)=v(:,15:17);
    % %     F_l(:,4:6)=v(:,18:20);
    % %     M_r(:,4:6)=v(:,21:23);
    % %     M_l(:,4:6)=v(:,24:26);
    % %
    % %     F_knee_r(:,2)=u(:,1);
    % %     F_knee_l(:,2)=u(:,2);
    % %
    % %     F_ankle_r(:,3:4)=w(:,1:2);
    % %     F_ankle_int_r(:,2)=F_ankle_r(:,1);
    % %     F_ankle_ext_r(:,2)=F_ankle_r(:,2);
    % %
    % %     F_ankle_l(:,3:4)=w(:,3:4);
    % %     F_ankle_int_l(:,2)=F_ankle_l(:,1);
    % %     F_ankle_ext_l(:,2)=F_ankle_l(:,2);
    % %
    % %     Tau_Peak=max(abs([Tau_r(5:end-5,1:6);Tau_r(5:end-5,7:12)]))
    % %
    % %     Max_tau=max([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6);Tau_r(5:end-5,7:12);Tau_l(5:end-5,7:12)]);
    % %     Min_tau=min([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6);Tau_r(5:end-5,7:12);Tau_l(5:end-5,7:12)]);
    % %     Mu_tau=sign(Max_tau).*ceil(abs(Max_tau/50))*50;
    % %     Ml_tau=sign(Min_tau).*ceil(abs(Min_tau/50))*50;
    % %
    % %     Max_tau_tr_r=max([Tau_tr(5:end-5,1);Tau_tr(5:end-5,3)]);
    % %     Min_tau_tr_r=min([Tau_tr(5:end-5,1);Tau_tr(5:end-5,3)]);
    % %     Mu_tau_tr_r=sign(Max_tau_tr_r).*ceil(abs(Max_tau_tr_r/10))*10;
    % %     Ml_tau_tr_r=sign(Min_tau_tr_r).*ceil(abs(Min_tau_tr_r/10))*10;
    % %
    % %     Max_tau_tr_y=max([Tau_tr(5:end-5,2);Tau_tr(5:end-5,4)]);
    % %     Min_tau_tr_y=min([Tau_tr(5:end-5,2);Tau_tr(5:end-5,4)]);
    % %     Mu_tau_tr_y=sign(Max_tau_tr_y).*ceil(abs(Max_tau_tr_y/5))*5;
    % %     Ml_tau_tr_y=sign(Min_tau_tr_y).*ceil(abs(Min_tau_tr_y/5))*5;
    % %
    % %     Max_F_r=max([F_r(5:end-5,1:3);F_r(5:end-5,4:6)]);
    % %     Min_F_r=min([F_r(5:end-5,1:3);F_r(5:end-5,4:6)]);
    % %     Mu_F_r=sign(Max_F_r).*ceil(abs(Max_F_r/200))*200;
    % %     Ml_F_r=sign(Min_F_r).*ceil(abs(Min_F_r/200))*200;
    % %
    % %     Max_F_l=max([F_l(5:end-5,1:3);F_l(5:end-5,4:6)]);
    % %     Min_F_l=min([F_l(5:end-5,1:3);F_l(5:end-5,4:6)]);
    % %     Mu_F_l=sign(Max_F_l).*ceil(abs(Max_F_l/200))*200;
    % %     Ml_F_l=sign(Min_F_l).*ceil(abs(Min_F_l/200))*200;
    % %
    % %     Max_M_r=max([M_r(5:end-5,1:3);M_r(5:end-5,4:6)]);
    % %     Min_M_r=min([M_r(5:end-5,1:3);M_r(5:end-5,4:6)]);
    % %     Mu_M_r=sign(Max_M_r).*ceil(abs(Max_M_r/50))*50;
    % %     Ml_M_r=sign(Min_M_r).*ceil(abs(Min_M_r/50))*50;
    % %
    % %     Max_M_l=max([M_l(5:end-5,1:3);M_l(5:end-5,4:6)]);
    % %     Min_M_l=min([M_l(5:end-5,1:3);M_l(5:end-5,4:6)]);
    % %     Mu_M_l=sign(Max_M_l).*ceil(abs(Max_M_l/50))*50;
    % %     Ml_M_l=sign(Min_M_l).*ceil(abs(Min_M_l/50))*50;
    % %
    % %     Max_F_knee=max([F_knee_r(5:end-5,1);F_knee_l(5:end-5,1);F_knee_r(5:end-5,2);F_knee_l(5:end-5,2)]);
    % %     Min_F_knee=min([F_knee_r(5:end-5,1);F_knee_l(5:end-5,1);F_knee_r(5:end-5,2);F_knee_l(5:end-5,2)]);
    % %     Mu_F_knee=sign(Max_F_knee).*ceil(abs(Max_F_knee/1000))*1000;
    % %     Ml_F_knee=sign(Min_F_knee).*ceil(abs(Min_F_knee/1000))*1000;
    % %
    % %     Max_F_ankle=max([F_ankle_r(5:end-5,1:2);F_ankle_l(5:end-5,1:2);F_ankle_r(5:end-5,3:4);F_ankle_l(5:end-5,3:4)]);
    % %     Min_F_ankle=min([F_ankle_r(5:end-5,1:2);F_ankle_l(5:end-5,1:2);F_ankle_r(5:end-5,3:4);F_ankle_l(5:end-5,3:4)]);
    % %     Mu_F_ankle=sign(Max_F_ankle).*ceil(abs(Max_F_ankle/500))*500;
    % %     Ml_F_ankle=sign(Min_F_ankle).*ceil(abs(Min_F_ankle/500))*500;
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,7),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(1) Mu_tau(1)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_1 (N.m)')
    % %     title({'Torque of Right Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\1R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,7),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(1) Mu_tau(1)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_1 (N.m)')
    % %     title({'Torque of Left Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\1L.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,8),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(2) Mu_tau(2)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_2 (N.m)')
    % %     title({'Torque of Right Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\2R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,8),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(2) Mu_tau(2)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_2 (N.m)')
    % %     title({'Torque of Left Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\2L.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,9),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(3) Mu_tau(3)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_3 (N.m)')
    % %     title({'Torque of Right Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\3R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,9),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(3) Mu_tau(3)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_3 (N.m)')
    % %     title({'Torque of Left Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,4),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,10),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(4) Mu_tau(4)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_4 (N.m)')
    % %     title({'Torque of Right Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\4R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,4),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,10),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(4) Mu_tau(4)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_4 (N.m)')
    % %     title({'Torque of Left Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\4L.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,11),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(5) Mu_tau(5)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_5 (N.m)')
    % %     title({'Torque of Right Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\5R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,11),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(5) Mu_tau(5)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_5 (N.m)')
    % %     title({'Torque of Left Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\5L.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_r(3:end-3,6),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_r(3:end-3,12),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(6) Mu_tau(6)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_6 (N.m)')
    % %     title({'Torque of Right Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\6R.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_l(3:end-3,6),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_l(3:end-3,12),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau(6) Mu_tau(6)])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_6 (N.m)')
    % %     title({'Torque of Left Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\6L.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_tr(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_tr(3:end-3,3),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau_tr_r Mu_tau_tr_r])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_t_r_,_ _r_o_l_l (N.m)')
    % %     title({'Torque of Trunk Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\7.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),Tau_tr(3:end-3,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(3:end-3),Tau_tr(3:end-3,2)+sin(Tau_tr(3:end-3,2)),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([Ml_tau_tr_y Mu_tau_tr_y])
    % %     xlabel('time (sec)')
    % %     ylabel('\tau_t_r_,_ _y_a_w(N.m)')
    % %     title({'Torque of Trunk Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Kane');
    % %     set(Pl,'DisplayName','Lagrange');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\8.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),F_r(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     plot(t(3:end-3),F_r(3:end-3,2:3),'b','LineWidth',2);
    % %     Pl=plot(t(3:end-3),F_r(3:end-3,4),':r','LineWidth',2);
    % %     plot(t(3:end-3),F_r(3:end-3,5:6),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([min(Ml_F_r) max(Mu_F_r)])
    % %     xlabel('time (sec)')
    % %     ylabel('F_R (N)')
    % %     title({'Right Foot Reaction Force';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend([Pr Pl], {'Kane','Lagrange'},'Orientation','Horizontal')
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\9.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),F_l(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     plot(t(3:end-3),F_l(3:end-3,2:3),'b','LineWidth',2);
    % %     Pl=plot(t(3:end-3),F_l(3:end-3,4),':r','LineWidth',2);
    % %     plot(t(3:end-3),F_l(3:end-3,5:6),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([min(Ml_F_l) max(Mu_F_l)])
    % %     xlabel('time (sec)')
    % %     ylabel('F_L (N)')
    % %     title({'Left Foot Reaction Force';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend([Pr Pl], {'Kane','Lagrange'},'Orientation','Horizontal')
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\10.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),M_r(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     plot(t(3:end-3),M_r(3:end-3,2:3),'b','LineWidth',2);
    % %     Pl=plot(t(3:end-3),M_r(3:end-3,4),':r','LineWidth',2);
    % %     plot(t(3:end-3),M_r(3:end-3,5:6),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([min(Ml_M_r) max(Mu_M_r)])
    % %     xlabel('time (sec)')
    % %     ylabel('M_R (N.m)')
    % %     title({'Right Foot Reaction Moment';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend([Pr Pl], {'Kane','Lagrange'},'Orientation','Horizontal')
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\11.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(3:end-3),M_l(3:end-3,1),'b','LineWidth',2);
    % %     hold on
    % %     plot(t(3:end-3),M_l(3:end-3,2:3),'b','LineWidth',2);
    % %     Pl=plot(t(3:end-3),M_l(3:end-3,4),':r','LineWidth',2);
    % %     plot(t(3:end-3),M_l(3:end-3,5:6),':r','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     ylim([min(Ml_M_l) max(Mu_M_l)])
    % %     xlabel('time (sec)')
    % %     ylabel('M_L (N.m)')
    % %     title({'Left Foot Reaction Moment';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend([Pr Pl], {'Kane','Lagrange'},'Orientation','Horizontal')
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Torque & Force\KL\12.png')
    % %
    % % elseif m==10
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     ddv=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     q=v(:,1:14);
    % %     dq=dv(:,1:14);
    % %     ddq=ddv(:,1:14);
    % %
    % %     K=30/pi; % rad/s to rpm coeficient
    % %     q_r=(180/pi)*q(:,1:6);q_l=(180/pi)*q(:,7:12);q_tr=(180/pi)*q(:,13);
    % %     dq_r=dq(:,1:6)*K;dq_l=dq(:,7:12)*K;dq_tr=dq(:,13)*K;
    % %
    % %     Omega_Max=max(abs(dq_r(5:end-5,1:6)))
    % %
    % %     sim('test_trajectories',Motion_Time)
    % %     r=simout1.signals.values;
    % %     dr=simout2.signals.values;
    % %     t=simout1.time;
    % %
    % %     d_k_th_sh_r=r(:,28);
    % %     d_k_th_sh_l=r(:,65);
    % %
    % %     dd_k_th_sh_r=dr(:,28);
    % %     dd_k_th_sh_l=dr(:,65);
    % %
    % %     V_Knee_Max=max(abs(dd_k_th_sh_r(5:end-5)))
    % %
    % %     N_knee=-(dq_r(5:end-5,4)/K)./dd_k_th_sh_r(5:end-5);
    % %
    % %     figure('NumberTitle','off','Name','N_knee')
    % %     subplot(3,1,[2 3])
    % %     plot(t(5:end-5),N_knee,'b','LineWidth',2);
    % %     ylim([16 20])
    % %     xlabel('t (sec)')
    % %     ylabel('N_g_,_k_n_e_e')
    % %     title({'Conversion Ratio of Knee Screw Connection (N vs. t)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     figure('NumberTitle','off','Name','N_knee')
    % %     subplot(3,1,[2 3])
    % %     plot((180/pi)*q(5:end-5,4),N_knee,'b','LineWidth',2);
    % %     ylim([16 20])
    % %     xlabel('q_4 (deg)')
    % %     ylabel('N_g_,_k_n_e_e')
    % %     title({'Conversion Ratio of Knee Screw Connection (N vs. q)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Knee Mechanism\1.png')
    % %
    % %     %     figure
    % %     %     subplot(3,1,[2 3])
    % %     %     plot(t(5:end-5),(2*pi/0.005)./(-(dq_r(5:end-5,4)/K)./dd_k_th_sh_r(5:end-5)),'b','LineWidth',2);
    % %     %     xlabel('t (sec)')
    % %     %     ylabel('N_k_n_e_e')
    % %     %     set(gca,'FontSize',18);
    % %     %     set(get(gca,'XLabel'),'FontSize',18);
    % %     %     set(get(gca,'YLabel'),'FontSize',18);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     plot(t(5:end-5),(dq_r(5:end-5,4)),'b','LineWidth',2);
    % %     xlabel('t (sec)')
    % %     ylabel('\omega_k_n_e_e (rpm)')
    % %     title({'Knee Joint Velocity';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     %     figure
    % %     %     subplot(3,1,[2 3])
    % %     %     plot(t(5:end-5),dd_k_th_sh_r(5:end-5),'b','LineWidth',2);
    % %     %     xlabel('t (sec)')
    % %     %     ylabel('v_k_n_e_e (m/s)')
    % %     %     title({'Knee Screw Velocity';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     %     set(gca,'FontSize',18);
    % %     %     set(get(gca,'XLabel'),'FontSize',18);
    % %     %     set(get(gca,'YLabel'),'FontSize',18);
    % %     %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),d_k_th_sh_r(5:end-5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),d_k_th_sh_l(5:end-5),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('t (sec)')
    % %     ylabel('Z_k_n_e_e (m)')
    % %     title({'Linear Displacement of Knee Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     ylim([0.2 0.30001])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Knee Mechanism\2.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),dd_k_th_sh_r(5:end-5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),dd_k_th_sh_l(5:end-5),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('t (sec)')
    % %     ylabel('v_k_n_e_e (m/s)')
    % %     title({'Linear Velocity of Knee Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % % elseif m==11
    % %     sim('test_ankle_displacement',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     t=simout1.time;
    % %
    % %     Z=v(:,1:4);
    % %     xlswrite('Z_Right.xlsx',[t Z])
    % %
    % %     q=(180/pi)*v(:,5:8);
    % %
    % %     dZ=dv(:,1:4);
    % %     dq=dv(:,5:8);
    % %
    % %     K_rpm=(30/pi);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_5 (deg)')
    % %     title({'Roll Angle of Ankle Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_6 (deg)')
    % %     title({'Pitch Angle of Ankle Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,Z(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,Z(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('Z_i_n_t_e_r_n_a_l (m)')
    % %     title({'Linear Displacement of Internal Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Ankle Mechanism\1.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,Z(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,Z(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('Z_e_x_t_e_r_n_a_l (m)')
    % %     title({'Linear Displacement of External Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     set(gcf,'unit','normalized','position',[0,0,1,1]);
    % %     saveas(gcf,'Figures\Ankle Mechanism\2.png')
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pa=plot(t,Z(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pb=plot(t,Z(:,2),'--b','LineWidth',2);
    % %     Pc=plot(t,Z(:,3),'r','LineWidth',2);
    % %     Pd=plot(t,Z(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('Z (m)')
    % %     title({'Linear Displacement of Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pa,'DisplayName','Right (External)');
    % %     set(Pb,'DisplayName','Right (Internal)');
    % %     set(Pc,'DisplayName','Left (External)');
    % %     set(Pd,'DisplayName','Left (Internal)');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %
    % %
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,K_rpm*dq(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,K_rpm*dq(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('dq_5 (rpm)')
    % %     title({'Roll Velocity of Ankle Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,K_rpm*dq(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,K_rpm*dq(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('dq_6 (rpm)')
    % %     title({'Pitch Velocity of Ankle Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,dZ(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,dZ(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('dZ_i_n_t_e_r_n_a_l (m/s)')
    % %     title({'Linear Velocity of Internal Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,dZ(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,dZ(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('dZ_e_x_t_e_r_n_a_l (m/s)')
    % %     title({'Linear Velocity of External Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pa=plot(t,dZ(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pb=plot(t,dZ(:,2),'--b','LineWidth',2);
    % %     Pc=plot(t,dZ(:,3),'r','LineWidth',2);
    % %     Pd=plot(t,dZ(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('dZ (m/s)')
    % %     title({'Linear Velocity of Ankle Screw';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pa,'DisplayName','Right (External)');
    % %     set(Pb,'DisplayName','Right (Internal)');
    % %     set(Pc,'DisplayName','Left (External)');
    % %     set(Pd,'DisplayName','Left (Internal)');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %
    % %     %     figure
    % %     %     subplot(3,1,[2 3])
    % %     %     Pr=plot(t,dq(:,2)./dZ(:,1),'b','LineWidth',2);
    % %     %     hold on
    % %     %     Pl=plot(t,dq(:,4)./dZ(:,3),'--r','LineWidth',2);
    % %     %     hold off
    % %     %     xlabel('time (sec)')
    % %     %     ylabel('\omega_6/dZ_i_n')
    % %     %     xlim([0 Motion_Time])
    % %     %     set(Pr,'DisplayName','Right');
    % %     %     set(Pl,'DisplayName','Left');
    % %     %     set(gca,'FontSize',18);
    % %     %     set(get(gca,'XLabel'),'FontSize',18);
    % %     %     set(get(gca,'YLabel'),'FontSize',18);
    % %     %     legend(gca,'show','Orientation','horizontal');
    % %     %
    % %     %     figure
    % %     %     subplot(3,1,[2 3])
    % %     %     Pr=plot(t,dq(:,2)./dZ(:,2),'b','LineWidth',2);
    % %     %     hold on
    % %     %     Pl=plot(t,dq(:,4)./dZ(:,4),'--r','LineWidth',2);
    % %     %     hold off
    % %     %     xlabel('time (sec)')
    % %     %     ylabel('\omega_6/dZ_e_x')
    % %     %     xlim([0 Motion_Time])
    % %     %     set(Pr,'DisplayName','Right');
    % %     %     set(Pl,'DisplayName','Left');
    % %     %     set(gca,'FontSize',18);
    % %     %     set(get(gca,'XLabel'),'FontSize',18);
    % %     %     set(get(gca,'YLabel'),'FontSize',18);
    % %     %     legend(gca,'show','Orientation','horizontal');
    % % elseif m==12
    % %     run biped_parameters
    % %     sim('test_Torque_Kane',Motion_Time)
    % %
    % %     v=simout1.signals.values;
    % %     u=simout2.signals.values;
    % %     w=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     Tau_r=v(:,1:6);
    % %     Tau_l=v(:,7:12);
    % %     Tau_tr=v(:,13:14);
    % %     F_r=v(:,15:17);
    % %     F_l=v(:,18:20);
    % %     M_r=v(:,21:23);
    % %     M_l=v(:,24:26);
    % %
    % %     F_knee_r=u(:,1);
    % %     F_knee_l=u(:,2);
    % %
    % %     F_ankle_r=w(:,1:2);
    % %     F_ankle_int_r=F_ankle_r(:,1);
    % %     F_ankle_ext_r=F_ankle_r(:,2);
    % %
    % %     F_ankle_l=w(:,3:4);
    % %     F_ankle_int_l=F_ankle_l(:,1);
    % %     F_ankle_ext_l=F_ankle_l(:,2);
    % %
    % %     Tau_Peak=max(abs(Tau_r(5:end-5,1:6)))
    % %     Tau_Cont=sqrt(trapz(t(5:end-5),Tau_r(5:end-5,1:6).^2)/(t(end-5)-t(5)))
    % %
    % %
    % %     Max_tau=max([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6)]);
    % %     Min_tau=min([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6)]);
    % %     Mu_tau=sign(Max_tau).*ceil(abs(Max_tau/10))*10;
    % %     Ml_tau=sign(Min_tau).*ceil(abs(Min_tau/10))*10;
    % %
    % %     Max_F_r=max(F_r(5:end-5,1:3));
    % %     Min_F_r=min(F_r(5:end-5,1:3));
    % %     Mu_F_r=sign(Max_F_r).*ceil(abs(Max_F_r/200))*200;
    % %     Ml_F_r=sign(Min_F_r).*ceil(abs(Min_F_r/200))*200;
    % %
    % %     Max_F_l=max(F_l(5:end-5,1:3));
    % %     Min_F_l=min(F_l(5:end-5,1:3));
    % %     Mu_F_l=sign(Max_F_l).*ceil(abs(Max_F_l/200))*200;
    % %     Ml_F_l=sign(Min_F_l).*ceil(abs(Min_F_l/200))*200;
    % %
    % %     Max_M_r=max(M_r(5:end-5,1:3));
    % %     Min_M_r=min(M_r(5:end-5,1:3));
    % %     Mu_M_r=sign(Max_M_r).*ceil(abs(Max_M_r/20))*20;
    % %     Ml_M_r=sign(Min_M_r).*ceil(abs(Min_M_r/20))*20;
    % %
    % %     Max_M_l=max(M_l(5:end-5,1:3));
    % %     Min_M_l=min(M_l(5:end-5,1:3));
    % %     Mu_M_l=sign(Max_M_l).*ceil(abs(Max_M_l/20))*20;
    % %     Ml_M_l=sign(Min_M_l).*ceil(abs(Min_M_l/20))*20;
    % %
    % %     Max_F_knee=max([F_knee_r(5:end-5);F_knee_l(5:end-5)]);
    % %     Min_F_knee=min([F_knee_r(5:end-5);F_knee_l(5:end-5)]);
    % %     Mu_F_knee=sign(Max_F_knee).*ceil(abs(Max_F_knee/500))*500;
    % %     Ml_F_knee=sign(Min_F_knee).*ceil(abs(Min_F_knee/500))*500;
    % %
    % %     Max_F_ankle=max([F_ankle_r(5:end-5,1:2);F_ankle_l(5:end-5,1:2)]);
    % %     Min_F_ankle=min([F_ankle_r(5:end-5,1:2);F_ankle_l(5:end-5,1:2)]);
    % %     Mu_F_ankle=sign(Max_F_ankle).*ceil(abs(Max_F_ankle/500))*500;
    % %     Ml_F_ankle=sign(Min_F_ankle).*ceil(abs(Min_F_ankle/500))*500;
    % %
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     ddv=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     q=v(:,1:14);
    % %     dq=dv(:,1:14);
    % %     ddq=ddv(:,1:14);
    % %
    % %     Power=dq.*[Tau_r Tau_l Tau_tr];
    % %     Power_r=Power(:,1:6);
    % %     Power_l=Power(:,7:12);
    % %     Power_tr=Power(:,13:14);
    % %
    % %     P_Peak=max(abs(Power(5:end-5,[1:6 13:14])))
    % %     P_Cont=sqrt(trapz(t(5:end-5),Power(5:end-5,[1:6 13:14]).^2)/(t(end-5)-t(5)))
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,1),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(1) P_Cont(1)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_1 (watt)')
    % %     title({'Power of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,2),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(2) P_Cont(2)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_2 (watt)')
    % %     title({'Power of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,3),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(3) P_Cont(3)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_3 (watt)')
    % %     title({'Power of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,4),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,4),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(4) P_Cont(4)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_4 (watt)')
    % %     title({'Power of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,5),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(5) P_Cont(5)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_5 (watt)')
    % %     title({'Power of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t(5:end-5),Power_r(5:end-5,6),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t(5:end-5),Power_l(5:end-5,6),'--r','LineWidth',2);
    % %     hold on
    % %     Pm=plot([0 t(end)],[P_Cont(6) P_Cont(6)],':k','LineWidth',2);
    % %     hold off
    % %     xlim([0 t(end)])
    % %     xlabel('time (sec)')
    % %     ylabel('P_6 (watt)')
    % %     title({'Power of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(Pm,'DisplayName','Continuous Power');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     plot(t,Power_tr(:,1),'b','LineWidth',2)
    % %     xlim([0 t(end)])
    % %     ylim([-20 20])
    % %     xlabel('time (sec)')
    % %     ylabel('P_t_r_,_ _r_o_l_l (watt)')
    % %     title({'Power of Trunk Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     plot(t,Power_tr(:,2),'b','LineWidth',2)
    % %     xlim([0 t(end)])
    % %     ylim([-10 10])
    % %     xlabel('time (sec)')
    % %     ylabel('P_t_r_,_ _y_a_w(watt)')
    % %     title({'Power of Trunk Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % % elseif m==13
    % %     run motion_simulation
    % % elseif m==14
    % %     % for Yobotics
    % %     sim('test_trajectories',Motion_Time)
    % %     r=simout1.signals.values;
    % %     dr=simout2.signals.values;
    % %     ddr=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     r_p=r(:,75:77);
    % %     r_waist=r(:,78:80);
    % %
    % %     dr_p=dr(:,75:77);
    % %     dr_waist=dr(:,78:80);
    % %
    % %     ddr_p=ddr(:,75:77);
    % %     ddr_waist=ddr(:,78:80);
    % %
    % %     p_d=r_waist;
    % %     dp_d=dr_waist;
    % %     ddp_d=ddr_waist;
    % %
    % %     clear r dr ddr t
    % %
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     ddv=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     q_d=[v(:,1:14) p_d];
    % %     q_d(:,15:16) = -q_d(:,15:16);
    % %
    % %     dq_d=[dv(:,1:14) dp_d];
    % %     dq_d(:,15:16) = -dq_d(:,15:16);
    % %
    % %     ddq_d=[ddv(:,1:14) ddp_d];
    % %     ddq_d(:,15:16) = -ddq_d(:,15:16);
    % %
    % %     q_d(:,1)=q_d(:,1)+13*pi/180;
    % %     q_d(:,7)=q_d(:,7)-13*pi/180;
    % %
    % %     save('Desired_Trajectory.mat', 'q_d', 'dq_d', 'ddq_d')
    % %
    % % elseif m==15
    % %     % for Solidworks Simulation
    % %     sim('test_pelvis_trajectory',Motion_Time)
    % %     v=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     r_p=v(:,1:3);
    % %     theta_p=v(:,4:6);
    % %
    % %     clear v t
    % %
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     q_right=v(:,1:6);
    % %     q_left=v(:,7:12);
    % %     q_waist=v(:,13:14);
    % %
    % %     clear v t
    % %
    % %     sim('test_ankle_displacement',Motion_Time)
    % %     v=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     Z=v(:,1:4);
    % %     Z_r_int=Z(:,1);Z_r_ext=Z(:,2);
    % %     Z_l_int=Z(:,3);Z_l_ext=Z(:,4);
    % %
    % %     save('Motion_Trajectory.mat', 't', 'r_p', 'theta_p', 'q_right', 'q_left', 'q_waist', 'Z_r_ext', 'Z_r_int', 'Z_l_ext', 'Z_l_int')
    % %     %     csvwrite('Motion_Trajectory.csv',[t r_p theta_p q_right q_left q_waist])
    % %
    % % elseif m==16
    % %     % for Mr Nasiri
    % %     sim('test_pelvis_trajectory',Motion_Time)
    % %     v=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     r_p=v(:,1:3);
    % %     theta_p=v(:,4:6);
    % %
    % %     sim('test_trajectories',Motion_Time)
    % %     % sim('test_trajectories_global',Motion_Time)
    % %     r=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     r_s_r=r(:,1:3);
    % %     r_ankle_r=r(:,16:18);
    % %     r_knee_r=r(:,22:24);
    % %     r_inth_r=r(:,29:31);
    % %     r_h_r=r(:,32:34);
    % %
    % %     r_s_l=r(:,38:40);
    % %     r_ankle_l=r(:,53:55);
    % %     r_knee_l=r(:,59:61);
    % %     r_inth_l=r(:,66:68);
    % %     r_h_l=r(:,69:71);
    % %
    % %     r_waist=r(:,78:80);
    % %     r_trunk=r(:,81:83);
    % %
    % %     clear r t
    % %
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     t=simout1.time;
    % %
    % %     q_right=v(:,1:6);
    % %     q_left=v(:,7:12);
    % %     q_waist=v(:,13:14);
    % %
    % %     clear v
    % %
    % %     save('Trajectory.mat', 't', 'r_p', 'theta_p', 'q_right', 'q_left', 'q_waist', ...
    % %         'r_s_r', 'r_ankle_r', 'r_knee_r', 'r_inth_r', 'r_h_r', ...
    % %         'r_s_l', 'r_ankle_l', 'r_knee_l', 'r_inth_l', 'r_h_l', ...
    % %         'r_waist', 'r_trunk');
    % %
    % % elseif m==17
    % %
    % %     run angle_joints_
    % %
    % %     %% Plot
    % %     K_rpm=30/pi;
    % %     q_r=(180/pi)*q(:,1:6);q_l=(180/pi)*q(:,7:12);q_tr_roll=(180/pi)*q(:,13);q_tr_yaw=(180/pi)*q(:,14);
    % %
    % %     q1_r=q_r(:,1);q2_r=q_r(:,2);q3_r=q_r(:,3);q4_r=q_r(:,4);q5_r=q_r(:,5);q6_r=q_r(:,6);
    % %     q1_l=q_l(:,1);q2_l=q_l(:,2);q3_l=q_l(:,3);q4_l=q_l(:,4);q5_l=q_l(:,5);q6_l=q_l(:,6);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,1),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_1 (deg)')
    % %     title({'Angle of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,2),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_2 (deg)')
    % %     title({'Angle of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_3 (deg)')
    % %     title({'Angle of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,4),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,4),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_4 (deg)')
    % %     title({'Angle of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,5),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,5),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_5 (deg)')
    % %     title({'Angle of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,q_r(:,6),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,q_l(:,6),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_6 (deg)')
    % %     title({'Angle of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     plot(t,q_tr_roll,'b','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_t_r_,_ _r_o_l_l (deg)')
    % %     title({'Angle of Trunk Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     figure
    % %     subplot(3,1,[2 3])
    % %     plot(t,q_tr_yaw,'b','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('q_t_r_,_ _y_a_w (deg)')
    % %     title({'Angle of Trunk Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %
    % %     %%%%
    % %     r_ar=v(:,1:3);
    % %     q_ar=v(:,4:6)*(180/pi);
    % %     r_al=v(:,7:9);
    % %     q_al=v(:,10:12)*(180/pi);
    % %
    % %     er_ar=e(:,1:3);
    % %     eq_ar=e(:,4:6)*(180/pi);
    % %     er_al=e(:,7:9);
    % %     eq_al=e(:,10:12)*(180/pi);
    % %
    % %     figure('NumberTitle','off','Name','E_x')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,er_ar(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,er_al(:,1),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_x (m)')
    % %     title({'Ankle Position Error (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %     saveas(gca,'E_x.png')
    % %
    % %     figure('NumberTitle','off','Name','E_y')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,er_ar(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,er_al(:,2),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_y (m)')
    % %     title({'Ankle Position Error (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure('NumberTitle','off','Name','E_z')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,er_ar(:,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,er_al(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_z (m)')
    % %     title({'Ankle Position Error (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure('NumberTitle','off','Name','E_alpha')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,1),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,1),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\alpha (deg)')
    % %     title({'Foot Orientation Error (Roll)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure('NumberTitle','off','Name','E_beta')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,2),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,2),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\beta (deg)')
    % %     title({'Foot Orientation Error (Pitch)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % %
    % %     figure('NumberTitle','off','Name','E_gama')
    % %     subplot(3,1,[2 3])
    % %     Pr=plot(t,eq_ar(:,3),'b','LineWidth',2);
    % %     hold on
    % %     Pl=plot(t,eq_al(:,3),'--r','LineWidth',2);
    % %     hold off
    % %     xlabel('time (sec)')
    % %     ylabel('e_\gamma (deg)')
    % %     title({'Foot Orientation Error (Yaw)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    % %     xlim([0 Motion_Time])
    % %     set(Pr,'DisplayName','Right');
    % %     set(Pl,'DisplayName','Left');
    % %     set(gca,'FontSize',18);
    % %     set(get(gca,'XLabel'),'FontSize',18);
    % %     set(get(gca,'YLabel'),'FontSize',18);
    % %     set(get(gca,'title'),'FontSize',14);
    % %     legend(gca,'show','Orientation','horizontal');
    % % elseif m==18
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     ddv=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     q0=v(1,1:12);
    % %
    % %     sim('test_num',Motion_Time)
    % %     q_num=q_jacob.signals.values;
    % %     q_anl=q_ref.signals.values;
    % %     t=q_jacob.time;
    % %
    % %     figure
    % %     plot(t,q_num(:,1),t,q_anl(:,1))%,t,q_num(:,7),t,q_anl(:,7))
    % %
    % %     figure
    % %     plot(t,q_num(:,2),t,q_anl(:,2))%,t,q_num(:,8),t,q_anl(:,8))
    % %
    % %     figure
    % %     plot(t,q_num(:,3),t,q_anl(:,3))%,t,q_num(:,9),t,q_anl(:,9))
    % %
    % %     figure
    % %     plot(t,q_num(:,4),t,q_anl(:,4))%,t,q_num(:,10),t,q_anl(:,10))
    % %
    % %     figure
    % %     plot(t,q_num(:,5),t,q_anl(:,5))%,t,q_num(:,11),t,q_anl(:,11))
    % %
    % %     figure
    % %     plot(t,q_num(:,6),t,q_anl(:,6))%,t,q_num(:,12),t,q_anl(:,12))
    % %
    % % elseif m==19
    % %     sim('test_angle_joints',Motion_Time)
    % %     v=simout1.signals.values;
    % %     dv=simout2.signals.values;
    % %     ddv=simout3.signals.values;
    % %     t=simout1.time;
    % %
    % %     q0=v(1,1:12)
    % %     dq0=dv(2,1:12)
    % %
    % %     sim('test_numm',Motion_Time)
    % %     q_num=q_jacob.signals.values;
    % %     q_anl=q_ref.signals.values;
    % %     t=q_jacob.time;
    % %
    % %     figure
    % %     plot(t,q_num(:,1),t,q_anl(:,1))
    % %
    % %     figure
    % %     plot(t,q_num(:,7),t,q_anl(:,7))
elseif m==16
    
    sim('test_angle_joint',Motion_Time)
    v=simout1.signals.values;
    dv=simout2.signals.values;
    ddv=simout3.signals.values;
    t=simout1.time;
    
      
    Q= v(:,1:14);
    dQ= dv(:,1:14);
    ddQ=ddv(:,1:14);
    
    A=[Q]';  %;Q(:,2)
    B=[dQ]';
    f=fopen('Data_joint_positions.txt','w');
    fprintf(f,'%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t\n',A);
    fclose(f);
    
    f=fopen('Data_joint_velocities.txt','w');
    fprintf(f,'%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t\n',B);
    fclose(f);
elseif m==17
    
    sim('test_angle_joint',Tc)
    v=simout1.signals.values;
    dv=simout2.signals.values;
    ddv=simout3.signals.values;
    t=simout1.time;
    
    Q=v(:,1:15);
    dQ=dv(:,1:15);
    ddQ=ddv(:,1:15);
    
    q.r=Q(:,1:6);       q.l=Q(:,7:12);          q.ws=Q(:,13:15);
    dq.r=dQ(:,1:6);     dq.l=dQ(:,7:12);        dq.ws=dQ(:,13:15);
    ddq.r=ddQ(:,1:6);   ddq.l=ddQ(:,7:12);      ddq.ws=ddQ(:,13:15);
    
    qr=q.r;
    ql=q.l;
    qws=q.ws;
    
    save('q_Swing.mat','t','qr')
    save('q_Stance.mat','t','ql')
    save('q_Waist.mat','t','qws')
    clear qr ql qws
    
    xlswrite('q_Swing.xlsx',[t q.r])
    xlswrite('q_Stace.xlsx',[t q.l])
    xlswrite('q_Waist.xlsx',[t q.ws])
    
    nt=find(t>Td & t<Tc);
    time=t(nt)-t(nt(1));
    
    clear v dv ddv t
    clear Q dQ ddQ
    %%%%%%%%%%%%%%%%%%%%%%%
    tq_1R=[time q.r(nt,1)];
    tq_2R=[time q.r(nt,2)];
    tq_3R=[time q.r(nt,3)];
    tq_4R=[time q.r(nt,4)];
    tq_5R=[time q.r(nt,5)];
    tq_6R=[time q.r(nt,6)];
    
    tq_1L=[time q.l(nt,1)];
    tq_2L=[time q.l(nt,2)];
    tq_3L=[time q.l(nt,3)];
    tq_4L=[time q.l(nt,4)];
    tq_5L=[time q.l(nt,5)];
    tq_6L=[time q.l(nt,6)];
    
    tq_1W=[time q.ws(nt,1)];
    tq_2W=[time q.ws(nt,2)];
    tq_3W=[time q.ws(nt,3)];
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
    tdq_1R=[time dq.r(nt,1)];
    tdq_2R=[time dq.r(nt,2)];
    tdq_3R=[time dq.r(nt,3)];
    tdq_4R=[time dq.r(nt,4)];
    tdq_5R=[time dq.r(nt,5)];
    tdq_6R=[time dq.r(nt,6)];
    
    tdq_1L=[time dq.l(nt,1)];
    tdq_2L=[time dq.l(nt,2)];
    tdq_3L=[time dq.l(nt,3)];
    tdq_4L=[time dq.l(nt,4)];
    tdq_5L=[time dq.l(nt,5)];
    tdq_6L=[time dq.l(nt,6)];
    
    tdq_1W=[time dq.ws(nt,1)];
    tdq_2W=[time dq.ws(nt,2)];
    tdq_3W=[time dq.ws(nt,3)];
    
    %%%%%%%%%%%%%%%%%%%%%%%
    tddq_1R=[time ddq.r(nt,1)];
    tddq_2R=[time ddq.r(nt,2)];
    tddq_3R=[time ddq.r(nt,3)];
    tddq_4R=[time ddq.r(nt,4)];
    tddq_5R=[time ddq.r(nt,5)];
    tddq_6R=[time ddq.r(nt,6)];
    
    tddq_1L=[time ddq.l(nt,1)];
    tddq_2L=[time ddq.l(nt,2)];
    tddq_3L=[time ddq.l(nt,3)];
    tddq_4L=[time ddq.l(nt,4)];
    tddq_5L=[time ddq.l(nt,5)];
    tddq_6L=[time ddq.l(nt,6)];
    
    tddq_1W=[time ddq.ws(nt,1)];
    tddq_2W=[time ddq.ws(nt,2)];
    tddq_3W=[time ddq.ws(nt,3)];
    
    clear time
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sim('Surena4EX.slx',Ts)
    
    L_1=L1.signals.values;
    L_2=L2.signals.values;
    L_3=L3.signals.values;
    L_4=L4.signals.values;
    L_5=L5.signals.values;
    L_6=L6.signals.values;
    
    R_1=R1.signals.values;
    R_2=R2.signals.values;
    R_3=R3.signals.values;
    R_4=R4.signals.values;
    R_5=R5.signals.values;
    R_6=R6.signals.values;
    
    W_1=W1.signals.values;
    W_2=W2.signals.values;
    W_3=W3.signals.values;
    
    R_ankle=Ra.signals.values;
    R_foot=Rf.signals.values;
    
    R_pelvis=Rp.signals.values;
    
    t=L1.time;
    
    %%%%%% Pelvis Position
    load Pelvis_Position.mat
    nt=find(time>Td & time<Tc);
    time_=time(nt)-time(nt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,x_p(nt)-Ds,'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,1),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('x_p (m)')
    title({'pelvis Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\1.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,y_p(nt),'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,2),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('y_p (m)')
    title({'pelvis Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\2.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,z_p(nt),'b','LineWidth',2);
    hold on
    plot(t,R_pelvis(:,3),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_p (m)')
    title({'Pelvis Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\3.png')
    
    %         figure
    %         subplot(3,1,[2 3])
    %         plot(time_,y_p(nt)-R_pelvis(1:end-1,2),'b','LineWidth',2);
    %         xlabel('time (sec)')
    %         ylabel('y_p (m)')
    %         title({'Ankle Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %         xlim([0 Tc])
    %         set(gca,'FontSize',18);
    %         set(get(gca,'XLabel'),'FontSize',18);
    %         set(get(gca,'YLabel'),'FontSize',18);
    %         set(get(gca,'title'),'FontSize',14);
    %         set(gcf,'unit','normalized','position',[0,0,1,1]);
    %         saveas(gcf,'Figures\Ankle\2.png')
    %
    %         figure
    %         subplot(3,1,[2 3])
    %         plot(time_,z_p(nt)-R_pelvis(1:end-1,3),'b','LineWidth',2);
    %         xlabel('time (sec)')
    %         ylabel('z_p (m)')
    %         title({'Ankle Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    %         xlim([0 Tc])
    %         set(gca,'FontSize',18);
    %         set(get(gca,'XLabel'),'FontSize',18);
    %         set(get(gca,'YLabel'),'FontSize',18);
    %         set(get(gca,'title'),'FontSize',14);
    %         set(gcf,'unit','normalized','position',[0,0,1,1]);
    %         saveas(gcf,'Figures\Ankle\3.png')
    
    %     clear ntt time time_ x_p y_p z_p
    
    %%%%%% Ankle Position
    load Ankle_Position.mat
    nt=find(time>Td & time<Tc);
    time_=time(nt)-time(nt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,x_ar(nt)-Ds,'b','LineWidth',2);
    hold on
    plot(t,R_ankle(:,1),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('x_a (m)')
    title({'Ankle Position (X)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\1.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,y_ar(nt),'b','LineWidth',2);
    hold on
    plot(t,R_ankle(:,2),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('y_a (m)')
    title({'Ankle Position (Y)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\2.png')
    
    figure
    subplot(3,1,[2 3])
    plot(time_,z_ar(nt),'b','LineWidth',2);
    hold on
    plot(t,R_ankle(:,3),'--b','LineWidth',2);
    hold off
    xlabel('time (sec)')
    ylabel('z_a (m)')
    title({'Ankle Position (Z)';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Tc])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Theory','Simmech','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    saveas(gcf,'Figures\Ankle\3.png')
    
    clear ntt time time_ x_ar y_ar z_ar
    %     return
    %%%%%% Torques
    Tau_r_sim= [R_1(:,4) R_2(:,4) R_3(:,4) R_4(:,4) R_5(:,4) R_6(:,4)];
    Tau_l_sim= [L_1(:,4) L_2(:,4) L_3(:,4) L_4(:,4) L_5(:,4) L_6(:,4)];
    Tau_ws_sim=[W_1(:,4) W_2(:,4) W_3(:,4)];
    
    %     Tau_Cont_r=sqrt(trapz(t(5:end-5),Tau_r(5:end-5,1:6).^2)/(t(end-5)-t(5)))
    %     Tau_Cont_l=sqrt(trapz(t(5:end-5),Tau_l(5:end-5,1:6).^2)/(t(end-5)-t(5)))
    %     Tau_Peak=max(abs([Tau_r(5:end-5,1:6);Tau_l(5:end-5,1:6)]))
    
    load TFM_Kane.mat
    Tau_r_th=v(:,1:6);
    Tau_l_th=v(:,7:12);
    Tau_ws_th=v(:,13:15);
    ntt=find(time>Td & time<(Tc));
    time_=time(ntt)-time(ntt(1));
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,1),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,1),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,1),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,1),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_1 (N.m)')
    title({'Torque of Hip Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,2),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,2),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,2),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,2),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_2 (N.m)')
    title({'Torque of Hip Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,3),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,3),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,3),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,3),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_3 (N.m)')
    title({'Torque of Hip Yaw Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,4),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,4),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,4),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,4),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_4 (N.m)')
    title({'Torque of Knee Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,5),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,5),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,5),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,5),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_5 (N.m)')
    title({'Torque of Ankle Roll Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
    figure
    subplot(3,1,[2 3])
    plot(time_,Tau_r_th(ntt,6),'b','LineWidth',2);
    hold on
    plot(t,Tau_r_sim(:,6),'--b','LineWidth',2);
    plot(time_,Tau_l_th(ntt,6),'r','LineWidth',2);
    plot(t,Tau_l_sim(:,6),'--r','LineWidth',2);
    hold off
    xlim([0 time_(end)])
    xlabel('time (sec)')
    ylabel('\tau_6 (N.m)')
    title({'Torque of Ankle Pitch Joint';['Flat: Ds = ',num2str(100*Ds), ' cm & V = ',num2str(V), ' km/h']})
    xlim([0 Ts])
    set(gca,'FontSize',18);
    set(get(gca,'XLabel'),'FontSize',18);
    set(get(gca,'YLabel'),'FontSize',18);
    set(get(gca,'title'),'FontSize',14);
    legend('Swing(Theory)','Swing(Simmech)','Stance(Theory)','Stance(Simmech)','Orientation','horizontal');
    set(gcf,'unit','normalized','position',[0,0,1,1]);
    
end