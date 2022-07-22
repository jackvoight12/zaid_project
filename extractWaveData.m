function [Hsig, Tpeak, time, freq, Sf, Hsig_s, Hsig_w,Tpeak_s, Tpeak_w, fs, fw] = extractWaveData(filename);
%% extractWaveData
% This function takes anywhere from a week to a year of spectral wave density data from the
% national data buoy center and converts it into 11 different output values
% that are then used by test_code to make three varying histograms and
% three varying plots. 
%% Input: 
% filename (Spectral wave density data per year NOAA); file should be in
% .txt formatting; #YY  MM DD hh mm in top left
%% Output:
% Hsig: Significant wave height otherwise known as the mean wave height for 
% the highest third of waves; measured in meters (m)
% Tpeak: Peak wave period, the wave period associated with the most 
% energetic waves in the total wave spectrum at a specific point; derived 
% from the waves spectra; measured in seconds (s)
% time: time as given by data; is used to plot numerous x-axesl usually in 
% freq: wave frequency, used to split Hsig and Tpeak further, acquire
% wind and swell data, and plot with pcolor in test_code; measured in Hertz (Hz)
% Sf: Wave spectra; used to describe the distrubution of energy at different
% freq; meters squared per second (m^2/s)  
% Hsig_s: Significant wave height for swell; (m)
% Hsig_w: Significant wave height for wind; (m) 
% Tpeak_s: Peak wave period for swell; constructed with frequency and adjacent
% inputs adjusted to only include swell data(s)
% Tpeak_w: Peak wave period for wind;  constructed with frequency and adjacent
% inputs adjusted to only include wind wave data(s)
% fs: swell frequency; frequency below 0.1 Hz is identifiable as swell (Hz)
% fw: wind frequency;frequency above 0.1 Hz can be identified as wind waves (Hz)
% Output provides data to plot in test_code 
dat = importdata(filename);

% Organize and compiles dates to be used in datetime format
Textdata = dat.textdata;
Data = dat.data;

% Puts dates into cell and then puts cell into format fit to label plots
X = cell2mat(Textdata(2:end,:));
time = datetime(X,'InputFormat', 'yyyyMMddHHmm');

% States which columns are which data values 
freq = Data(1,:);
Sf = Data(2:end,:);

% Sets a minimum value for frequency and spectra so data is plotted
% correctly
x = find(freq>=0.045);
freq = freq(x);
Sf = Sf(:,x);


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

% Calculates significant wave height and Tpeak for wind waves
for i = 1:length(time)
    Hsig_w(i) = 4*sqrt(nansum(Sfw(i,:).*gradient(fw)));
    [~,id] = max(Sfw(i,:));
    Fpeak_w = fw(id);
    Tpeak_w(i) = 1./Fpeak_w;
end

% Calculates significant wave height and Tpeak for swell bands
for i = 1:length(time)
    Hsig_s(i) = 4*sqrt(nansum(Sfs(i,:).*gradient(fs)));
    [~,id] = max(Sfs(i,:));
    Fpeak_s = fs(id);
    Tpeak_s(i) = 1./Fpeak_s;
end

filename1 = 'extractWaveData_2020_41025.mat';
save(filename1,'Hsig', 'Tpeak', 'time', 'freq', 'Sf', 'Hsig_s', 'Hsig_w','Tpeak_s', 'Tpeak_w', 'fs', 'fw')
end

