%% 状态空间法求阶跃响应
clear;clc

M = 1.096; 
m = 0.109; 
b = 0.1; 
I= 0.0034; 
g = 9.8; 
l = 0.25; 
p = I*(M+m)+M*m*l^2; %denominator for the A and B matricies

A = [0      1              0           0; 
    0  -(I+m*l^2)*b/p  (m^2*g*l^2)/p    0; 
    0      0              0           1; 
    0   -(m*l*b)/p     m*g*l*(M+m)/p  0] 
B = [     0;  
     (I+m*l^2)/p; 
          0; 
        m*l/p] 
C = [1 0 0 0; 
     0 0 1 0] 
D = [0; 
     0] 
T=0:0.005:10; 
U=0.2*ones(size(T)); 
[Y,X]=lsim(A,B,C,D,U,T); 
plot(T,Y) 
axis([0 2.5 0 100])