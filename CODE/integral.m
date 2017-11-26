clc                %clearing the screen
clear all;         %clearing memory in order to speed up the operating process

p1 =      0.3036;
p2 =       -1838;
p3 =    3.71e+06;
p4 =  -2.496e+09;

syms x
f=p1*x^3 + p2*x^2 + p3*x + p4;
int(f, x, 2016, 2030)   %calculating the integral 
