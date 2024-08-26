function J=Limit_ZMP
global Tc
global Motion_Time
global Td


sim('test_ZMP',Motion_Time)
v=simout.signals.values;
time=simout.time;
x_zmp=v(5:end-5,1); % Actual ZMP Position in x 
y_zmp=v(5:end-5,2); % Actual ZMP Position in y 
offset_zmp=v(5:end-5,3); % Actual ZMP Position in y 
%%
T=time(5:end-5); % time of motion

J=-1/sum(offset_zmp);
end
% 
%  Sc:0.5374   Rse:0.8466  R_zp:0.6274   R_Td:0.3846  q_knee_min:-117.8   q_knee_max: -62.2   J:-0.0046
