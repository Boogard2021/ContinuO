function [polycoef]=Coefficient(xp,ord,con,fig_res)

n=size(xp,2);

if (size(xp,1)~=1)||(size(xp,2)~=n)||(size(ord,1)~=1)||(size(ord,2)~=n-1)||(size(con,1)~=3)||(size(con,2)~=n)
    disp('Size Error!')
    return;
end

if isinf(con(:,1))~=isinf(con(:,n))
    disp('con matrix is wrong!')
    return;
end

c1=isinf(con(:,[1,n]));
c2=isinf(con(:,2:end-1));
c3=isnan(con(:,[1,n]));
c4=isnan(con(:,2:end-1));
connum=sum(c1(:))/2+6-sum(c1(:))-sum(c3(:))+sum(c2(:))+2*(3*(n-2)-sum(c2(:))-sum(c4(:)));

if connum>sum(ord)+length(ord)
    disp('ord array does not match the constraints! Increase the ord array.')
    return;
end

A=zeros(connum,sum(ord)+length(ord));
C=zeros(connum,1);

syms t
coef=[1 t t^2 t^3 t^4 t^5 t^6 t^7 t^8 t^9 t^10 t^11 t^12 t^13 t^14 t^15 t^16 t^17 t^18 t^19 t^20];
dcoef=diff(coef,t);
ddcoef=diff(dcoef,t);
P=[coef;dcoef;ddcoef];

ord=[0 ord];

count=0;
for i=1:n
    for j=1:3
        if (con(j,i)~=inf)&&~(isnan(con(j,i)))
            if i==1
                count=count+1;
                C(count,1)=con(j,i);
                A(count,(sum(ord(1:i))+i):(sum(ord(1:i+1))+i))=subs(P(j,1:(ord(i+1)+1)),t,xp(i))
            elseif i==n
                count=count+1;
                C(count,1)=con(j,i);
                A(count,(sum(ord(1:i-1))+i-1):(sum(ord(1:i))+i-1))=subs(P(j,1:(ord(i)+1)),t,xp(i));
            else
                count=count+1;
                C(count,1)=con(j,i);
                A(count,(sum(ord(1:i-1))+i-1):(sum(ord(1:i))+i-1))=subs(P(j,1:(ord(i)+1)),t,xp(i));
                count=count+1;
                C(count,1)=con(j,i);
                A(count,(sum(ord(1:i))+i):(sum(ord(1:i+1))+i))=subs(P(j,1:(ord(i+1)+1)),t,xp(i));
            end
        elseif con(j,i)==inf
            if i==1
                count=count+1;
                C(count,1)=0;
                A(count,(sum(ord(1:1))+1):(sum(ord(1:2))+1))=-subs(P(j,1:(ord(2)+1)),t,xp(1));
                A(count,(sum(ord(1:n-1))+n-1):(sum(ord(1:n))+n-1))=subs(P(j,1:(ord(n)+1)),t,xp(n));
            elseif i~=n
                count=count+1;
                C(count,1)=0;
                A(count,(sum(ord(1:i-1))+i-1):(sum(ord(1:i))+i-1))=subs(P(j,1:(ord(i)+1)),t,xp(i));
                A(count,(sum(ord(1:i))+i):(sum(ord(1:i+1))+i))=-subs(P(j,1:(ord(i+1)+1)),t,xp(i));
            end
        end
    end
end
B=A\C;
% B=pinv(A)*C;

polycoef=zeros(max(ord)+1,n-1);
for i=1:n-1
    polycoef(1:(ord(i+1)+1),i)=B((sum(ord(1:i))+i):(sum(ord(1:i+1))+i));
end
polycoef=polycoef(end:-1:1,:);
sz=size(polycoef,1);
for j=1:sz
    dpolycoef(j,:)=(sz-j)*polycoef(j,:);
    ddpolycoef(j,:)=(sz-j)*(sz-j-1)*polycoef(j,:);    
end

if nargin>3
    figure
    hold on
    for i=1:n-1
        t=xp(i):fig_res:xp(i+1);
        y=polyval(polycoef(:,i),t);
        dy=polyval(dpolycoef(1:end-1,i),t);
        ddy=polyval(ddpolycoef(1:end-2,i),t);
        plot(t,y)
%         plot(t,dy)
%         plot(t,ddy)
    end
    hold off
end
end