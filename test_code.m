clc
clear

% filename = "noaa data here"
% Input
filename = "2016_data.txt";
splot = 1;

[Hsig, Tpeak, time, freq, Sf ] = extractWaveData(filename, splot);
%%

 [NDensity,X,Y] = hist_wave(Hsig,Tpeak,N)

% Data = [Hsig;Tpeak]';
% 
% Density = hist3(Data,'nbins',[20 20]);
% 
% NDensity = (Density./length(Hsig)).*100;
% 
% X = linspace(min(Hsig),max(Hsig),20);
% Y = linspace(min(Tpeak),max(Tpeak),20);
figure;
pcolor(X,Y,NDensity);shading flat;colorbar,colormap jet
xlabel('Hsig (m)');
ylabel('T_P (s)');


