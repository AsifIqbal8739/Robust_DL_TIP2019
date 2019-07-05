% Test_1 background subtraction
clc; clear all; close all;

%% Data Setup
load 'airport.mat';   %sidewalk, t_airport, Dummy, airport
imgsize = [size(X,1),size(X,2)];
Y = im2double(reshape(X,[size(X,1)*size(X,2),size(X,3)]));  clear 'X';
Ys = Y;%(:,30:230);
[n,N] = size(Ys);
K = 5;

%% Learning process
Dini = normc(abs(randn(n,K)));   
Xini = zeros(K,N);
% Xini = pinv(Dini)*Ys;    %zeros(K,N);
alpha = 1;  lambda = 1;   delta = 0.01;    verb = 1;
noIt = 40;  tic;
[D,X] = OWN_RDL(Ys,Dini,Xini,noIt,lambda,alpha,delta,verb);
secs2hms(toc)
X(abs(X)<0.03*norm(X)) = 0;
[II,DD] = Disp_BGS(Ys,D,X,imgsize);
implay(II,10);
implay(DD,5);

