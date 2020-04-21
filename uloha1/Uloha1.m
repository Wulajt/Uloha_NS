clear
% suradnice x,y,z piatich skupin bodov
load databody1

% vykreslenie bodov podla skupin
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')


% vstupné data pre NS
V1=[data1(:,1) data1(:,2) data1(:,3)];
V2=[data2(:,1) data2(:,2) data2(:,3)];
V3=[data3(:,1) data3(:,2) data3(:,3)];
V4=[data4(:,1) data4(:,2) data4(:,3)];
V5=[data5(:,1) data5(:,2) data5(:,3)];

X=[V1;V2;V3;V4;V5]'

% výstupne data pre NS
P=[ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50);
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50)];

% vytvorenie struktury NS na klasifikaciu
net = patternnet(5)

% vsetky data pouzite na trenovanie
net.divideFcn='dividetrain';
net.divideParam.trainRatio=0.8;
net.divideParam.testRatio=0.2;

net.trainParam.goal = 0.000001;	    % Ukoncovacia podmienka na chybu SSE.
net.trainParam.epochs = 300;        % Max. pocet trénovacích cyklov.
net.trainParam.min_grad=1e-10;      % Ukoncovacia podmienka na min. gradient


% trenovanie siete
net = train(net,X,P);

% simulacia vystupu NS
y = net(X);
% vypocet chyby siete
perf = perform(net,P,y);
% priradenie vstupov do tried
classes = vec2ind(y);

% testovacie data
test_data = [data1(1,:); data2(1,:); data3(1,:); data4(1,:); data5(1,:)];

% simulacia vystupu NS
test_result = net(test_data')

% priradenie vstupov do tried
classes2 = vec2ind(test_result)

h=figure;
plot3(data1(2:end,1),data1(2:end,2),data1(2:end,3),'b+')
hold on
plot3(data2(2:end,1),data2(2:end,2),data2(2:end,3),'co')
plot3(data3(2:end,1),data3(2:end,2),data3(2:end,3),'g*')
plot3(data4(2:end,1),data4(2:end,2),data4(2:end,3),'r*')
plot3(data5(2:end,1),data5(2:end,2),data5(2:end,3),'mx')

plot3(data1(1,1),data1(1,2),data1(1,3),'ks')
hold on
plot3(data2(1,1),data2(1,2),data2(1,3),'ks')
plot3(data3(1,1),data3(1,2),data3(1,3),'ks')
plot3(data4(1,1),data4(1,2),data4(1,3),'ks')
plot3(data5(1,1),data5(1,2),data5(1,3),'ks')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')

echo off

