mcs = 8;
radius = 5;
simTime = 10;
expectedLoad = 1;
channelBW = 80e6;

tic

isMLO = true;

bandAndChannelList = {[5 1; 5 100], [5 1; 5 100; 6 1; 6 100]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for maxThr = 100:100:3000
        parfor randnum = 1:7
            [thr, latency50, latency99] = MLO_10293865(randnum, simTime, radius, isMLO, channelBW, bandAndChannel, mcs, maxThr, expectedLoad);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'numLinks', numLinks, 'expectedThr', maxThr, 'randnum', randnum, 'fivLatency', latency50, 'ninLatency', latency99, 'thr', thr);
            saveToCSV('results/MLO_10293865.csv', data);
        end
    end
end

bandAndChannel = [5 1];
numLinks = size(bandAndChannel,1);
isMLO = false;
for maxThr = 100:100:3000
    parfor randnum = 1:7
        [thr, latency50, latency99] = MLO_10293865(randnum, simTime, radius, isMLO, channelBW, bandAndChannel, mcs, maxThr, expectedLoad);
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'numLinks', numLinks, 'expectedThr', maxThr, 'randnum', randnum, 'fivLatency', latency50, 'ninLatency', latency99, 'thr', thr);
        saveToCSV('results/MLO_10293865.csv', data);
    end
end

toc