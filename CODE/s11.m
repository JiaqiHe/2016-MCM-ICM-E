%TGB model
clc;
clear all;
%original data
%output data
data=[190.27 197.48	182.82	175.77	162.99	150.39	146.94	150.83];
%GM11 predicted total water withdrawal
GM11 =[190.2700  193.7160  183.9220  174.6210  165.7910  157.4100  ...
    149.4500  141.8900];
%DGM predicted total water withdrawal
DGM=[190.2700  188.3733  184.3634  180.0079  175.2771  170.1386  ...
    164.5572  158.4949];
%Verhulst predicted total water withdrawal
Verhulst=[190.2700  184.6402  178.9621  173.2493  167.5153  161.7741 ...
    156.0396  150.3257];

b=[GM11;DGM;Verhulst];  %input data matrix
c=[data];         %output data matrix

%bp neuron simulation
[pn,minp,maxp,tn,mint,maxt]=premnmx(b,c);
%normalizing the input matrix b and the output matrix c
dx=[-1,1;-1,1;-1,1]; 
%the minimum value is -1 amd the maximum is 1 by normalization  

net=newff(dx,[3,7,1],{'tansig','tansig','purelin'},'traingdx');  
%establishing a model and using the gradient descent method  to train it
net.trainParam.show=100;         %executing 100 loops to show a result
net.trainParam.Lr=0.05;          %the learning rate is 0£®05
net.trainParam.epochs=50000;     %the maximum of training times is 50000 
net.trainParam.goal=0.00001;     %the MSE is 0£®00001
net=train(net,pn,tn);            %starting to train it£¬pn is used as an  
                                 %input sample while tn is output
                                 %using data which has been normalized

an=sim(net,pn);                  %using the trained model to simulate
a=postmnmx(an,mint,maxt);
%dealing with the net-output an=sim(net£¬pn) as follows after training

%drawing, and comparing to simulation results
x=1998:2005;
newk=a(1,:);
figure (3);
plot(x,newk,'b--+',x,data,'r-o')
title('Combination water volume forecast')
legend('Network output water volume','Real water volume');
xlabel('year');ylabel('billion cubic meters');

%the corresponding processing should also be made when the trained network 
%is used to forecast the new data pnew
%GM11 predicted total water withdrawal
GM11 =[190.2700  193.6744  183.8833  174.5872  165.7611  157.3812  149.4249 ...
    141.8709  134.6987  127.8891  121.4238  115.2853  109.4571  103.9236  ...
    98.6698  93.6817   88.9457   84.4491   80.1798   76.1264   72.2779   ...
    68.6239   65.1547   61.8609   58.7335   55.7643   52.9452   50.2686   ...
    47.7273   45.3145  43.0236   40.8486   38.7836];
%DGM predicted total water withdrawal
DGM=[190.2700  189.6386  184.3357  179.1810  174.1704  169.3000  164.5657 ...
    159.9639  155.4907  151.1426  146.9161  142.8078  138.8144  134.9327 ...
    131.1594  127.4918  123.9266  120.4612  117.0927  113.8183  110.6355  ...
    107.5418  104.5345  101.6114   98.7699   96.0080   93.3232   90.7136 ...
    88.1769   85.7112  83.3144   80.9846   78.7200];
%Verhulst predicted total water withdrawal
Verhulst=[190.2700  185.1188  178.9056  172.9011  167.0980  161.4897  ...
    156.0696  150.8315  145.7692  140.8767  136.1485  131.5790  127.1628...
    122.8948  118.7701  114.7839  110.9314  107.2082  103.6100  100.1325  ...
    96.7718   93.5239   90.3849   87.3514   84.4196   81.5862   78.8480  ...
    76.2016   73.6441   71.1723  68.7836   66.4750   64.2439];

pnew=[GM11;DGM;Verhulst];
pnewn=tramnmx(pnew,minp,maxp);
anewn=sim(net,pnewn);
anew=postmnmx(anewn,mint,maxt)