clear

echo on
load('datafun1')
plot(x,y)

n=length(y);
n2=fix(n/2);

net=fitnet(24);

net.divideFcn='divideind';
net.divideParam.trainInd = indx_train;
net.divideParam.testInd = indx_test;

net.trainParam.goal = 1e-4;
net.trainParam.epochs = 1000; 
net.trainParam.show = 5;

net = train(net,x,y);

outnetsim = sim(net,x);

% Vykreslenie priebehov
figure
plot(x,y,'b',x,outnetsim,'-or')
echo off


