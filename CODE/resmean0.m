%res0
pre=[190.255745110849,197.342256137325,182.939118533223,175.709243979758,...
    161.469365688413,149.525957485249,146.948262773806,150.797309789114];
real=[190.27 197.48	182.82 175.77 162.99 150.39	146.94 150.83];
146residual0=[];
relative_error0=[];
for i=1:8
    residual0(i)=pre(i)-real(i);
    relative_error0(i)=residual4(i)/real(i);
end
residual0                      %residual
relative_error0                %relative_error

residual0_mean=abs(mean(residual0))
relative_error0_mean=abs(mean(relative_error0))