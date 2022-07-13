function [Hsig, Tpeak, time, freq, Sf ] = extractWaveData(filename, splot);
%% extractWaveData
% splot is a switch to turn the plot on and off
% filename = "noaa data here"
%filename = "2021_data.txt";
%splot = 1; 
dat = importdata(filename);

%%
Textdata = dat.textdata;
Data = dat.data;

X = cell2mat(Textdata(2:end,:));

% for check time header  dat.textdata(1,:)



%time = datetime(X,'yyyymmddHHMM');
time = datetime(X,'InputFormat', 'yyyyMMddHHmm');

freq = Data(1,:);
Sf = Data(2:end,:);

% Puts time and frequency into 2-D grid matrices
[Xg,Yg] = ndgrid(time,freq);

% Hsig and Tpeak variables declared 
Hsig = [];
Tpeak = [];

% Calculates significant wave height and Tpeak 
for i = 1:length(time)
    Hsig(i) = 4*sqrt(nansum(Sf(i,:).*gradient(freq)));
    [~,id] = max(Sf(i,:));
    Fpeak = freq(id);
    Tpeak(i) = 1./Fpeak;
end

%convert time to yyyymmddHHMMSS format

% if loop only plots if splot = 1
if splot == 1
    % Plots spectra * freq * time/ time * Tpeak/ time * Hsig
    figure
    subplot(3,1,1 )
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


    subplot(3,1,2)
    plot(time,Hsig);
    xlabel('time');
    ylabel('Hsig (m)');
    
    subplot(3,1,3)
    plot(time,Tpeak);
    xlabel('time');
    ylabel('Tpeak (s)');

    
else
end
end