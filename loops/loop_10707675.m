%niedokonczone
mcs = 11;
radius = 5;
radiusList = [4 6];
simTime = 10;
maxThrList = [670 930 927];
bandAndChannel = [5 1; 5 100];

channelBW = 80e6;
expectedOccupancies = [0.1 0];

tic

isFullBuffer = true;
expectedLoad = 1;
numLinks = size(bandAndChannel,1);

txopLimits =  {[0 0 0 0], [94 94 94 94]};
for j = 1:length(txopLimits)
    txop = txopLimits{j};
    for aggrLimit = [64 512 1024]
        aggrValues = [64 512 1024];
        aggrIdx = find(aggrValues == aggrLimit);
        maxThr = maxThrList(aggrIdx);
        parfor randnum = 1:7
            [thr, avgLatency] = MLO_10706765(randnum, simTime, radius, radiusList, bandAndChannel, aggrLimit, channelBW, mcs, isFullBuffer, maxThr, expectedLoad, expectedOccupancies, txop)
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks, 'channelBandwidth', channelBW ,'isFullBuffer', isFullBuffer,'expectedLoad',expectedLoad, 'expOcc', 5 ,'txop',j, 'aggr',aggrLimit,'randnum', randnum, 'avgLatency', avgLatency,'thr', thr);
            saveToCSV('results/MLO_10706765_dod.csv', data);
        end
    end
end 


isFullBuffer = false;
numLinks = size(bandAndChannel,1);
for expectedLoad = [0.2 0.4 0.6 0.8]
    txopLimits =  {[0 0 0 0], [94 94 94 94]};
    for j = 1:length(txopLimits)
        txop = txopLimits{j};
        for aggrLimit = [64 512 1024]
            aggrValues = [64 512 1024];
            aggrIdx = find(aggrValues == aggrLimit);
            maxThr = maxThrList(aggrIdx);
            parfor randnum = 1:7
                [thr, avgLatency] = MLO_10706765(randnum, simTime, radius, radiusList, bandAndChannel, aggrLimit, channelBW, mcs, isFullBuffer, maxThr, expectedLoad, expectedOccupancies, txop)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks, 'channelBandwidth', channelBW ,'isFullBuffer', isFullBuffer,'expectedLoad',expectedLoad, 'expOcc', 5 ,'txop',j, 'aggr',aggrLimit,'randnum', randnum, 'avgLatency', avgLatency,'thr', thr);
                saveToCSV('results/MLO_10706765_dod.csv', data);
            end
        end
    end 
end



bandAndChannel = [5 1];

isFullBuffer = true;
expectedLoad = 1;
numLinks = size(bandAndChannel,1);
txopLimits =  {[0 0 0 0], [94 94 94 94]};
for j = 1:length(txopLimits)
    txop = txopLimits{j};
    for aggrLimit = [64 512 1024]
        aggrValues = [64 512 1024];
        aggrIdx = find(aggrValues == aggrLimit);
        maxThr = maxThrList(aggrIdx);
        parfor randnum = 1:7
            [thr, avgLatency] = MLO_10706765(randnum, simTime, radius, radiusList, bandAndChannel, aggrLimit, channelBW, mcs, isFullBuffer, maxThr, expectedLoad, expectedOccupancies, txop)
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks, 'channelBandwidth', channelBW ,'isFullBuffer', isFullBuffer,'expectedLoad',expectedLoad, 'expOcc', 5 ,'txop',j, 'aggr',aggrLimit,'randnum', randnum, 'avgLatency', avgLatency,'thr', thr);
            saveToCSV('results/MLO_10706765_dod.csv', data);
        end
    end
end 


isFullBuffer = false;
numLinks = size(bandAndChannel,1);
for expectedLoad = [0.2 0.4 0.6 0.8]
    txopLimits =  {[0 0 0 0], [94 94 94 94]};
    for j = 1:length(txopLimits)
        txop = txopLimits{j};
        for aggrLimit = [64 512 1024]
            aggrValues = [64 512 1024];
            aggrIdx = find(aggrValues == aggrLimit);
            maxThr = maxThrList(aggrIdx);
            parfor randnum = 1:7
                [thr, avgLatency] = MLO_10706765(randnum, simTime, radius, radiusList, bandAndChannel, aggrLimit, channelBW, mcs, isFullBuffer, maxThr, expectedLoad, expectedOccupancies, txop)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks, 'channelBandwidth', channelBW ,'isFullBuffer', isFullBuffer,'expectedLoad',expectedLoad, 'expOcc', 5 ,'txop',j, 'aggr',aggrLimit,'randnum', randnum, 'avgLatency', avgLatency,'thr', thr);
                saveToCSV('results/MLO_10706765_dod.csv', data);
            end
        end
    end 
end


toc