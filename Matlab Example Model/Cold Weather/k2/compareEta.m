%imcr=1;
% mcr.timeHis.time  = output.ptos.time;
% mcr.timeHis.power = -output.ptos.powerInternalMechanics(:,3);
% mcr.avgPower     = mean(-output.ptos.powerInternalMechanics(501:end,3))/1000;

w=1;
k=2;

for i=1:14
    filename = sprintf('weather%02dseed%02dsta%04d.mat', w, k, i);
    load(filename)
    timeHis(:,1,i) = mcr.timeHis.time;
    timeHis(:,2,i) = waves.waveAmpTime(:,2);
    timeHis(:,3,i) = mcr.timeHis.power;
    avgPower(i)    = mcr.avgPower;    
    plot(timeHis(:,1,i),timeHis(:,2,i));
    hold on
end
