mcs = 11;
radius = 5;
simTime = 10;
maxThr = 1008;
%bandAndChannel = [5 1];

tic
%najpierw leci dla 80mhz, potem dla 160
channelBW = 160e6;
bandAndChannelList = {[5 1], [5 1; 5 100]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for numSTA = [1, 4, 10]
        for expectedLoad = [0.2, 0.4, 0.6, 0.8, 1]
            parfor randnum = 1:7
                latency = MLO_1047571(randnum, simTime, numSTA, radius, channelBW, bandAndChannel, mcs, maxThr, expectedLoad)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numLinks', numLinks, 'channelBandwidth', channelBW, 'numSTAs', numSTA,'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', latency);
                saveToCSV('results/MLO_10475771.csv', data);
            end
        end
    end
end
toc