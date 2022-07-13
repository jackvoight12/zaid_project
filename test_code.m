clc
clear

% filename = "noaa data here"
% Input
filename = "C:\Users\voightj22\Desktop\zaid_project\2017_data.txt";
splot = 1;

[Hsig, Tpeak, time, freq, Sf,Hsig_s,Hsig_w] = extractWaveData(filename);
%%
N = 20;
 [NDensity,X,Y] = hist_wave(Hsig,Tpeak,N);% for total 
 

% Data = [Hsig;Tpeak]';
% 
% Density = hist3(Data,'nbins',[20 20]);
% 
% NDensity = (Density./length(Hsig)).*100;
% 
% X = linspace(min(Hsig),max(Hsig),20);
% Y = linspace(min(Tpeak),max(Tpeak),20);

%% make plot
% if loop only plots if splot = 1

    % Plots spectra * freq * time/ time * Tpeak/ time * Hsig
    figure
[Xg,Yg] = ndgrid(time,freq);
subplot(411)
pcolor(X,Y,NDensity);shading flat;colorbar,colormap jet
ylabel('Hsig (m)');
xlabel('T_P (s)');

axis square
    subplot(4,1,2 )
    pc = pcolor(Xg,Yg, log10(Sf));
    set(pc,'EdgeColor','none')
    set(gca, 'YScale', 'log')
    shading interp;
   % caxis([1 5])
    colormap jet;
    colorbar;
    xlabel('Time')
    ylabel('Freq');
    ylim([0.05 0.5])

    subplot(4,1,3)
    plot(time,Hsig);
    xlabel('time');
    ylabel('Hsig (m)');
    hold on;
    plot(time,Hsig_w,'r')
    hold on;
    plot(time,Hsig_s,'k')    

    legend('total','wind wave','swell')
    
    subplot(4,1,4)
    plot(time,Tpeak);
    xlabel('time');
    ylabel('Tpeak (s)');





%%


