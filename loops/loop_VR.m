numSTA = 1;
radius = 3;
simTime = 10;
bandAndChannel = [6 39; 6 151];
numLinks = size(bandAndChannel,1);
tic

for isMLO = [true false]
    for channelBW = [20e6, 40e6, 80e6, 160e6, 320e6]
        for mcs = 0:1:13
            for isDownlink = [true false]
                parfor randnum = 1:7
                    latency = MLO_VR(simTime, randnum, radius, channelBW, bandAndChannel, mcs, numSTA, isDownlink, isMLO)
                    data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'isMLO', isMLO, 'isDownlink', isDownlink, 'channelBandwidth', channelBW, 'mcs', mcs, 'randnum', randnum, 'latency', latency);
                    saveToCSV('results/MLO_VR.csv', data);
                end
            end
        end
    end
end
toc