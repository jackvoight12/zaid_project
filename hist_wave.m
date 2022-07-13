
function [NDensity,X,Y] = hist_wave(Hsig,Tpeak,N)

Data = [Hsig;Tpeak]';

Density = hist3(Data,'nbins',[N N]);

NDensity = (Density./length(Hsig)).*100;

X = linspace(min(Hsig),max(Hsig),N);
Y = linspace(min(Tpeak),max(Tpeak),N);

histogram(hist3) 
end