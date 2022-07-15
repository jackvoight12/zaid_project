% Function to create a histogram 
function [NDensity, NDensity_w, NDensity_s, X, Y, X_w, Y_w, Y_s, X_s] = hist_wave(Hsig,Tpeak,Hsig_w,Tpeak_w,Hsig_s,Tpeak_s,N)


Data = [Hsig;Tpeak]';

Density = hist3(Data,'nbins',[N N]);

NDensity = (Density./length(Hsig)).*100;
NDensity_w = (Density./length(Hsig_w)).*100;
NDensity_s = (Density./length(Hsig_s)).*100;

 Y = linspace(min(Hsig),max(Hsig),N);
 X = linspace(min(Tpeak),max(Tpeak),N);

Y_w = linspace(min(Hsig_w),max(Hsig_w),N);
X_w = linspace(min(Tpeak_w),max(Tpeak_w),N);

Y_s = linspace(min(Hsig_s),max(Hsig_s),N);
X_s = linspace(min(Tpeak_s),max(Tpeak_s),N);
end