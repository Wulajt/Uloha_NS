clc
% suradnice x,y,z piatich skupin bodov
load databody1

% vstupné data pre NS
V1=[data1(:,1) data1(:,2) data1(:,3)];
V2=[data2(:,1) data2(:,2) data2(:,3)];
V3=[data3(:,1) data3(:,2) data3(:,3)];
V4=[data4(:,1) data4(:,2) data4(:,3)];
V5=[data5(:,1) data5(:,2) data5(:,3)];

X=[V1;V2;V3;V4;V5]';

% výstupne data pre NS
P=[ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50)];

% vytvorenie struktury NS na klasifikaciu
pocet_neuronov = 12;
net = patternnet(pocet_neuronov);

% vsetky data pouzite na trenovanie
net.divideFcn='dividerand';
net.divideParam.trainRatio=0.8;
net.divideParam.valRatio=0;
net.divideParam.testRatio=0.2;

net.trainParam.goal = 0.002;	% Ukoncovacia podmienka pre chybu v crossentropy
net.trainParam.epochs = 50;     % Max. pocet trénovacích cyklov.
net.trainParam.min_grad=1e-10;  % Ukoncovacia podmienka na min. gradient


% trenovanie siete
net = train(net,X,P);

% simulacia vystupu NS
y = net(X);
% vypocet chyby siete
perf = perform(net,P,y);
% priradenie vstupov do tried
classes = vec2ind(y);

% testovacie data
test_data = [data1(1,:); data2(1,:);  data4(1,:);data3(1,:); data5(1,:)];

% simulacia vystupu NS
test_result = net(test_data')

% priradenie vstupov do tried
classes2 = vec2ind(test_result)


% vykreslenie bodov podla skupin
h=figure;
plot3(data1(2:end,1),data1(2:end,2),data1(2:end,3),'b+')
hold on
plot3(data2(2:end,1),data2(2:end,2),data2(2:end,3),'co')
plot3(data3(2:end,1),data3(2:end,2),data3(2:end,3),'g*')
plot3(data4(2:end,1),data4(2:end,2),data4(2:end,3),'r*')
plot3(data5(2:end,1),data5(2:end,2),data5(2:end,3),'mx')

% vykreslenie testovacich bodov podla skupin
idx1 = classes2==1;
v1 = test_data'.*idx1;
v1(:,~any(v1,1)) = [];
idx2 = classes2==2;
v2 = test_data'.*idx2;
v2(:,~any(v2,1)) = [];
idx3 = classes2==3;
v3 = test_data'.*idx3;
v3(:,~any(v3,1)) = [];
idx4 = classes2==4;
v4 = test_data'.*idx4;
v4(:,~any(v4,1)) = [];
idx5 = classes2==5;
v5 = test_data'.*idx5;
v5(:,~any(v5,1)) = [];

plot3(v1(1),v1(2),v1(3),'bs')
hold on
plot3(v2(1),v2(2),v2(3),'cs')
plot3(v3(1),v3(2),v3(3),'gs')
plot3(v4(1),v4(2),v4(3),'rs')
plot3(v5(1),v5(2),v5(3),'ms')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')

echo off

