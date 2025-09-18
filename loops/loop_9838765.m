mcs = 11;
radius = 5;
simTime = 10;
maxThr = 920;
radiusList = [6 7];
channelBW = 80e6;
tic

expectedOccupanciesList = {[0.1 0.1], [0.4 0.4], [0.7 0.7], [0.1 0.4], [0.1 0.7], [0.4 0.7]};
for i = 1:length(expectedOccupanciesList)
    expectedOccupancies = expectedOccupanciesList{i};
    for isMLO = [true false]
        for expectedLoad = [0.2, 0.4, 0.6, 0.8]
            parfor randnum = 1:7
                [thr, latencyMainSTA, avgLatency ] = MLO_9838765(randnum, simTime, radius, radiusList, channelBW, isMLO, mcs, maxThr, expectedLoad, expectedOccupancies)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))),  'channelBandwidth', channelBW, 'isMLO', isMLO ,'expOccupancyListNum', i,'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', avgLatency, 'ninfivprclatency', latencyMainSTA);
                saveToCSV('results/MLO_9838765_redo2.csv', data);
            end
        end
    end
end
toc