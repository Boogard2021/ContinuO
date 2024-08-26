function J=OPT(u)
close all
global J_min
global Q_min
global Motion_Time
global T_ac T_dc Td Step_Time
global SCR
global V Ds
global N Tc
%% Variables
kJ=1;
if SCR==3
    Sc=u(1);
    Rse=u(2);
    %     Rd=u(3);
    %     Rm=u(4);
    R_zp=u(3);
    R_Td=u(4);
    
    
    run main_key_parameters
    run main_time
    
elseif SCR==4
    Rac_1=u(1);
    Rac_2=u(2);
    Rac_3=u(3);
    Rac_4=u(4);
    Rac_5=u(5);
    %     Rac_6=u(6);
    %     Rac_7=u(7);
    %     Rac_8=u(8);
    ini1=u(6);
    ini2=u(7);
    
    run start_key_parameters
    run start_time
    
    k=floor(T_ac_a_a/Step_Time)+1;
    i=floor(T_ac/Step_Time)+1;
    
%     if 0>=T_ac_p_ax
%         J=100*kJ;
%         kJ=kJ+1;
%         % display('Y Pelvis Time!')
%     end
    
%     if 0>=T_ac_p_ay || T_ac_p_ay>=T_ac_p_by || T_ac_p_by>=T_ac_p_cy || T_ac_p_cy>=T_ac
%         J=100*kJ;
%         kJ=kJ+1;
%         % display('Y Pelvis Time!')
%     end
    
    if 0>=T_ac_p_az || T_ac_p_az>=T_ac_p_bz || T_ac_p_bz>=T_ac
        J=100*kJ;
        kJ=kJ+1;
        % display('Z Pelvis Time!')
    end
    
    if 0>=T_ac_a_a || T_ac_a_a>=T_ac_a_b || T_ac_a_b>=T_ac
        J=100*kJ;
        kJ=kJ+1;
        % display('st Ankle Time!')
    end
    
elseif SCR==5
    Rdc_1=u(1);
    Rdc_2=u(2);
    Rdc_3=u(3);
    Rdc_4=u(4);
    Rdc_5=u(5);
    Rdc_6=u(6);
    Rdc_7=u(7);
    Rdc_8=u(8);
    
    run end_key_parameters
    run end_time
    
    j=floor((T_ac+2*N*Tc+T_dc_a_a)/Step_Time)+1;
    f=floor((T_ac+2*N*Tc+T_dc_a_c)/Step_Time)+1;
    
    
    if Td>=T_dc_p_ax || T_dc_p_ax>=T_dc
        J=100*kJ;
        kJ=kJ+1;
        % display('Y Pelvis Time!')
    end
    
    if Td>=T_dc_p_ay || T_dc_p_ay>=T_dc_p_by || T_dc_p_by>=T_dc_p_cy  || T_dc_p_cy>=T_dc
        J=100*kJ;
        kJ=kJ+1;
        % display('Y Pelvis Time!')
    end
    
    
    if Td/2>=T_dc_p_az || T_dc_p_az>=T_dc_p_bz || T_dc_p_bz>=T_dc
        J=100*kJ;
        kJ=kJ+1;
        % display('Z Pelvis Time!')
    end
    
    
    if 0>=T_dc_a_a || T_dc_a_a>=T_dc_a_b || T_dc_a_b>=T_dc_a_c  || T_dc_a_c>=T_dc
        J=100*kJ;
        kJ=kJ+1;
        % display('end Ankle Time!')
    end
    
end

if kJ==1
    run Coeff_array
    
    % Tarjectory
     clear q p dq dp ddq r dr ddr
    sim('test_trajectories',Motion_Time)
    p=simout.signals.values; % task-space trajectory
    dp=simout7.signals.values; % task-space trajectory
    r=simout1.signals.values; %trajectories  
    q=simout4.signals.values;
    dq=simout5.signals.values;
%     ddq=simout6.signals.values;
      
    r_p = p(:,1:3); % pelvis position
    x_p = r_p(:,1);
    y_p = r_p(:,2);
    z_p = r_p(:,3);
    q_p = p(:,4:6); % pelvis rotation
    alpha_p = q_p(:,1);
    beta_p  = q_p(:,2);
    gamma_p = q_p(:,3);
    
    dr_p = dp(:,1:3); % pelvis velocity
    dx_p = dr_p(:,1);
    dy_p = dr_p(:,2);
    dz_p = dr_p(:,3);
    dq_p = dp(:,4:6); % pelvis angular velocity
    dalpha_p = dq_p(:,1);
    dbeta_p = dq_p(:,2);
    dgamma_p = dq_p(:,3);
    
    q_fr = q(:,1:3);
    q_fl = q(:,4:6);
    q_hr = q(:,7:10);
    q_hl = q(:,11:14);
    
    dq_fr = dq(:,1:3);
    dq_fl = dq(:,4:6);
    dq_hr = dq(:,7:10);
    dq_hl = dq(:,11:14);
    
%     r_knee_fr = r(:,28:30);
%     r_knee_fl = r(:,31:33);

    clear simout simout1 simout2 simout3 simout4 simout5 simout6 simout7
    % Constraints
    
    if SCR==3
        
        dxp_min=min(dx_p(5:end-5));
        if dxp_min<0
            J=100*kJ;
            kJ=kJ+1;
            % display('dxp < 0 !')
        end
              
        q1_fl_min = min(q_fl(:,1));q1_fl_max = max(q_fl(:,1));
        q1_fr_min = min(q_fr(:,1));q1_fr_max = max(q_fr(:,1));
        
        if or(or(q1_fl_min<(-46*pi/180),q1_fl_max>(46*pi/180)),or(q1_fr_min<(-46*pi/180),q1_fr_max>(46*pi/180)))%,q4_min>(20*pi/180))
            J=100*kJ;
            kJ=kJ+1;
            % display('Singularity at Knee !')
        end
        
        q1_hl_min = min(q_hl(:,1));q1_hl_max = max(q_hl(:,1));
        q1_hr_min = min(q_hr(:,1));q1_hr_max = max(q_hr(:,1));
        
        if or(or(q1_hl_min<(-46*pi/180),q1_hl_max>(46*pi/180)),or(q1_hr_min<(-46*pi/180),q1_hr_max>(46*pi/180)))%,q4_min>(20*pi/180))
            J=100*kJ;
            kJ=kJ+1;
            % display('Singularity at Hip !')
        end
        
        q3_fl_min = min(q_fl(:,3));q3_fl_max = max(q_fl(:,3));
        q3_fr_min = min(q_fr(:,3));q3_fr_max = max(q_fr(:,3));
%         
        if or(or(abs(q_fr(:,3))<(10*pi/180),abs(q_fl(:,3))<(10*pi/180)),or(abs(q_hr(:,4))<(10*pi/180),abs(q_hl(:,4))<(10*pi/180)))%,q4_min>(20*pi/180))
            J=100*kJ;
            kJ=kJ+1;
            % display('Singularity at Knee !')
        end
        
    elseif SCR==4
        
        %     yp=w(1:i,2);
        %     if min(yp)<-y_st_max
        %         J=100*kJ;
        %         kJ=kJ+1;
        %     %     % display('yp > ye !')
        %     end
        %     size(dz_p)
        
        dzp_min=min(dz_p(3:i-2));
        if dzp_min>0.01
            J=100*kJ;
            kJ=kJ+1;
            % display('dzp > 0 !')
        end
        
          q4_min=min(min(q(k+2:end-3,[3 6])));
        if q4_min<(5*pi/180)
            J=100*kJ;
            kJ=kJ+1;
            % display('Singularity at Knee!')
        end
        
    elseif SCR==5
        
        %     yp=w(:,2);
        %     figure
        %     plot(t,yp)
        %     if max(yp(j:end-3))>y_end_max
        %         J=100*kJ;
        %         kJ=kJ+1;
        %         display('yp > ye!')
        %     end
        
        dzp_min=min(dz_p(j+3:end-3));
        if dzp_min<-0.01
            J=100*kJ;
            kJ=kJ+1;
            % display('dzp < 0 !')
        end
        
        q4_min=min(min(q(3:f-2,[4 10])));
        if q4_min<(5*pi/180)
            J=100*kJ;
            kJ=kJ+1;
            % display('Singularity at Knee!')
        end
        
    end
end
%% Gold Function
if kJ==1
    J=Limit_ZMP; % Gold function
end
% J
% pause
%% Output
if J<J_min
    J_min=J;
    if SCR==3
        Q_min=[Sc Rse R_zp R_Td q3_fl_min*(180/pi) q3_fl_max*(180/pi) J];
        Q_out=[Q_min V Ds SCR];
        save('Q_out.mat', 'Q_out')
        fprintf('\n Sc:%6.4f   Rse:%6.4f  R_zp:%6.4f   R_Td:%6.4f  q_knee_min:%6.1f   q_knee_max:%6.1f   J:%6.4f\n', Sc, Rse, R_zp, R_Td, q3_fl_min*(180/pi), q3_fl_max*(180/pi), J);
    elseif SCR==4
        Q_min=[Rac_1 Rac_2 Rac_3 Rac_4 Rac_5 ini1 ini2  J];
        Q_out=[Q_min V Ds SCR];
        save('Q_out.mat', 'Q_out')
        fprintf('\n Rac_1:%6.4f   Rac_2:%6.4f   Rac_3:%6.4f   Rac_4:%6.4f   Rac_5:%6.4f  ini1:%6.4f   ini2:%6.4f   J:%6.4f\n', Rac_1, Rac_2, Rac_3, Rac_4, Rac_5,ini1, ini2, J);
    elseif SCR==5
        Q_min=[Rdc_1 Rdc_2 Rdc_3 Rdc_4 Rdc_5 Rdc_6 Rdc_7 Rdc_8 0 J];
        Q_out=[Q_min V Ds SCR];
        save('Q_out.mat', 'Q_out')
        fprintf('\n Rdc_1:%6.4f   Rdc_2:%6.4f   Rdc_3:%6.4f   Rdc_4:%6.4f   Rdc_5:%6.4f   Rdc_6:%6.4f   Rdc_7:%6.4f   Rdc_8:%6.4f   J:%6.4f\n', Rdc_1, Rdc_2, Rdc_3, Rdc_4, Rdc_5, Rdc_6, Rdc_7, Rdc_8, J);
    end
end
end