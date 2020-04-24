% funkcia pre zobrazenie znaku 
% dataznak - data pre znak (stlpcovy vektor o rozsahu N)
% znaky su v mriezke pocet_r x pocet_s, tj. N=pocet_r*pocet_s neuronov
% pocet_r je pocet riadkov a pocet_s je pocet stlpcov mriezky
% hodnota 0-biele policko, 1 - cierne policko

function [h]=dispznak(dataznak,pocet_r,pocet_s,percenta)

[N,M]=size(dataznak);
h=figure;

if nargin<4
    percenta=ones(1,M);
end
percento=fix(10000*percenta)/100;
numb=[2 7 5 4];
for p=1:M,
    if M==1
        axis([0 pocet_s 0 pocet_r])
        hold on
    else
       %subplot(2,round(M/2),p)
       subplot(1,M,p)
        axis([0 pocet_s 0 pocet_r])
        hold on
        %title(['Number ' num2str(numb(p)) ' - ' num2str(percento(p)) '%'])
        axis off
    end
        k=0;

    if N==(pocet_s*pocet_r)
       for riadok=pocet_r:-1:1,
            for stlpec=1:pocet_s,
                k=k+1;
                c=[1-dataznak(k,p) 1-dataznak(k,p) 1-dataznak(k,p)];
                patch([stlpec-1 stlpec stlpec stlpec-1],[riadok riadok riadok-1 riadok-1],c)
            end
       end
    end
end
hold off
