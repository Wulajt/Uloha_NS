clear
% Príklad na aproximáciu funkcie y=sin(x.^2).*exp(-x) pomocou NS typu
% perceptron s 1 vstupom a 1 výstupom

echo on
load('datafun1')
plot(x,y)

n=length(y);
n2=fix(n/2);
% vytvorenie štruktúry NS 
% 1 vstup s rozsahom (0,4)
% 1 skrytá vrstva s poctom neurónov 8 s funkciou 'tansig'
% 1 výstup s funkciou 'purelin'
% trénovacia metóda - Levenberg-Marquardt 
net=fitnet(18);

net.divideFcn='divideint';  % kazdy n-ta vzorka
%11net.divideFcn='dividetrain';  % iba trenovacie
net.divideParam.trainRatio=1;
net.divideParam.valRatio=0;
net.divideParam.testRatio=0;

% Nastavenie parametrov trénovania
net.trainParam.goal = 1e-4;     % Ukon?ovacia podmienka na chybu SSE.
net.trainParam.epochs = 5000; 
%net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby
net.trainParam.min_grad=1e-10;

x_train = [];
y_train = [];
x_test = [];
y_test = [];
% Trénovanie NS
for i = 1:n
    if ismember(i,indx_train)
        x_train = [x_train, x(i)];
        y_train = [y_train, y(i)];
    elseif ismember(i,indx_test)
        x_test = [x_test, x(i)];
        y_test = [y_test, y(i)];
    end
end
net=train(net,x_train,y_train);

% Simulácia výstupu NS
outnetsim = net(x_test);

% Vykreslenie priebehov
figure
plot(x,y,'b',x_test,outnetsim,'-or')
echo off


