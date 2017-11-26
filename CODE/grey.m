clc
clear
syms a b;
c=[a b]';
A=[190.2700  193.7160  183.9220  174.6210  165.7910  157.4100  149.4500  141.8900];  
%input the forecast values from the results of program GM1~3 
B=cumsum(A);  % accumulation for original data
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  % generating accumulation matrix
end
% calculating value of coefficient
D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% predicting subsequent data
F=[];F(1)=A(1);
for i=2:(n+25)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G=[];G(1)=A(1);
for i=2:(n+25)
    G(i)=F(i)-F(i-1); % getting predicted data
end 
t1=1998:2005;
t2=1998:2030;
G
plot(t1,A,'ko', 'LineWidth',2)
hold on
plot(t2,G,'k', 'LineWidth',2)
xlabel('Year', 'fontsize',12)
ylabel('Billion cubic meters','fontsize',12)
set(gca,  'LineWidth',2);

residual=[a b]';
relative_error=[a b]';
for i=1:n
    residual(i)=G(i)-A(i);
    relative_error(i)=residual(i)/A(i);
end
residual                      %residual error
relative_error                %relative error

