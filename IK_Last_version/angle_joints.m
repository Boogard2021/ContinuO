function q = angle_joints(q1,p,dy,dz)

global L1 L2 L3 
P_sho_hip = trans([],[-L1(1),-L1(2),-L1(3)]);

%% Front Right
Rq1 = rot(1,q1,4);
r_0_hip=  Rq1*P_sho_hip*[0;0;0;1];

delta_x= r_0_hip(1)-p(1);
delta_y= r_0_hip(2)-p(2);
delta_z= r_0_hip(3)-p(3);
r_0 = sqrt(dy^2+dz^2-L1(2)^2);

h_1 = sqrt(delta_x^2+r_0^2);
phi = asin(delta_x/h_1);
if abs((h_1^2+L2^2-L3^2)/(2*h_1*L2))>1
    ratio = 1;
else
    ratio = (h_1^2+L2^2-L3^2)/(2*h_1*L2);
end
q2 = phi-acos(ratio);
if abs((L3^2+L2^2-h_1^2)/(2*L3*L2))>1
    ratio1 = -1;
else
    ratio1 = (L3^2+L2^2-h_1^2)/(2*L2*L3);
end
q3 = pi-acos(ratio1);

q = [q2,q3];
% pause
end