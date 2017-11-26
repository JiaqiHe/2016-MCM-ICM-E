%res1~3
residual1=[0 -0.0416 -0.0387 -0.0338 -0.0299 -0.0288 -0.0251 -0.0191];
relative_error1 =[0 -0.2150 -0.2104 -0.1934 -0.1803 -0.1830 -0.1679 -0.1349];

residual2=[0 1.2653 -0.0277 -0.8269 -1.1067 -0.8386 0.0085 1.4690];
relative_error2 =[0 0.0067 -0.0002 -0.0046  -0.0063 -0.0049 0.0001 0.0093];

residual3=[0 0.4786 -0.0565 -0.3482 -0.4173 -0.2844 0.0300 0.5058];
relative_error3 =[0 0.0026 -0.0003 -0.0020 -0.0025 -0.0018 0.0002 0.0034];

residual1_mean=abs(mean(residual1))
relative_error1_mean=abs(mean(relative_error1))

residual2_mean=abs(mean(residual2))
relative_error2_mean=abs(mean(relative_error2))

residual3_mean=abs(mean(residual3))
relative_error3_mean=abs(mean(relative_error3))

%res4
pre=[190.271684715879,197.482192372527,182.822476118608,175.7773509548315,...
    162.993762767777,150.394842643418,146.945399451505,150.833539421809];
real=[190.27	197.48	182.82	175.77	162.99	150.39	146.94	150.83];

residual4=[];
relative_error4=[];
for i=1:8
    residual4(i)=pre(i)-real(i);
    relative_error4(i)=residual4(i)/real(i);
end
residual4                      %residual
relative_error4                %relative_error

residual4_mean=abs(mean(residual4))
relative_error4_mean=abs(mean(relative_error4))

