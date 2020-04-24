clear

load('datafun1');
plot(x,y);

n=length(y);
n2=fix(n/2);

net=fitnet(24);

net.divideFcn='divideind';
net.divideParam.trainInd = indx_train;
net.divideParam.testInd = indx_test;

net.trainParam.goal = 1e-4;   % Ukoncovacia podmienka na chybu MSE.
net.trainParam.epochs = 100;  % Max. pocet trénovacích cyklov.
net.trainParam.show = 5;      % Ukoncovacia podmienka na min. gradient

net = train(net,x,y);

outnetsim = sim(net,x);

%Vypocet errorov
SSE_train = sse(outnetsim(indx_train)-y(indx_train))
MSE_train = immse(outnetsim(indx_train),y(indx_train))
MAE_train = mae(outnetsim(indx_train)-y(indx_train))
SSE_test = sse(outnetsim(indx_test)-y(indx_test))
MSE_test = immse(outnetsim(indx_test),y(indx_test))
MAE_test = mae(outnetsim(indx_test)-y(indx_test))
% Vykreslenie priebehov
figure
plot(x,y,'b',x,outnetsim,'-or')
ylabel('y')
xlabel('x')
legend('Dana funkcia','Data z NS')
echo off


