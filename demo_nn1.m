echo on
% Demo program na aproximaciu zavislosti y=f(x) jednym lin. neuronom
% ukazka trenovania

% Zadanie dat - naklikanie bodov na aproximaciu do grafu
figure
title('Naklikaj body, a stlac Enter')
axis([0 1 0 1])
[x,y]=ginput        % zadanie bodov mysou
x=x'; y=y';
plot(x,y,'ro')

% vykreslenie plochy pre odchylku v zavislosti od vahy a biasu
figure
w_range = -1:0.2:1;  b_range = -1:0.2:1;
ES = errsurf(x,y,w_range,b_range,'purelin');
plotes(w_range,b_range,ES)      % vykreslenie povrchu odchylky

% vytvorenie struktury siete
maxlr = 0.40*maxlinlr(x,'bias');    % urcenie max. hodnoty rychlosti ucenia
net = newlin([0 1],1,[0],maxlr);

% Trenovanie siete
% [net,tr] = train(net,P,T);
net.trainParam.goal = .001;      % ukoncovacia podmienka chyby
net.trainParam.epochs = 1;      % pocet epoch 1
net.trainParam.show = NaN;      % priebeh chyby nezobrazovat
h=plotep(net.IW{1},net.b{1},mse(y-sim(net,x)));     % vykreslenie priebehu chyby
[net,tr] = train(net,x,y);                          % trenovanie NS                          
r = tr;
echo off
epoch = 1;
while true
   epoch = epoch+1;
   [net,tr] = train(net,x,y);                           % dalsia etapa trenovania
   if length(tr.epoch) > 1
      h = plotep(net.IW{1,1},net.b{1},tr.perf(2),h);    % vykreslenie priebehu chyby
      r.epoch=[r.epoch epoch]; 
      r.perf=[r.perf tr.perf(2)];
      r.vperf=[r.vperf NaN];
      r.tperf=[r.tperf NaN];
   else
      break
   end
   if epoch>300                    % ukoncovacia podmienka na def. pocet etap
       break
   end
end
tr=r;

echo on

% vykreslenie priebehu trenovacej odchylky 
plotperf(tr,net.trainParam.goal);

% simulacia vystupu siete
p = [0 1];
a = sim(net, p)

% porovnanie meranych dat a vystupu siete
figure
plot(x,y,'ro',p,a,'LineWidth',2)

echo off


