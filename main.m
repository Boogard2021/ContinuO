clear all
clc
close all
warning('off','all')

%% Walking Parameters
global V Tc Ds
global T_ac T_dc
global N Step_Time
global SCR
global redundant 

fprintf('Operation Mode:\n')  
fprintf('     0. Walking\n');
fprintf('     1. Trotting\n');
fprintf('     2. Walking with Start and End Pahse\n');
fprintf('     3. Walking Optimization\n');
fprintf('     4. Start Pahse Optimization\n');
fprintf('     5. End Pahse Optimization\n\n');
SCR=input('Please input the number of operation mode: ');

redundant = 0;
V=0.1; % Velocity of motion 0.1 0.2 0.3 0.4
% Ds = 0.05;
Ds = 0.1;
% Ds = 0.15;
% Ds = 0.2;
% Ds = 0.25;
Tc=Ds*3.6/V;

T_ac=0;
T_dc=0;
    
N=1;%Number of stride
Step_Time=0.01; % step time

fprintf('\n\nWalking On Flat Surface\n');
fprintf('Speed: %6.2f Km/h\n', V);
fprintf('Step Length: %6.1f cm\n', 100*Ds);
fprintf('Stride: %6.0f\n', N);
fprintf('Step_Time: %6.0f msec\n\n', 1000*Step_Time);
%% Properties
run quad_properties
run walking_parameters
%% Variables & Coefficients
if or(SCR==2,or(SCR==0,SCR==1))
    
    if or(SCR==0,SCR==1) 
        T_ac=0;
        T_dc=0;
    end
    run main_optimum_variables 
    run main_key_parameters 
    run main_time

    run start_optimum_variables
    run start_key_parameters 
    run start_time

    run end_optimum_variables
    run end_key_parameters 
    run end_time
    
    run Coeff_array 

elseif SCR==3
    
    T_ac=0;
    T_dc=0;
    run start_optimum_variables
    run start_key_parameters 
    run start_time

    run end_optimum_variables
    run end_key_parameters 
    run end_time
    
elseif or(SCR==4,SCR==5)
    
    if SCR==4
        T_dc=0;
    elseif SCR==5
        T_ac=0;
    end
    
    run main_optimum_variables
    run main_key_parameters
    run main_time
    
    if SCR==4
        run end_optimum_variables
        run end_key_parameters
        run end_time
    elseif SCR==5
        run start_optimum_variables
        run start_key_parameters
        run start_time
    end
end

%% Optimization
if and(SCR~=2,and(SCR~=0,SCR~=1))
    run Optimization
end
%% Plot
global m mt
m_cont=1;
while m_cont~=0
    
    fprintf('\nPlot Mode:\n')
    fprintf('     0. Exit\n');
    fprintf('     1. Task Space Trajectory\n');
    fprintf('     2. Angle Joints\n');
    fprintf('     3. Angular Velocity of Links\n');
    fprintf('     4. Ponit of Interest Trajectory\n');
    fprintf('     5. Motion Simulation\n');
    fprintf('     6. COM\n');
    fprintf('     7. ZMP Trajectory, Stability Margin\n');
    fprintf('     8. Load Torque, Reaction Force and Moment \n \n');
%     fprintf('     9. Inverse Kinematics Validation\n');
%     fprintf('     10. Inverse Dynamic Validation\n'); 
%     fprintf('     11. Knee Mechanism\n');
%     fprintf('     12. Ankle Mechanism\n');
%     fprintf('     13. Joint Power\n');
%     fprintf('     14. Motion Simulation\n');
%     fprintf('     15. Data for Yobotics Software\n');
    fprintf('     16. Position and Velocity Data for Joints\n\n');
    fprintf('     17. Simmech\n\n');

    m=input('Please input the number of plot mode: ');
%     if m==0
%        m_cont=0;
%     else
%         if m==8
%            fprintf('\nDynamic Equation Method:\n') 
%            fprintf('     1. Kane (Fast)\n')
%            fprintf('     2. Lagrange (Slow)\n')
%            mt=input('\nPlease input the number of Method: ');
           
%         end
      run Plot_Test
        
      m_cont=input('\nIf you want to continue press 1 otherwise 0: ');
        
    end

fprintf('\nDone! :) \n');
