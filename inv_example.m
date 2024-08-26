% Robot_Advanced_Real.m</pre></p><pre><code>% Copied from matlab and adapted for my scenario.
% Creates robot, uses IK to calculate positions, Creates animation

% Initialize MATLAB
clear all;
close all;
clc;
tic;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Building Robot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start with Blank RigidTreeBody Model
robot = rigidBodyTree('DataFormat','column','MaxNumBodies',5);

% Specify Arm Lengths of the Robot Arm. Units: [mm]
L1 = 28.45;
L2 = 75.41;
L3 = 70.02;
L4 = 87.14;

% Height of robot body off of Ground
G = 100;

% Add first body with joint. Set as robot base.
body = rigidBody('link1');
joint1 = rigidBodyJoint('joint1', 'revolute');
setFixedTransform(joint1,trvec2tform([0 0 G]));
joint1.JointAxis = [0 0 1];
joint1.HomePosition = pi/6;
% joint.PositionLimits = [0, pi];
body.Joint = joint1;
addBody(robot, body, 'base');

% Add second body with joint. Attach to First
body = rigidBody('link2');
joint2 = rigidBodyJoint('joint2','revolute');
setFixedTransform(joint2, trvec2tform([L1,0,0]));
joint2.JointAxis = [0 1 0];
joint2.HomePosition = pi/6;
% joint.PositionLimits = [0, pi];
body.Joint = joint2;
addBody(robot, body, 'link1');

% Add third body with joint. Attach to second
body = rigidBody('link3');
joint3 = rigidBodyJoint('joint3','revolute');
setFixedTransform(joint3, trvec2tform([L2,0,0]));
joint3.JointAxis = [0 1 0];
joint3.HomePosition = pi/6;
% joint.PositionLimits = [0, pi];
body.Joint = joint3;
addBody(robot, body, 'link2');

% Add fourth body with joint. Attach to third
body = rigidBody('link4');
joint4 = rigidBodyJoint('joint4','revolute');
setFixedTransform(joint4, trvec2tform([L3,0,0]));
joint4.JointAxis = [0 1 0];
joint4.HomePosition = pi/6;
% joint.PositionLimits = [0, pi];
body.Joint = joint4;
addBody(robot, body, 'link3');

% Add End Effector with Fixed Joint. Attach to final body.
body = rigidBody('tool');
joint = rigidBodyJoint('fix1','fixed');
setFixedTransform(joint, trvec2tform([L4, 0, 0]));
body.Joint = joint;
addBody(robot, body, 'link4');

% View Robot Input details to review setup
showdetails(robot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Trajectory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Define series of [x y z] for arc step.
% Define parameters of the arc.
xCenter = 0;
yCenter = 120;
zCenter = 0;
xRadius = 70;
yRadius = 20;
zRadius = 20;

% Define the angle theta as going from 30 to 150 degrees in 100 steps.
theta = linspace(30, 150, 100);
% Define x and y using "Degrees" version of sin and cos.
x = (xRadius * cosd(theta) + xCenter)'; 
y = (yRadius * sind(theta) + yCenter)'; 
z = (zRadius * sind(theta) + zCenter)';

% Points around circle
% points = center + [x y z];
points = [x y z];
count  = length(x);

% Check
% plot3(points(:,1),points(:,2),points(:,3))
plot3(x,y,z)
hold on
plot3(points(:,1),points(:,2),points(:,3),'k')
xlabel('x')
ylabel('y')
zlabel('z')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Inverse Kinematics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use IK object to find a solution to the joint configurations that achieve
% end effector coordinates along ttrajectory

% Pre-allocate configuration solutions as a matrix, qs
q0 = homeConfiguration(robot);
ndof = length(q0);
qs = zeros(count, ndof);

% create the IK Solver.
ik = inverseKinematics('RigidBodyTree', robot);

% Use desired weights for solution (First three are orientation, last three are translation)
% Since it is a 4-DOF robot with only one revolute joint in Z we do not
% put a weight on Z rotation; otherwise it limits the solution space
% weights = [0, 0, 0, 1, 1, 0];
weights = [0.1, 0.1, 0, 1, 1, 1];
endEffector = 'tool';

% Loop through the trajectory and store the configurations. IK is used to
% give joint configurations.
qInitial = q0; % Use home configuration as the initial guess
for i = 1:count
    % Solve for the configuration satisfying the desired end effector
    % position
    point = points(i,:);
    qSol = ik(endEffector,trvec2tform(point),weights,qInitial);
    % Store the configuration
    qs(i,:) = qSol;
    % Start from prior solution
    qInitial = qSol;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Animate Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Show first configuration. Show trajectory.
figure
show(robot,qs(1,:)');
ax = gca;
ax.Projection = 'orthographic';
hold on
plot3(points(:,1),points(:,2),points(:,3),'k')
view([-37.5 30])

% Set up animation. Show robot in each configuration on trajectory
framesPerSecond = 7;
r = rateControl(framesPerSecond);
for i = 1:count
    show(robot,qs(i,:)','PreservePlot',false);
    drawnow
    waitfor(r);
end

toc