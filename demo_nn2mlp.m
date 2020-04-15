% Demo program na klasifikaciu predmetov skupiny A a B na základe vlastností V1 a V2 
% NS má 2 vstupy veliciny V1,V2 o rozsahu 0-1 (0-100%) a 2 výstupy o rozsahu 0-1, 
% kde hodnota 1.výstup prislúcha skupine A a  2. výstup skupine B

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
P=[ones(1,10) zeros(1,10);zeros(1,10) ones(1,10)]


% vytvorenie struktury NS na klasifikaciu
net = patternnet(5)

% vsetky data pouzite na trenovanie
net.divideFcn='dividetrain';
% net.divideParam.trainRatio=1;
% net.divideParam.valRatio=0;
% net.divideParam.testRatio=0;

net.trainParam.goal = 0.000001;	    % Ukoncovacia podmienka na chybu SSE.
net.trainParam.epochs = 300;  	    % Max. pocet trénovacích cyklov.
net.trainParam.min_grad=1e-10;      % Ukoncovacia podmienka na min. gradient


% trenovanie siete
net = train(net,X,P);
disp('---- stlac klavesu ----')
pause

% simulacia vystupu NS
y = net(X);
% vypocet chyby siete
perf = perform(net,P,y)

% priradenie vstupov do tried
classes = vec2ind(y)
disp('---- stlac klavesu ----')
pause


% testovacie data 5 skupina B a 5 skupina A
X2=[0.3 0.4 0.7 0.8 0.5;0.6 0.7 0.2 0.3 0.5];

% simulacia vystupu NS
y2 = net(X2)

% priradenie vstupov do tried
classes2 = vec2ind(y2)
echo off
