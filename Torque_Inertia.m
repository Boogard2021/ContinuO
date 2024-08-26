function Tau=Torque_Inertia(P)
% size(P)
%% Input
ddq=P(1:15);
tau=P(16:30);
%%
global J_actuator_leg J_actuator_waist
tau_ddq=[J_actuator_leg;J_actuator_leg;J_actuator_waist].*ddq;
Tau=tau+tau_ddq;
end