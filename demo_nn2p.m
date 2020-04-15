% Demo program na klasifikaciu predmetov skupiny A a B na základe vlastností V1 a V2 
% NS má 2 vstupy veliciny V1,V2 o rozsahu 0-1 (0-100%) a 1 výstup o rozsahu 0-1, 
% kde hodnota 1  prislúcha skupine A a  hodnota 0  prislúcha skupine B

echo on
% Príklad na klasifikáciu skupín A a B pomocou NS
% data pre skupinu A
xA =0.75 + 0.4*rand(1,10)-0.2;
yA =0.3 + 0.4*rand(1,10)-0.2;

% data pre skupinu B
xB =0.4 + 0.4*rand(1,10)-0.2;
yB =0.7 + 0.3*rand(1,10)-0.15;

% vykreslenie bodov skupín
h=figure;
axis([0 1 0 1])
plot(xA,yA,'or',xB,yB,'*b')
hold on

% vstupné data pre NS
V1=[xA xB];
V2=[yA yB];
X=[V1;V2]

% výstupne data pre NS
P=[ones(1,10) zeros(1,10)]

% vytvorenie štruktúry NS 
% jednovrstvova perceptron siet
% 2 vstupy s rozsahom (0,1)
% 1 vystup s funkciou 'hardlim'
net = perceptron;


% nastavenie parametrov trenovania
net.performFcn = 'sse';        		% Suma štvorcov odchýliek - nastavená úcelová funkcia
net.trainParam.goal = 0.000001;	    % Ukoncovacia podmienka na chybu SSE.
net.trainParam.show = 10;      	    % Frekvencia zobrazovania priebehu chyby trénovania
net.trainParam.epochs = 100;  	    % Max. pocet trénovacích cyklov.
 
net = train(net,X,P);

% vykreslenie deliacej priamky 
figure(h)
plotpc(net.iw{1,1},net.b{1})

echo off

% overenie predmetu A
predmetA=sim(net,[0.75; 0.3])

% overenie predmetu B
predmetB=sim(net,[0.4; 0.7])