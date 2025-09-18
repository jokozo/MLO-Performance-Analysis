mcs = 8;
radiusList = [4.5 5 5.5 6];
simTime = 10;
expectedLoad = 1;
channelBW = 80e6;
bandAndChannel = [5 1; 5 100; 6 1; 6 100];
transmissionFormat = "EHT-SU";
aggrLimit = 1024;


tic

isMLO = true;
for allChannelsShared = [true false]
    for maxThr = [100 1000 2500]
        parfor randnum = 1:7
            [thr, latency50, latency99] = MLO_10293865_4a(randnum, simTime, radiusList, isMLO, allChannelsShared, bandAndChannel, mcs, maxThr, expectedLoad, aggrLimit, transmissionFormat);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'expectedThr', maxThr, 'isMLO', isMLO, 'allChannelsShared',allChannelsShared, 'transFormat',transmissionFormat, 'randnum', randnum, 'fivLatency', latency50, 'ninLatency', latency99, 'thr', thr);
            saveToCSV('results/MLO_10293865_4a.csv', data);
        end
    end
end



allChannelsShared = true;
isMLO = false;
transmissionFormat = "EHT-SU";
aggrLimit = 1024;
for maxThr = [100 1000 2500]
    parfor randnum = 1:7
        [thr, latency50, latency99] = MLO_10293865_4a(randnum, simTime, radiusList, isMLO, allChannelsShared, bandAndChannel, mcs, maxThr, expectedLoad, aggrLimit, transmissionFormat);
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'expectedThr', maxThr, 'isMLO', isMLO, 'allChannelsShared',allChannelsShared, 'transFormat',transmissionFormat, 'randnum', randnum, 'fivLatency', latency50, 'ninLatency', latency99, 'thr', thr);
        saveToCSV('results/MLO_10293865_4a.csv', data);
    end
end



transmissionFormat = "HE-SU";
aggrLimit = 256;
for maxThr = [100 1000 2500]
    parfor randnum = 1:7
        [thr, latency50, latency99] = MLO_10293865_4a(randnum, simTime, radiusList, isMLO, allChannelsShared, bandAndChannel, mcs, maxThr, expectedLoad, aggrLimit, transmissionFormat);
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'expectedThr', maxThr, 'isMLO', isMLO, 'allChannelsShared',allChannelsShared, 'transFormat',transmissionFormat, 'randnum', randnum, 'fivLatency', latency50, 'ninLatency', latency99, 'thr', thr);
        saveToCSV('results/MLO_10293865_4a.csv', data);
    end
end