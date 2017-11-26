%actual total water resources
glkyl1=[27700.8 26867.8 28261.3 27460.2 24129.6 28053.1 25330.1 25255.2 27434.3 ...
    24180.2 30906.4 23256.7 29526.9 27957.9];
%actual water resources per capita
glhyl1=[2193.9 2112.5 2207.2 2131.3 1856.3 2151.8 1932.1 1916.3 2071.1 1816.2 ...
    2310.4 1730.2 2186.1 2059.7];

%predicted total water resources
glkyl2=[27700.8 26867.8 28261.3 27460.2 24129.6 28053.1 25330.1 25255.2 27434.3 ...
    24180.2 30906.4 23256.7 29518.0 27966.0];
%predicted water resources per capita
glhyl2=[2193.9 2112.5 2207.2 2131.3 1856.3 2151.8 1932.1 1916.3 2071.1 1816.2 ...
    2310.4 1730.2 2168.0 2061.0];

figure ;
x=2000:2013;
subplot(2,1,1);plot(x,glkyl2,'r-o',x,glkyl1,'b--+')    
%comparison diagram of total water resources
legend('Network output total water resources','total water resources');
xlabel('year');ylabel('billion cubic meters');
subplot(2,1,2);plot(x,glhyl2,'r-o',x,glhyl1,'b--+')     
%comparison diagram of water resources per capita
legend('Network output water resources per capita','water resources per capita');
xlabel('year');ylabel('cubic meters per person');