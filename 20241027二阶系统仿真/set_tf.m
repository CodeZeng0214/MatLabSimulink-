% 设置传递函数的系数

m = 9;
k = 4;
c = 7;

naturalFrequency = (k/m)^0.5;

damp = c/(2*(k*m)^0.5)

tf = [1 2*damp*naturalFrequency naturalFrequency^2];