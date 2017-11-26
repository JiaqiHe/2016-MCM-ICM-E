%Verhulst model 
clc;
clear all;

x0=[190.27 197.48	182.82	175.77	162.99	150.39	146.94	150.83];
%original data sequence
n=length(x0);

x1=diff(x0);
x1=[x0(1),x1]
for i=2:n
z1(i)=0.5*(x0(i)+x0(i-1));
end
z1
B=[-z1(2:end)',z1(2:end)'.^2]
Y=x1(2:end)'
abhat=B\Y %estimating parameters a and b
x=dsolve('Dx+a*x=b*x^2','x(0)=x1'); %solving ordinary differential equation
x=subs(x,{'a','b','x1'},{abhat(1),abhat(2),x0(1)}); %using values of paramaters 
yuce=subs(x,'t',0:n-1) %calculating first forward difference

x=vpa(x,6)
disp('calculating predicted value for known data')
x0_hat=double( [yuce(1),diff( double(yuce) )] ) 
%calculating predicted value for known data

forecast=x0_hat;
for i=1:n-1
    forecast(i+1)=forecast(i)+x0_hat(i+1);
end

disp('calculating predicted value for known data')
forecast              %calculating predicted value for known data