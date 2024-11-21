%% 求传递函数的系数
% 1指 角度
% 2指 位移

clear;clc

M = 1.096; 
m = 0.109; 
b = 0.1; 
I = 0.0034; 
g = 9.8; 
l = 0.25; 
q =(M+m)*(I+m*l^2) -(m*l)^2;   %simplifies input 
num1 = [m*l/q  0  0] ;
den1 = [1  b*(I+m*l^2)/q  -(M+m)*m*g*l/q  -b*m*g*l/q  0]; 
num2 = [-(I+m*l^2)/q  0  m*g*l/q]; 
den2 = den1;
sys2 = tf(num2,den2);
poles = pole(sys2)

% 运行模型
sim('my_cartPole_PID_Control.slx');
