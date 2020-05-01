clear

load('datapiscisla_all.mat');


S1 = 24;

best_succ_rate = 0;
min_succ_rate = 0;
mean_succ_rate = 0;

for i = 1:10
    
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
    classes_predict = vec2ind(outnetsim);
    classes_true = vec2ind(YDataall);

    confmat = confusionmat(classes_true,classes_predict)/4940*100
    succesfull_rate = trace(confmat)
    
    if succesfull_rate > best_succ_rate
        best_succ_rate = succesfull_rate;
        best_net = net;
    end
    if i == 1
        min_succ_rate = succesfull_rate;
    elseif succesfull_rate < min_succ_rate
        min_succ_rate = succesfull_rate;
    end
    mean_succ_rate = mean_succ_rate + succesfull_rate;
end

best_succ_rate
min_succ_rate
mean_succ_rate = mean_succ_rate/10