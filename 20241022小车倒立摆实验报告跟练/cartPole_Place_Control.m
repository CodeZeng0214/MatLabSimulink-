%% 极点配置法控制

clear;clc

%% 参数值

M = 1.096; 
m = 0.109; 
b = 0.1; 
I= 0.0034; 
g = 9.8; 
l = 0.25; 
p = I*(M+m)+M*m*l^2; %denominator for the A and B matricies


%% 状态空间模型搭建

A = [0      1              0           0; 
    0  -(I+m*l^2)*b/p  (m^2*g*l^2)/p    0; 
    0      0              0           1; 
    0   -(m*l*b)/p     m*g*l*(M+m)/p  0] ;
B = [     0;  
     (I+m*l^2)/p; 
          0; 
        m*l/p] ;
C = [1 0 0 0; 
     0 0 1 0] ;
D = [0; 
     0];

cartPoleSysC = ss(A,B,C,D);

%%  K系数求解

% 离散系统
% z1 = exp(((-3*2^0.5)/2+(-3*2^0.5)*1i/2)*0.005);
% z2 = exp(((-3*2^0.5)/2-(-3*2^0.5)*1i/2)*0.005);
% z3 = exp(-10*0.005);
% z4 = exp(-12*0.005);
% p=[z1 z2 z3 z4];

% 连续系统
p1 = -3*sqrt(2)/2 + (-3*sqrt(2)/2)*1i;  % 复数极点
p2 = -3*sqrt(2)/2 - (-3*sqrt(2)/2)*1i;  % 复数极点
p3 = -10;  % 实数极点
p4 = -12;  % 实数极点
p=[p1 p2 p3 p4];
K = place(A,B,p);

%% 搭建闭环控制

A_cl = A - B * K;  % 闭环状态矩阵
cartPoleSysCl = ss(A_cl, B, C, D);  % 新的闭环系统

x0 = [0.05; 0; 0.0175; 0];  % 初始状态
t = 0:0.01:10;  % 仿真时间
[y, t, x] = initial(cartPoleSysCl, x0, t);  % 仿真初始响应

%% 绘制输出响应

plot(t, y(:,1), 'r', t, y(:,2), 'g');
xlabel('时间 (seconds)');
ylabel('系统响应');
legend('小车位移', '倒立摆摆动角度');
title('极点配置法控制');