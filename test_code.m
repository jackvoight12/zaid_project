
%% extractWaveData Input
filename = "C:\Users\voightj22\Desktop\zaid_project\2020_data.txt";

%% extractWaveData function and outputs 
 [Hsig, Tpeak, time, freq, Sf,Hsig_s,Hsig_w, Tpeak_s, Tpeak_w, fs, fw] = extractWaveData(filename);

%% histwave function and output
% Adjust N below
N = 20; 
[NDensity, NDensity_w, NDensity_s, X, Y, X_w, Y_w, Y_s, X_s] = hist_wave(Hsig,Tpeak,Hsig_w,Tpeak_w,Hsig_s,Tpeak_s,N);
 

%% make plot
  
    f = figure;
    f.Position = [100 100 1500 1000];
    %% Plots histograms
    %% Total 
    [Xg,Yg] = ndgrid(time,freq);
    subplot(4,3,1)
    pcolor(X,Y,NDensity);shading flat;colorbar,colormap jet
    title('Total ');
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    a = colorbar;
    ylabel(a, 'Probability Occurence Percentage %')
    axis square

    %% Swell histogram
    % plots when freq <= 0.1 
    [Xg_s,Yg_s] = ndgrid(time,fs);
    subplot(4,3,2)
    pcolor(X_s,Y_s,NDensity_s);shading flat;colorbar,colormap jet
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    title('Swell');
    a2 = colorbar;
    ylabel(a2, 'Probability Occurence Percentage %')
    axis square
    
    %% Wind histogram 
    % plots when freq > 0.1 
    [Xg_w,Yg_w] = ndgrid(time,fw);
    subplot(4,3,3)
    pcolor(X_w,Y_w,NDensity_w);shading flat;colorbar,colormap jet
    ylabel('Hsig (m)');
    xlabel('T_P (s)');
    title('Wind wave');
    a1 = colorbar;
    ylabel(a1, 'Probability Occurence Percentage %')
    axis square

    %% Plots Time * Freq
    subplot(4,3,[4 5 6] )
    pc = pcolor(Xg,Yg, log10(Sf));
    set(pc,'EdgeColor','none')
    set(gca, 'YScale', 'log')
    shading interp;
    colormap jet;
    b = colorbar;
    ylabel(b, 'log(m^2/Hz)')
    xlabel('Time');
    ylabel('Freq');
    ylim([0.05 0.5])
    yticks([0.05  .15  .25  .35  .45 ])
   
    %% Plots time * Hsig (m) 
    subplot(4,3,[7 8 9])
    plot(time,Hsig); 
    xlabel('time');
    ylabel('Hsig (m)');
    hold on;
    plot(time,Hsig_w,'r')
    hold on;
    plot(time,Hsig_s,'k')    
    legend('total','wind wave','swell')
    
    %% Plots time * tpeak (s) 
    subplot(4,3,[10 11 12])
    plot(time,Tpeak);
    xlabel('time');
    ylabel('Tpeak (s)');
    hold on; 
    plot(time, Tpeak_w, 'r')
    hold on; 
    plot(time, Tpeak_s, 'k')
    legend('total','wind wave','swell')
    
    %% Change file name each save
    % Format: bulkwaveparameter_year_station# 
    savefig('bulkwaveparameter_2003_41025')
    saveas(f, 'bulkwaveparameter_2003_41025.jpg')
   



    



  







