clear

load('datapiscisla_all.mat');

XTrain = [];
YTrain = [];
YTr = [];
XvalDat = [];
YvalDat = [];

trainLen = 1;
valLen = 1;
imgSize = 28;
len = 4940; %%% lenght of numbers data

Train_idx = randperm(len,len/100*60);

for i = 1:10
    YTrain = [YTrain, i*ones(1,494)];
end

for i = 1:4940
    xhelp = [];
    yhelp = [];
    y = 1;
    for x = 1:784
        yhelp = [yhelp, XDataall(x, i)];
        if y == 28
            xhelp = [xhelp; yhelp];
            yhelp = [];
            y = 0;
        end
        y = y + 1;
    end
    if ismember(i, Train_idx)
        XTrain(:,:,1,trainLen) = xhelp;
        YTr = [YTr, YTrain(i)];
        trainLen = trainLen + 1;
    else
        XvalDat(:,:,1,valLen) = xhelp;
        YvalDat = [YvalDat, YTrain(i)];
        valLen = valLen + 1;
    end
end

YTrain = categorical(YTr');
YvalDat = categorical(YvalDat');

numOfClasses = 10;

layers = [imageInputLayer([imgSize imgSize 1]);
    convolution2dLayer(5,6);
    reluLayer();
    maxPooling2dLayer(2,'Stride',2);
    convolution2dLayer(5,12);
    reluLayer();
    maxPooling2dLayer(2,'Stride',2);
    fullyConnectedLayer(numOfClasses);
    softmaxLayer();
    classificationLayer()];

options = trainingOptions('sgdm', ...
    'MaxEpochs',15, ...
    'ValidationData', {XvalDat,YvalDat}, ...
    'ValidationFrequency',10, ...
    'Plots','training-progress');

% rng('default')
[net,traininfo] = trainNetwork(XTrain,YTrain,layers,options);


numTrainImages = trainLen;
figure
idx = randperm(numTrainImages,10)
YTestPred = [];

for i = 1:numel(idx)
    subplot(2,5,i)    
    imshow(XTrain(:,:,:,idx(i)))
    drawnow
    YTestPred = [YTestPred classify(net,XTrain(:,:,:,idx(i)))];
end
YTestPred