clear 
% Demo modelovania spalovacieho motora

% nacitanie dat, x - vstupy (otácky,spotreba paliva), t - výstupy
% (krut.moment, emisie)
[x,t] = engine_dataset;	

% vytvorenie struktury NS 

%trainbfg - Quasi Newton
%trailm
%trainscg -Scaled conjugate gradient
%traincgp - Polak-Ribiere conjugate gradient
%trainrp
net=fitnet(10,'trainlm');
% pocet trenovacich epoch a ukoncovacia podmienka
net.trainParam.epochs = 500;
net.trainParam.goal = 1e-1;
net.trainParam.min_grad=1e-15;

% vsetky data pouzite na trenovanie
net.divideFcn='dividerand'; % náhodné rozdelenie
%net.divideFcn='divideblock'; % blokove
%net.divideFcn='divideint';  % kazdy n-ta vzorka
%net.divideFcn='dividetrain';  % iba trenovacie
net.divideParam.trainRatio=0.8;
net.divideParam.valRatio=0;
net.divideParam.testRatio=0.2;

tic
net=train(net,x,t);
toc

y=sim(net,x);

figure
plot([t(1,:)' y(1,:)'])
title('Moment')
legend('Mer.data','NN model')
xlabel('vzorky')

figure
plot([t(2,:)' y(2,:)'])
title('Emisie')
legend('Mer.data','NN model')
xlabel('vzorky')

figure
plot3(x(1,:),x(2,:),t(1,:),'b+')
hold on
plot3(x(1,:),x(2,:),y(1,:),'r*')
title('Moment')
xlabel('Spotreba')
ylabel('otacky')
zlabel('Moment')
legend('Mer.data','NN model')

figure
plot3(x(1,:),x(2,:),t(2,:),'b+')
hold on
plot3(x(1,:),x(2,:),y(2,:),'r*')
title('Emisie')
xlabel('Spotreba')
ylabel('otacky')
zlabel('Emisie')
legend('Mer.data','NN model')
