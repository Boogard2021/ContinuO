function [x,v,a]=pva(t,time,cof)
% if or(t<time(1),t>time(end))
%     disp('Out of time interval!')
%     return;
% end

[e,i]=max(diff(sign(time-t)));
ti=time(i);
% tf=time(i+1);

T=[(t-ti)^5 ; (t-ti)^4 ; (t-ti)^3 ; (t-ti)^2 ; (t-ti) ; 1];
x=cof(i,:)*T;
v=cof(i,:)*diag([5 4 3 2 1],1)*T;
a=cof(i,:)*diag([5 4 3 2 1],1)^2*T;
end