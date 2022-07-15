% filename = "noaa data here"
% Input
filename = "C:\Users\voightj22\Desktop\zaid_project\2018_data.txt";


 [Hsig, Tpeak, time, freq, Sf,Hsig_s,Hsig_w, Tpeak_s, Tpeak_w, fs, fw] = extractWaveData(filename);

 N = 20;
[NDensity, NDensity_w, NDensity_s, X, Y, X_w, Y_w, Y_s, X_s] = hist_wave(Hsig,Tpeak,Hsig_w,Tpeak_w,Hsig_s,Tpeak_s,N);
 

%% make plot


    % Plots histograms
    figure
    [Xg,Yg] = ndgrid(time,freq);
    subplot(4,3,1)
    pcolor(X,Y,NDensity);shading flat;colorbar,colormap jet
    title('Total histogram');
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    axis square

    %% Swell histogram
    [Xg_s,Yg_s] = ndgrid(time,fs);
    subplot(4,3,2)
    pcolor(X_s,Y_s,NDensity_s);shading flat;colorbar,colormap jet
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    title('Swell histogram');
    axis square
    
    %% Wind histogram 
    [Xg_w,Yg_w] = ndgrid(time,fw);
    subplot(4,3,3)
    pcolor(X_w,Y_w,NDensity_w);shading flat;colorbar,colormap jet
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    title('Wind histogram');
    axis square

    %% Plots Time * Freq
    subplot(4,3,[4 5 6] )
    pc = pcolor(Xg,Yg, log10(Sf));
    set(pc,'EdgeColor','none')
    set(gca, 'YScale', 'log')
    shading interp;
   % caxis([1 5])
    colormap jet;
    a = colorbar;
    ylabel(a, 'Percentage %')
    xlabel('Time');
    ylabel('Freq');
    ylim([0.05 0.5])
    set(gca, 'YTickLabel',[.05 .1 .2 .3 .4 .5])

    %Plots time * Hsig (m) 
    subplot(4,3,[7 8 9])
    plot(time,Hsig); 
    xlabel('time');
    ylabel('Hsig (m)');
    hold on;
    plot(time,Hsig_w,'r')
    hold on;
    plot(time,Hsig_s,'k')    
    legend('total','wind wave','swell')
    
    % Plots time * tpeak (s) 
    subplot(4,3,[10 11 12])
    plot(time,Tpeak);
    xlabel('time');
    ylabel('Tpeak (s)');
    hold on; 
    plot(time, Tpeak_w, 'r')
    hold on; 
    plot(time, Tpeak_s, 'k')
    legend('total','wind wave','swell')







