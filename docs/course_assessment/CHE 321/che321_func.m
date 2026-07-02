function dcdvol = che321_func(vol,c)


v=1;
vr=1;
k1=0.001;
k2=0.0001;

dcdvol=[-k1*c(1)*c(1)/(v+vr); (k1*c(1)*c(1)-k2*c(2))/(v+vr); k2*c(2)/(v+vr)];