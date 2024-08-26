function O=pelvis_trajectory(t)
%% Input
global Tc Ds qs
global zp_max zp_max_st zp_max_end
global Tmdz Tmdy Td Tmsz Tmsy

global T_st T_st_p_ax T_st_p_ay T_st_p_by T_st_p_cy T_st_p_az T_st_p_bz T_st_p_cz T_st_p_aq
global y_st_max
global la L_sh L_th L_inth

global T_Gait N_Stride
global T_end_p_ax T_end

global T_end_p_ay T_end_p_by T_end_p_cy
global T_end_p_az T_end_p_bz T_end_p_cz

global T_end_p_aq

global Cx_p Cy_p Cz_p Cq
global Cx_st_p Cy_st_a Cy_st_b Cz_st_a Cz_st_b Cq_st
global Cx_end_p Cy_end_a Cy_end_b Cz_end_a Cz_end_b Cq_end
global omega L_pl

if or(t<=T_st,t>T_Gait)
    N=0;
elseif and(t>T_st,t<T_Gait)
    N=floor((t-T_st)/(2*Tc));
    t=rem((t-T_st),2*Tc)+T_st;
elseif t==T_Gait
    N=N_Stride;
    t=0;
end

%% Pelvis trajectory
%% X direction
if t<=T_st_p_ax
    xp=0;
elseif and(t>T_st_p_ax,t<=T_st)
    xp=polyval(Cx_st_p,t);
elseif and(t>T_st,t<=(Td+T_st))
    xp=polyval(Cx_p(1:4),t-T_st);
elseif and(t>(Td+T_st),t<=(Tc+T_st))
    xp=polyval(Cx_p(5:8),t-T_st);   
elseif and(t>(Tc+T_st),t<=(Tc+Td+T_st))
    xp=polyval(Cx_p(1:4),t-Tc-T_st)+Ds;
elseif and(t>(Tc+Td+T_st),t<=(2*Tc+T_st))
    xp=polyval(Cx_p(5:8),t-Tc-T_st)+Ds;    
elseif and(t>T_Gait,t<(T_Gait+Td))
    xp=polyval(Cx_p(1:4),t-T_Gait)+2*N_Stride*Ds;     
elseif and(t>=(T_Gait+Td),t<T_end_p_ax)
    xp=polyval(Cx_end_p,t);
    
elseif and(t>=T_end_p_ax,t<=(T_Gait+Td+T_end))
    xp=(2*N_Stride+1)*Ds;     
end

if and(T_st==0,t==0)
    xp=Cx_p(4);
end

xp=xp+2*Ds*N;

%% Y direction
if t<=T_st_p_ay
    yp=0;
elseif and(t>T_st_p_ay,t<=T_st_p_by)
    yp=polyval(Cy_st_a,t);
elseif and(t>T_st_p_by,t<=T_st_p_cy)
    yp=-y_st_max;
elseif and(t>T_st_p_cy,t<=T_st)
    yp=polyval(Cy_st_b,t); 
elseif and(t>T_st,t<=(Tmdy+T_st))
    yp=-polyval(Cy_p(6:10),t+Tc-T_st);
elseif and(t>(Tmdy+T_st),t<=(Tmsy+T_st))
    yp=polyval(Cy_p(1:5),t-T_st);
elseif and(t>(Tmsy+T_st),t<=(Tc+Tmdy+T_st))
    yp=polyval(Cy_p(6:10),t-T_st);
elseif and(t>(Tc+Tmdy+T_st),t<=(Tc+Tmsy+T_st))
    yp=-polyval(Cy_p(1:5),t-Tc-T_st);
elseif and(t>(Tc+Tmsy+T_st),t<=(2*Tc+T_st))
    yp=-polyval(Cy_p(6:10),t-Tc-T_st);    
elseif and(t>T_Gait,t<=(Tmdy+T_Gait))
    yp=-polyval(Cy_p(6:10),t+Tc-T_Gait); 
elseif and(t>(Tmdy+T_Gait),t<=(Td+T_Gait))
    yp=polyval(Cy_p(1:5),t-T_Gait);
elseif and(t>(Td+T_Gait),t<=T_end_p_ay)
    yp=polyval(Cy_end_a,t);
elseif and(t>T_end_p_ay,t<=T_end_p_by)
    yp=y_st_max;
elseif and(t>T_end_p_by,t<=T_end_p_cy)
    yp=polyval(Cy_end_b,t);
elseif and(t>T_end_p_cy,t<=(T_Gait+Td+T_end))
    yp=0;
end

if and(T_st==0,t==0)
    yp=-polyval(Cy_p(6:10),Tc);
end
%% Z direction
if t<=T_st_p_az
    zp=la+L_sh+L_th+L_inth*cos(omega)-0.5*L_pl*sin(omega);
elseif and(t>T_st_p_az,t<=T_st_p_bz)
    zp=polyval(Cz_st_a,t);
elseif and(t>T_st_p_bz,t<=T_st_p_cz)
    zp=zp_max_st;
elseif and(t>T_st_p_cz,t<=T_st)    
    zp=polyval(Cz_st_b,t);
    
elseif and(t>T_st,t<=(Tmdz+T_st))
    zp=polyval(Cz_p(5:8),t+Tc-T_st);
elseif and(t>(Tmdz+T_st),t<=(Tmsz+T_st))
    zp=polyval(Cz_p(1:4),t-T_st);
elseif and(t>(Tmsz+T_st),t<=(Tc+Tmdz+T_st))
    zp=polyval(Cz_p(5:8),t-T_st);
elseif and(t>(Tc+Tmdz+T_st),t<=(Tc+Tmsz+T_st))
    zp=polyval(Cz_p(1:4),t-Tc-T_st);
elseif and(t>(Tc+Tmsz+T_st),t<=(2*Tc+T_st))
    zp=polyval(Cz_p(5:8),t-Tc-T_st);
    
elseif and(t>T_Gait,t<=(Tmdz+T_Gait))
    zp=polyval(Cz_p(5:8),t+Tc-T_Gait);
    
elseif and(t>(Tmdz+T_Gait),t<=(Td+T_Gait)) 
    zp=polyval(Cz_p(1:4),t-T_Gait);
    
elseif and(t>(Td+T_Gait),t<=T_end_p_az)
    zp=polyval(Cz_end_a,t);    
elseif and(t>T_end_p_az,t<=T_end_p_bz)
    zp=zp_max_end;
elseif and(t>T_end_p_bz,t<=T_end_p_cz)
    zp=polyval(Cz_end_b,t);
end
    
if and(T_st==0,t==0)
    zp=polyval(Cz_p(5:8),Tc);
end

%% Roll Rotation x
alpha_p=0;
%% Pitch Rotation y
beta_p=0;
%% Yaw Rotation z
if t<=T_st_p_aq
    gama_p=0;
elseif and (t>T_st_p_aq,t<=T_st)
    gama_p=polyval(Cq_st,t);
elseif and(t>T_st,t<=(Td+T_st))
    gama_p=-qs;
elseif and(t>(Td+T_st),t<=(Tc+T_st))
    gama_p=polyval(Cq,t-T_st);
elseif and(t>(Tc+T_st),t<=(Tc+Td+T_st))
    gama_p=qs;
elseif and(t>(Tc+Td+T_st),t<=(2*Tc+T_st))
    gama_p=-polyval(Cq,t-Tc-T_st);
elseif and(t>T_Gait,t<=(Td+T_Gait))
    gama_p=-qs;
elseif and (t>(Td+T_Gait),t<=T_end_p_aq)
    gama_p=polyval(Cq_end,t);
elseif and(t>T_end_p_aq,t<=(T_Gait+Td+T_end))
    gama_p=0;    
end

if and(T_st==0,t==0)
    gama_p=-qs;
end
%% OutPut
r_p=[xp;yp;zp];
q_p=[alpha_p;beta_p;gama_p];
O=[r_p;q_p];
end