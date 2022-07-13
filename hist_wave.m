
function [NDensity,X,Y] = hist_wave(Hsig,Tpeak,N)


Data = [Hsig;Tpeak]';

Density = hist3(Data,'nbins',[N N]);

NDensity = (Density./length(Hsig)).*100;

 Y = linspace(min(Hsig),max(Hsig),N);
 X = linspace(min(Tpeak),max(Tpeak),N);

end