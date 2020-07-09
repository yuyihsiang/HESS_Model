clc;clear all;close all;
%imcr=1;
% mcr.timeHis.time  = output.ptos.time;
% mcr.timeHis.power = -output.ptos.powerInternalMechanics(:,3);
% mcr.avgPower     = mean(-output.ptos.powerInternalMechanics(501:end,3))/1000;

w=1;
k=1;
timePowerTOT = 0;
for i=1:14
    filename = sprintf('weather%02dseed%02dsta%04d.mat', w, k, i);
    load(filename)
    timeHis(:,1,i) = mcr.timeHis.time;
    timeHis(:,2,i) = waves.waveAmpTime(:,2);
    timeHis(:,3,i) = mcr.timeHis.power/1000;
    avgPower(i)    = mcr.avgPower/1000;    
    timePowerTOT = timePowerTOT + timeHis(:,3,i);
    plot(timeHis(:,1,i),timeHis(:,3,i));
    hold on
end
plot(timeHis(:,1,i),timePowerTOT./14,'k-');
hold off
for j=1:14
    WECs_Aver(j) = mean(timeHis(:,3,j));
end
array.avgPower = mean(timePowerTOT(5001:end))/14;
array.peakPower= max(timePowerTOT(5001:end))/14;
array.minPower = min(timePowerTOT(5001:end))/14;
array.P2APR    = array.peakPower/ array.avgPower;

title('Cold case k1')
xlabel('Time (s)') 
ylabel('Power (kW)') 
% xlim([600 1500])
grid on
xlim([0 2100])
ylim([0 1500])
txt = sprintf('Peak Power = %6.2f (kW)', array.peakPower);
text(700,1450,txt)
txt = sprintf('Average Power = %6.2f (kW)', array.avgPower);
text(700,1380,txt)

txt = sprintf('Peak to Average Power Ratio = %6.2f', array.P2APR);
text(700,1310,txt)
