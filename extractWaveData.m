function [Hsig, Tpeak, time, freq, Sf,Hsig_s,Hsig_w] = extractWaveData(filename);
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

cutoff = 0.1; % seperation freq between wind wave and swell band

% to get wind wave band spectrum
xw = find(freq>cutoff);
Sfw = Sf(:,xw);
fw = freq(xw);

% to get swell band spectrum
xs = find(freq<=cutoff);
Sfs = Sf(:,xs);
fs = freq(xs);

for i = 1:length(time)
    Hsig_w(i) = 4*sqrt(nansum(Sfw(i,:).*gradient(fw)));
%     [~,id] = max(Sf(i,:));
%     Fpeak = freq(id);
%     Tpeak(i) = 1./Fpeak;
end

for i = 1:length(time)
    Hsig_s(i) = 4*sqrt(nansum(Sfs(i,:).*gradient(fs)));
%     [~,id] = max(Sf(i,:));
%     Fpeak = freq(id);
%     Tpeak(i) = 1./Fpeak;
end

%convert time to yyyymmddHHMMSS format


end