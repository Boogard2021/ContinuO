function cof=coeff(time,p,dp,ddp)
% p, dp and ddp are row vectors which indicate position, velocity and
% acceleration
% time
n=length(time)-1;
if n~=(length(p)-1)
    disp('Size of position Error!')
    return;
end

if n~=(length(dp)-1)
    disp('Size of velocity Error!')
    return;
end

if n~=(length(ddp)-1)
    disp('Size of acceleration Error!')
    return;
end

if min(diff(time))<=0
    disp('Time Error!')
    display(time)
    return;
end

A=zeros(6*n,6*n);
H=zeros(6*n,6*n);
M=zeros(6*n,3*(n+1));
for i=1:n
    ti=time(i);
    tf=time(i+1);
    
    Ai =[6/(- tf^5 + 5*tf^4*ti - 10*tf^3*ti^2 + 10*tf^2*ti^3 - 5*tf*ti^4 + ti^5), -3/(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4), -1/(2*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3)), -6/(- tf^5 + 5*tf^4*ti - 10*tf^3*ti^2 + 10*tf^2*ti^3 - 5*tf*ti^4 + ti^5), -3/(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4), 1/(2*(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3));
        15/(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4),                8/(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3),                3/(2*(tf^2 - 2*tf*ti + ti^2)),                  -15/(tf^4 - 4*tf^3*ti + 6*tf^2*ti^2 - 4*tf*ti^3 + ti^4),                7/(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3),                  -1/(tf^2 - 2*tf*ti + ti^2);
        -10/(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3),                             -6/(tf^2 - 2*tf*ti + ti^2),                             -3/(2*(tf - ti)),                                 10/(tf^3 - 3*tf^2*ti + 3*tf*ti^2 - ti^3),                             -4/(tf^2 - 2*tf*ti + ti^2),                             1/(2*(tf - ti));
        0,                                                      0,                                          1/2,                                                                        0,                                                      0,                                           0;
        0,                                                      1,                                            0,                                                                        0,                                                      0,                                           0;
        1,                                                      0,                                            0,                                                                        0,                                                      0,                                           0];
    % alpha(i)=Ai*X(i)
    
    Hi=[ (400*(tf - ti)^7)/7,      40*(tf - ti)^6, 24*(tf - ti)^5, 10*(tf - ti)^4, 0, 0;
        40*(tf - ti)^6, (144*(tf - ti)^5)/5, 18*(tf - ti)^4,  8*(tf - ti)^3, 0, 0;
        24*(tf - ti)^5,      18*(tf - ti)^4, 12*(tf - ti)^3,  6*(tf - ti)^2, 0, 0;
        10*(tf - ti)^4,       8*(tf - ti)^3,  6*(tf - ti)^2,    4*tf - 4*ti, 0, 0;
        0,                   0,              0,              0, 0, 0;
        0,                   0,              0,              0, 0, 0];
    %Hi=int(ddT*ddT',t,ti,tf)
    
    A(6*(i-1)+1:6*i,6*(i-1)+1:6*i)=Ai; % alpha=A*X
    H(6*(i-1)+1:6*i,6*(i-1)+1:6*i)=Hi;
    
    M(6*(i-1)+1:6*i,3*(i-1)+1:3*(i+1))=eye(6,6);
    % X=M*x;
end
F=(A*M)'*H*(A*M); % J=(1/2)x'*F*x;

x=reshape([p;dp;ddp],[3*(n+1) 1]);
u=find(isinf(x)==1);
v=find(isinf(x)==0);

if isempty(u)==0
    
    for i=1:length(u)
        for j=1:length(u)
            Fuu(i,j)=F(u(i),u(j));
        end
    end
    
    for i=1:length(v)
        for j=1:length(v)
            Fvv(i,j)=F(v(i),v(j));
        end
    end
    
    for i=1:length(u)
        for j=1:length(v)
            Fuv(i,j)=F(u(i),v(j));
        end
    end
    
    for i=1:length(v)
        for j=1:length(u)
            Fvu(i,j)=F(v(i),u(j));
        end
    end
    
    G=[Fuu Fuv;
        Fvu Fvv];
    
    xv=x(v);
    b=0.5*(xv'*Fvu+xv'*Fuv');
    C=0.5*(Fuu'+Fuu);
    
    x_inf=-inv(C)*b';
    x(u,1)=x_inf;
    
end

c=A*M*x;
cof=reshape(c,[6 n])';
end