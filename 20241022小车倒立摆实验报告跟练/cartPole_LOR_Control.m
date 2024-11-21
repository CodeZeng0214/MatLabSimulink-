%% LOR控制

clear;clc

%% 参数值

M = 1.096; 
m = 0.109; 
b = 0.1; 
I= 0.0034; 
g = 9.8; 
l = 0.25; 
p = I*(M+m)+M*m*l^2; %denominator for the A and B matricies

T = 0.005;

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

%%  连续系统LQR系数求解

R = 1;
Q1 = [10 0 0 0;
      0 0 0 0;
      0 0 1 0;
      0 0 0 0];

K = lqr(A,B,Q1,R);

%% 搭建LQR闭环控制

A_cl = A - B * K;  % 闭环状态矩阵
cartPoleSysCl = ss(A_cl, B, C, D);  % 新的闭环系统

x0 = [0.05; 0; 0.0175; 0];  % 初始状态
t = 0:0.01:10;  % 仿真时间
[y, t, x] = initial(cartPoleSysCl, x0, t);  % 仿真初始响应

%% 绘制输出响应
plot(t, y(:,1), 'r', t, y(:,2), 'g');
xlabel('时间 (seconds)');
ylabel('系统响应');
legend('Q1小车位移', 'Q1倒立摆摆动角度');
title('LQR闭环控制');


%% 对比Q权值矩阵
Q2 = [300 0 0 0;
      0 0 0 0;
      0 0 30 0;
      0 0 0 0];
K = lqr(A,B,Q2,R);

A_cl = A - B * K;  % 闭环状态矩阵
cartPoleSysCl = ss(A_cl, B, C, D);  % 新的闭环系统
[y, t, x] = initial(cartPoleSysCl, x0, t);  % 仿真初始响应

hold on
plot(t, y(:,1), 'm', t, y(:,2), 'c');
legend('Q1小车位移', 'Q1倒立摆摆动角度', 'Q2小车位移', 'Q2倒立摆摆动角度');




