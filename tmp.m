function [Time,P,dP,ddP]=tmp(time,p,dp,ddp,T_i,T_f)

% size(time)
u=max(find(time<=T_i));
v=min(find(time>=T_f));

if isempty(u)
    u=1;
end

if isempty(v)
    v=length(time);
end

Time=time(u:v);
P=p(u:v);
dP=dp(u:v);
ddP=ddp(u:v);
end