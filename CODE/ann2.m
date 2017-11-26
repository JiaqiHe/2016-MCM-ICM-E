function main()
clc               %clearing the screen
clear all;        %clearing memory in order to speed up the operating process
close all;        %closing all current figures
SamNum=12;        %the size of  input samples is 12
TestSamNum=12;    %the size of testing samples is also 12
ForcastSamNum=2;  %the size of predicting samples is 2
HiddenUnitNum=8;  %the size of middle layer hidden nodes is 8, one more than 
                  %toolkit programs
InDim=3;                    %3-dimensional network input 
OutDim=2;                   %2-dimensional network input 

%original data 
%surface water resources amount
sqrs=[26561.9 25933.4 27243.3 26250.7 23126.4 26982.4 24358.1 24242.5 ...
    26377.0 23125.2 29797.6 22213.6];
%groundwater resources amount
sqjdcs=[8501.9 8390.1 8697.2 8299.3 7436.3 8091.1 7642.9 7617.2 8122.0 ...
    7267.0 8417.0 7214.5];
%repeated amount of surface water and groundwater
sqglmj=[7363.0 7455.7 7679.2 7089.9 6433.1 7020.4 6670.8 6604.5 7064.7...
    6212.1 7308.2 6171.4];
%total water resources
glkyl=[27700.8 26867.8 28261.3 27460.2 24129.6 28053.1 25330.1 25255.2 ...
    27434.3 24180.2 30906.4 23256.7];
%water resources per capita
glhyl=[2193.9 2112.5 2207.2 2131.3 1856.3 2151.8 1932.1 1916.3 2071.1 ...
    1816.2 2310.4 1730.2];
p=[sqrs;sqjdcs;sqglmj];  %input data matrix
t=[glkyl;glhyl];           %objective data matrix
[SamIn,minp,maxp,tn,mint,maxt]=premnmx(p,t); %initialization for original 
                                             %samples(input and output) 

rand('state',sum(100*clock))   %generating a random number on the basis 
                               %of the system clock seed          
NoiseVar=0.01;                    %the noise intensity is 0.01£¨adding noise 
                                  %to prevent over- fitting phenomenon£©
Noise=NoiseVar*randn(2,SamNum);   %generating noise
SamOut=tn + Noise;                   %adding noise to output samples

TestSamIn=SamIn;                 %here input samples are the same 
                                 %as testing samples because of small samples 
TestSamOut=SamOut;        %making output samples and testing samples the same

MaxEpochs=50000;                      %the maximum of training times is 5000
lr=0.035;                                  %the learning rate is 0.035
E0=0.65*10^(-3);                           %the target error is 0.65*10^(-3)
W1=0.5*rand(HiddenUnitNum,InDim)-0.1;
%initializing weights between input layer and hidden layer
B1=0.5*rand(HiddenUnitNum,1)-0.1;
%initializing thresholds between input layer and hidden layer
W2=0.5*rand(OutDim,HiddenUnitNum)-0.1;
%initializing weights between output layer and hidden layer              
B2=0.5*rand(OutDim,1)-0.1;
%initializing thresholds between input layer and hidden layer

ErrHistory=[];              %occupying memory for middle variables in advance 
for i=1:MaxEpochs
    
    HiddenOut=logsig(W1*SamIn+repmat(B1,1,SamNum)); %hidden layer network output
    NetworkOut=W2*HiddenOut+repmat(B2,1,SamNum);    %output layer network output
    Error=SamOut-NetworkOut;
    %difference between the actual output and network output
    SSE=sumsqr(Error);             %energy function (error sum of squares)

    ErrHistory=[ErrHistory SSE];

    if SSE<E0,break, end 
    %breaking out of learning loop if error requirement is fulfilled
   
    %core programs of BP network are as follows 
    %they are weights(threshold) making dynamic adjustments according to 
    %negative gradient descent principle of energy function  
    Delta2=Error;
    Delta1=W2'*Delta2.*HiddenOut.*(1-HiddenOut);    

    dW2=Delta2*HiddenOut';
    dB2=Delta2*ones(SamNum,1);
    
    dW1=Delta1*SamIn';
    dB1=Delta1*ones(SamNum,1);
    %correcting weights and thresholds between hidden layer and output layer 
    W2=W2+lr*dW2;
    B2=B2+lr*dB2;
    %correcting weights and thresholds between hidden layer and input layer
    W1=W1+lr*dW1;
    B1=B1+lr*dB1;
end

HiddenOut=logsig(W1*SamIn+repmat(B1,1,TestSamNum)); 
%hidden layer carrys out final result 
NetworkOut=W2*HiddenOut+repmat(B2,1,TestSamNum);    
%output layer carrys out final result
a=postmnmx(NetworkOut,mint,maxt);   %restoring the result of output layer 
x=2000:2011;                        %timeline scale
newk=a(1,:);                        %network outputs passenger capacity
newh=a(2,:);                        %network outputs freight volume
figure ;
subplot(2,1,1);plot(x,newk,'r-o',x,glkyl,'b--+')
%comparison diagram of total water resources
legend('Network output total water resources','total water resources');
xlabel('year');ylabel('billion cubic meters');
subplot(2,1,2);plot(x,newh,'r-o',x,glhyl,'b--+')
%comparison diagram of water resources per capita
legend('Network output water resources per capita','water resources per capita');
xlabel('year');ylabel('cubic meters per person');

%using the trained network to predict
%the corresponding processing should also be made when using the trained  
%network to forecast the new data pnew
pnew=[ 28371.4 26839.5
       8416.1 8081.1
       7260.6 6962.7];        %related data in 2012 and 2013£»
pnewn=tramnmx(pnew,minp,maxp);
%using normalized parameters of original input data to normalize new data£»
HiddenOut=logsig(W1*pnewn+repmat(B1,1,ForcastSamNum)); 
%hidden layer carrys out predicted results
anewn=W2*HiddenOut+repmat(B2,1,ForcastSamNum);         
%output layer carrys out predicted results

%restoring predicted data to original order of magnitudes£»
anew=postmnmx(anewn,mint,maxt)
