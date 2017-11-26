%GM(1,1) model
clc;
clear all;

x0 = [190.27 197.48	182.82	175.77	162.99	150.39	146.94	150.83];

n = length(x0);
% judging  to determine whether it is suitable for GM(1,1) model
lamda = x0(1:n-1)./x0(2:n);
range = minmax(lamda);
% judging whether it is suitable for GM(1,1) model
if range(1,1) < exp(-(2/(n+2))) | range(1,2) > exp(2/(n+2))
    error('stepwise ratio is out of the range of GM(1,1) model');
else
   % null string output
    disp('              ');
    disp('suit G(1£¬1) model');
end

% AGO accumulation
x1 = cumsum(x0);
for i = 2:n
    % calculating mean with consecutive neighbors£¬that is white background value
    z(i) = 0.5*(x1(i)+x1(i-1));
end
B = [-z(2:n)',ones(n-1,1)];
Y = x0(2:n)';
% doing division to matrix,computing coefficient and grey action
u = B\Y;
% D represents derivative and dsolve function is used to solve symbolic ordinary 
% differential equation in MATLAB
x = dsolve('Dx+a*x=b','x(0)=x0');
% subs function aims to replace elements£¬here replacing a,b,x0 with specific 
% values u(1),u(2),x1(1)
x = subs(x,{'a','b','x0'},{u(1),u(2),x1(1)});
forecast1 = subs(x,'t',[0:n-1]);
% digits and vpa functions are used to control the number of significant figures
digits(6);
% y is AGO(or cumulative)
y = vpa(x);
% continuous subtraction for AGO output
% diff is used to take a derivative of symbolic expression
% but it represents computed difference of adjacent elements if a vector is input
forecast11 = double(forecast1);
exchange = diff(forecast11);

disp('evaluating predicted value for known data')
forecast = [x0(1),exchange]   %evaluating predicted value for known data