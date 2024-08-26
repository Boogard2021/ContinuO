function  Pos =  FK(q) 
global L1 L2 L3 L4

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
%% Rotation
Rq1 = rot(1,q1,4);
Rq2 = rot(2,q2,4);
Rq3 = rot(2,q3,4);
Rq4 = rot(2,q4,4);

%% Translation
P_shd = trans([],[0;0;0]);
P_hip = trans([],-L1);
P_knee = trans(3,-L2);
P_knee_mid = trans(3,-L3);
P_ankle = trans([],-L4);

%% Transformations
r_shd = P_shd*[0;0;0;1];
r_hip = P_shd*Rq1*P_hip*[0;0;0;1];
r_knee = P_shd*Rq1*P_hip*Rq2*P_knee*[0;0;0;1];
r_knee_mid = P_shd*Rq1*P_hip*Rq2*P_knee*Rq3*P_knee_mid*[0;0;0;1];
r_ankle = P_shd*Rq1*P_hip*Rq2*P_knee*Rq3*P_knee_mid*Rq4*P_ankle*[0;0;0;1];

Pos = [r_shd(1:3);r_hip(1:3);r_knee(1:3);r_knee_mid(1:3);r_ankle(1:3)];
end
