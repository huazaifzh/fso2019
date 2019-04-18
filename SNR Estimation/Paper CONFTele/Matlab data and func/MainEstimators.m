%% power analysis CONF Tele

clear all
clc


%% loading Data
load('D:\Users\Pc\Documents\GitHub\fso2019\SNR Estimation\Paper CONFTele\Matlab data and func\2_hours_meas_10_April.mat')

%% Fixed Taps Estimator
for nTaps=1:100
    for idx=1:length(power)
        [estFixedTaps(nTaps,:)] = estimate_meanSNR(power,nTaps);
        MSE(nTaps)= mean((estFixedTaps(nTaps,idx)-power(idx)).^2);
    end
end
[value,optTaps]=min(MSE)

% getting the best Number of Taps

%% Real time estimator
[dynamicTaps]= realTimeEst(power);
MSE_dynamic=mean((dynamicTaps(2:end)-power(2:end)).^2);

%% Differencial estimator
optTapsD=12;
% MSEm=1;
% for optTaps=1:100
% [differential,MSE_diff]=estimatordiff(power,optTaps)
%     if MSE_diff<MSEm
%         MSEm=MSE_diff;
%         tapsG=optTaps
%     end
%     
% end
[differential,MSE_diff]=estimatordiff(power,optTapsD)

%% Exposing Results
% 

% figure(),hold on, plot(power),plot(estFixedTaps),plot(dynamicTaps),plot(differential), ...
% legend('Real power','Fixed number of Taps estimation','Differencial estimation'),hold off

figure(),hold on,title('Power estimations'), plot(power),plot(estFixedTaps(optTaps,:)),plot(dynamicTaps),plot(differential), ...
legend('Real power','Fixed number of Taps estimation','Differencial estimation'),hold off