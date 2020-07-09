clc;clear all;close all;


for j=1:3
    w=1;
    timePowerTOT = 0;
    for i=1:14
        filename = sprintf('weather%02dseed%02dsta%04d.mat', w, j, i);
        filename=strcat('./Cold Weather/k',int2str(j),'/',filename);
        load(filename)
        timeHis(:,1,i) = mcr.timeHis.time;
        timeHis(:,2,i) = waves.waveAmpTime(:,2);
        timeHis(:,3,i) = mcr.timeHis.power/1000;
        avgPower(i)    = mcr.avgPower/1000;    
        timePowerTOT = timePowerTOT + timeHis(:,3,i);
        timePowerWEC_Individual(:,j,i)  = timeHis(:,3,i);
    end
end

figure(1)
set(gcf,'position',[50 50 1280 500])
for i=1:14
    for j=1:size(timePowerWEC_Individual,1)
        timePowerWEC_Ind(j,i) = mean(timePowerWEC_Individual(j,:,i));
    end
    plot(timeHis(:,1,1),timePowerWEC_Ind(:,i),'LineWidth',1.0);
    hold on
end
hold off
grid on
title('Power of Individual WEC device - Cold Weather', 'Fontsize', 14)
xlim([0 2100])
xlabel('Time (s)')
ylabel('Power (kW)')
set(gca,'Fontsize',12)
%%
figure(2)
set(gcf,'position',[50 50 1280 500])
plot(timeHis(35002:end,1,1)-timeHis(35002,1,1)+700,timePowerTOT(35002:end,1),'LineWidth',1.0);
grid on
title('Average Power of WEC Array - Cold Weather', 'Fontsize', 14)
xlim([700 2100])
% xlim([0 1400])
xlabel('Time (s)')
ylabel('Power (kW)')
set(gca,'Fontsize',12)
%%
index=70000;
end_ind = size(timeHis(:,1,1),1);
data= [timeHis(end_ind-index:end,1,1)-timeHis(end_ind-index,1,1) timePowerTOT(end_ind-index:end,1)];

Energy_Initial = 0;
for i=1:(size(data,1)-1)
    Energy_HESS(i) = Energy_Initial + (data(i+1,1)-data(i,1))/2*...
        (data(i+1,2)+data(i,2))-...
        mean(data(:,2))*(data(i+1,1)-data(i,1));
    Energy_Initial = Energy_HESS(i);
end

PowerA=[data(:,1) data(:,2)]';
save('Funwave_ColdWeather_W1400s.mat','PowerA','-v7.3')
for i=1:(size(data,1)-1)
    
end

Power_aver(1,1:size(data,1)) = mean(data(:,2));
PowerAver=[data(:,1) Power_aver(1,:)']';
save('Funwave_ColdWeather_W1400s_Grid.mat','PowerAver','-v7.3')

% %%%%% Plot Energy of BESS %%%%%%%%%%%%%%%%%%%
figure(3)
set(gcf,'position',[50 50 1280 500])
plot(data(1:end-1,1),Energy_HESS(1,:),'LineWidth',1.8);
delta_Energy = max(Energy_HESS(1,:))-min(Energy_HESS(1,:))
Power_Max_HESS = max(data(:,2))- mean(data(:,2))
grid on
title(strcat("Energy Profile of WEC Array (Select Time Frame - ",int2str(round(index*0.02)),"s) - Cold Weather"), "Fontsize", 14)
xlim([0 index*0.02])
xlabel('Time (s)')
ylabel('Energy_{HESS} (kJ)')
set(gca,'Fontsize',12)

% %%%%% Plot Average Power of WEP %%%%%%%%%%%%%%%%%%%
figure(4)
set(gcf,'position',[50 50 1280 500])
plot(data(:,1),data(:,2),'LineWidth',1.8);
grid on
title(strcat("Average Power of WEC Array (Select Time Frame - ",int2str(round(index*0.02)),"s) - Cold Weather"), 'Fontsize', 14)
xlim([0 index*0.02])
xlabel('Time (s)')
ylabel('Power (kW)')
set(gca,'Fontsize',12)
