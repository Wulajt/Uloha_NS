clear

load('datapiscisla_all.mat');

S1 = 24;
net = patternnet(S1);

% vsetky data pouzite na trenovanie
net.divideFcn='dividerand';
net.divideParam.trainRatio=0.6;
net.divideParam.testRatio=0.4;
net.divideParam.valRatio=0;

% nastavenie parametrov trenovania epoch
net.trainParam.goal = 0.000001;    % error goal.
net.trainParam.show = 20;          % Frequency of progress displays(in epochs).
net.trainParam.epochs = 1000;      % Maximum number of epochs to train.
net.trainParam.min_grad = 1e-5;    % ukoncovacia podmienka na min. gradient 

% trenovanie NS
net = train(net,XDataall,YDataall);

outnetsim = sim(net,XDataall);
YPredicted = net(XDataall);
classes_predict = vec2ind(outnetsim);
classes_true = vec2ind(YDataall);
confmat = confusionmat(classes_true,classes_predict)/4940*100
succesfull_rate = trace(confmat)
plotconfusion(YDataall,YPredicted)

% vytahovanie objektov z datasetu a priradenie objektu predpokladane
%cislo na zaklade natrenovanej neurpnovej siete
for i = 100:500:4600
    dataX= XDataall(:,i);
    dispznak(dataX,28,28);
    cislo = sim(net,dataX)
    class = vec2ind(cislo)
end