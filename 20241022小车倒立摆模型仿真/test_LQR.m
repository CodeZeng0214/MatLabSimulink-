clear;clc

A = [0 -1; -10 0];
B = [0;-1];
Q = [100 0;0 1];
R = 1;

K = lqr(A,B,Q,R)

k1 = K(1)
k2 = K(2)
