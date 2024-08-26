function  Pos =  Knee_pos(ankle_pos,alpha) 
global L4
y = ankle_pos(2)+L4(2);
x = ankle_pos(1)+L4(1)*cos(alpha)-L4(3)*sin(alpha);
z = ankle_pos(3)+L4(1)*sin(alpha)+L4(3)*cos(alpha);
Pos = [x,y,z];
end
