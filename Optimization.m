global N Step_Time
% global T_ac T_dc
global SCR
%% Setting Condition

N=1; %Number of stride
Step_Time=0.002; % step time
%% Optimization (Main Variables)
global Q_min
disp('Optimization Process ...')
run main_OPT
disp('\n Done!\n\n')

if SCR==3
    
    u=Q_min(1:6)
    J_opt=Q_min(end)
    
    Sc=u(1);
    Rse=u(2);
%     Rd=u(3);
%     Rm=u(4);
    R_zp=u(3);
    R_Td=u(4);
    
    diary('Optimum Variables')
    
    diary on
    
    disp('Optimum Variables:')
    fprintf('\n Sc=%6.4f;\n', Sc);
    fprintf('Rse=%6.4f;\n', Rse);
%     fprintf('Rd=%6.4f;\n', Rd);
%     fprintf('Rm=%6.4f;\n', Rm);
    fprintf('R_zp=%6.4f;\n', R_zp);
    fprintf('R_Td=%6.4f;\n', R_Td);
    
    diary off
    
elseif SCR==4
    
    u=Q_min(1:8)
    J_opt=Q_min(end)
    
    Rac_1=u(1);
    Rac_2=u(2);
    Rac_3=u(3);
    Rac_4=u(4);
    %     Rac_5=u(5);
    %     Rac_6=u(6);
    %     Rac_7=u(7);
    %     Rac_8=u(8);
    ini1=u(5);
    ini2=u(6);
    
    diary('Optimum Start Time Variables')
    
    diary on
    
    disp('Optimum Start Time Variables:')
    fprintf('\n Rac_1=%6.4f;\n', Rac_1);
    fprintf('Rac_2=%6.4f;\n', Rac_2);
    fprintf('Rac_3=%6.4f;\n', Rac_3);
    fprintf('Rac_4=%6.4f;\n', Rac_4);
    fprintf('ini1=%6.4f;\n', ini1);
    fprintf('ini2=%6.4f;\n', ini2);
%     fprintf('Rac_7=%6.4f;\n', Rac_7);
%     fprintf('Rac_8=%6.4f;\n', Rac_8);
    
    diary off
    
elseif SCR==5
    
    u=Q_min(1:8)
    J_opt=Q_min(end)
    
    Rdc_1=u(1);
    Rdc_2=u(2);
    Rdc_3=u(3);
    Rdc_4=u(4);
    Rdc_5=u(5);
    Rdc_6=u(6);
    Rdc_7=u(7);
    Rdc_8=u(8);
    
    diary('Optimum Start Time Variables')
    
    diary on
    
    disp('Optimum Start Time Variables:')
    fprintf('\n Rdc_1=%6.4f;\n', Rdc_1);
    fprintf('Rdc_2=%6.4f;\n', Rdc_2);
    fprintf('Rdc_3=%6.4f;\n', Rdc_3);
    fprintf('Rdc_4=%6.4f;\n', Rdc_4);
    fprintf('Rdc_5=%6.4f;\n', Rdc_5);
    fprintf('Rdc_6=%6.4f;\n', Rdc_6);
    fprintf('Rdc_7=%6.4f;\n', Rdc_7);
    fprintf('Rdc_8=%6.4f;\n', Rdc_8);
    
    diary off
end
