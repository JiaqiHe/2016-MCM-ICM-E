%DGM(2,1) model
clc;
clear all;

x0=[190.27 197.48	182.82	175.77	162.99	150.39	146.94	150.83]; 
%original data sequence
n=length(x0);
a_x0=diff(x0)';%calculating first forward difference
B=[-x0(2:end)',ones(n-1,1)]; 
disp('using least square method to fit parameter')
u=B\a_x0  %using least square method to fit parameter
disp('working out symbolic solution of differential equation')
x=dsolve('D2x+a*Dx=b','x(0)=c1,Dx(0)=c2');  
%working out symbolic solution of differential equation
x=subs(x,{'a','b','c1','c2'},{u(1),u(2),x0(1),x0(1)}); 
yuce=subs(x,'t',0:n-1); 
%calculating predicted value of first forward difference for known data

x=vpa(x,6)
disp('calculating predicted value for known data')
x0_hat=double( [yuce(1),diff( double(yuce) )] ) 
%calculating predicted value for known data