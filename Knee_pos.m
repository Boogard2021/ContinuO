function  Pos =  Knee_pos(foot_pos,alpha,leg,L4) 

if leg==1 %Hind Right
    y = foot_pos(2)+L4(2);
    x = foot_pos(1)+L4(1)*cos(alpha)-L4(3)*sin(alpha);
    z = foot_pos(3)+L4(1)*sin(alpha)+L4(3)*cos(alpha);
else  %Hind Left
    y = foot_pos(2)-L4(2);
    x = foot_pos(1)+L4(1)*cos(alpha)-L4(3)*sin(alpha);
    z = foot_pos(3)+L4(1)*sin(alpha)+L4(3)*cos(alpha);
end
    Pos = [x,y,z];
end
