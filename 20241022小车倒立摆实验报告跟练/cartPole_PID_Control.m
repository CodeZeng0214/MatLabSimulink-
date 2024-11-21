%% PID控制

clear;clc

%% 参数值

M = 1.096; 
m = 0.109; 
b = 0.1; 
I = 0.0034; 
g = 9.8; 
l = 0.25;

q =(M+m)*(I+m*l^2) -(m*l)^2;   %simplifies input 
num = [m*l/q  0 0] ;
den = [1  b*(I+m*l^2)/q  -(M+m)*m*g*l/q  -b*m*g*l/q  0] ;
kd=20 ;
kp=100 ;
ki=1 ;
numPID= [ kd  kp  ki ]; 
denPID= [ 1  0 ]; 
numc= conv ( num, denPID ) ;


%% 新传递函数系数求解

denc= polyadd ( conv(denPID, den ), conv( numPID, num ) )  
t = 0 : 0.05 : 5; 


%% 传递函数冲激响应

impulse ( numc , denc , t ) ;

%% 绘制输出响应
% 
% plot(t, y(:,1), 'r', t, y(:,2), 'g');
% xlabel('时间 (seconds)');
% ylabel('系统响应');
% legend('小车位移', '倒立摆摆动角度');
% title('极点配置法控制');