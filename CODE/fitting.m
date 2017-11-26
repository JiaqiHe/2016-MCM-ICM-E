clc                 %clearing the screen
clear all;          %clearing memory in order to speed up the operating process
close all;          %closing all current figures

figure;
x=[2016 2020 2025 2030];
y=[3 100 300 800];
plot(x,y);          %the chart of desalination capacity's predicted trend 
title('Desalination capacity');
xlabel('year');ylabel('ten thousand cubic meters');

cftool              %fitting curve