%% Time related to Steady State (SS) Stage 
global Td Tc
global Tm Ts
global N
global T_ac T_dc
global Motion_Time

Ts=Tc-Td; % time duration of SSP (Single Support Phase)
Tm=Td+0.50*Ts; % (Tm, lss, hss) The time that ankle reaches its maximum distance in z direction    
Motion_Time=T_ac+N*(2*Tc)+T_dc; % duration of motion for n stride