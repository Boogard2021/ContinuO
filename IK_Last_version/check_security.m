function y = check_security(q)
y= zeros(2,4);
global lower_joint_limits upper_joint_limits
for i=1:4
    if (q(i) - upper_joint_limits(i) >= 0)
        y(1,i) = 0;
    else
        y(1,i)=1;
    end
    if (q(i) - lower_joint_limits(i) <= 0)
        y(2,i) = 0;
    else
        y(2,i)=1;
    end
end
end