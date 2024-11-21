%%  脉冲响应
clear;clc

M = 1.096; 
m = 0.109; 
b = 0.1; 
I= 0.0034; 
g = 9.8; 
l = 0.25; 
q = (M+m)*(I+m*l^2)-(m*l)^2;   %simplifies input 
num = [m*l/q  0]
den = [1  b*(I+m*l^2)/q  -(M+m)*m*g*l/q  -b*m*g*l/q]
t = 0 : 0.01 : 5; 
sys = tf(num,den);
impulse (sys,t) 
axis ( [ 0 1.1 0 70 ]) 