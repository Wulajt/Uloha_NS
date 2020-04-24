clear

load('datapiscisla_all.mat');

S1 = 20;

for i = 1:10
    
    net = patternnet(S1);

    % vsetky data pouzite na trenovanie
    net.divideFcn='dividerand';
    net.divideParam.trainRatio=0.6;
    net.divideParam.testRatio=0.4;
    net.divideParam.valRatio=0;

    % nastavenie parametrov trenovania epoch
    net.trainParam.goal = 0.000001;     % error goal.
    net.trainParam.show = 20;           % Frequency of progress displays (in epochs).
    net.trainParam.epochs = 1000;       % Maximum number of epochs to train.
    net.trainParam.min_grad = 1e-10;    % ukoncovacia podmienka na min. gradient 

    % trenovanie NS
    [net,tr] = train(net,XDataall,YDataall);
    % outnetsim = sim(net,XDataall)
    y = net(XDataall);
    perf = perform(net,YDataall,y)
end