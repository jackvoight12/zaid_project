function [NDensity, NDensity_w, NDensity_s, X, Y, X_w, Y_w, Y_s, X_s] = hist_wave(Hsig,Tpeak,Hsig_w,Tpeak_w,Hsig_s,Tpeak_s,N)
%% hist_wave
% This function creates data to plot histograms on test_code from the data
% recieved from extractWaveData along with N, which is a constant decided
% within test_code
%% Input: 
% Hsig,Tpeak,Hsig_w,Tpeak_w,Hsig_s,Tpeak_s defined in extractWaveData;
% Outputs
% N: value that determines size and shape of the plot; can be changed upon
% discretion of user
%% Output:
% NDensity: density of our data adjusted to the length of Hsig 
% NDensity_w: NDensity adjusted to wind waves
% NDensity_s: NDensity adjusted to swell 
% X: What will be used to plot the x axis of the histogram
% Y: What will be uses to plot the y axis of the histogram
% X_w: X adjusted to wind waves
% Y_w: Y adjusted to wind waves
% X_s: X adjusted to swell
% Y_s: Y adjusted to swell 

% Reorganize data to be put into hist3 function
Data = [Hsig;Tpeak]';
% Wind data
Data_w = [Hsig_w;Tpeak_w]';
%Swell data
Data_s = [Hsig_s;Tpeak_s]';

% Stores density of Hsig by Tpeak with regards to N for all three types of
% data values
Density = hist3(Data,'nbins',[N N]);
Density_w = hist3(Data_w,'nbins',[N N]);
Density_s = hist3(Data_s,'nbins',[N N]);

% Calculate NDensity outputs for all data values with regard to their
% respective significant wave heights
NDensity = (Density./length(Hsig)).*100;
NDensity_w = (Density_w./length(Hsig_w)).*100;
NDensity_s = (Density_s./length(Hsig_s)).*100;

% Puts the three different histogram values into arrays that begin and end
% at the min and max of each axis 
 Y = linspace(min(Hsig),max(Hsig),N);
 X = linspace(min(Tpeak),max(Tpeak),N);
Y_w = linspace(min(Hsig_w),max(Hsig_w),N);
X_w = linspace(min(Tpeak_w),max(Tpeak_w),N);
Y_s = linspace(min(Hsig_s),max(Hsig_s),N);
X_s = linspace(min(Tpeak_s),max(Tpeak_s),N);
end