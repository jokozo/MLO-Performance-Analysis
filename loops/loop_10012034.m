mcs = 8;
radius = 5;
simTime = 10;
radiusList = [5.5 6 6.5 7];
channelBW = 80e6;
expectedLoad = 1;
tic


isMLO = true;
expectedOccupanciesList = {[0.2 0.2 0.2 0.2], [0.5 0.5 0.5 0.5], [0.8 0.8 0.8 0.8]};
for i = 1:length(expectedOccupanciesList)
    expectedOccupancies = expectedOccupanciesList{i};
    bandAndChannelList = {[5 1; 5 100], [5 1; 5 100; 6 1; 6 100]};
    for j = 1:length(bandAndChannelList)
        bandAndChannel = bandAndChannelList{j};
        numLinks = size(bandAndChannel,1); 
        for maxThr = 100:100:3000
            parfor randnum = 1:7
                [thr, latencyMain50, latencyMain99, avgLatency ] = MLO_10012034(randnum, simTime, radius, radiusList, channelBW, bandAndChannel, isMLO, mcs, maxThr, expectedLoad, expectedOccupancies)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks ,'expOccupancyListNum', i,'maxThr', maxThr, 'randnum', randnum,'thr', thr, 'avgLatency', avgLatency, 'ninprclatency', latencyMain99, 'fivprclatency', latencyMain50);
                saveToCSV('results/MLO_10012034.csv', data);
            end
        end
    end
end

bandAndChannel = [5 1];
numLinks = 1;
isMLO = false;
expectedOccupanciesList = {[0.2 0.2 0.2 0.2], [0.5 0.5 0.5 0.5], [0.8 0.8 0.8 0.8]};
for i = 1:length(expectedOccupanciesList)
expectedOccupancies = expectedOccupanciesList{i}; 
    for maxThr = 100:100:3000
        parfor randnum = 1:7
            [thr, latencyMain50, latencyMain99, avgLatency ] = MLO_10012034(randnum, simTime, radius, radiusList, channelBW, bandAndChannel, isMLO, mcs, maxThr, expectedLoad, expectedOccupancies)
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks ,'expOccupancyListNum', i,'maxThr', maxThr, 'randnum', randnum,'thr', thr, 'avgLatency', avgLatency, 'ninprclatency', latencyMain99, 'fivprclatency', latencyMain50);
            saveToCSV('results/MLO_10012034.csv', data);
        end
    end
end

toc

