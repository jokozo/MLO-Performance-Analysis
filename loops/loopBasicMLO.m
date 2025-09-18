numSTA = 1;
radius = 1;
simTime = 10;
bandAndChannel = [5 1; 5 100];
numLinks = size(bandAndChannel,1);
tic
%najpierw leci dla jednego linku, potem dla dwoch
for bandwidth = [80e6, 160e6]
    for mcs = 0:1:13
        for aggregationLimit = [64, 512, 1024]
            parfor randnum = 1:7
                thr = basicMLO(simTime,randnum, numSTA, radius, bandwidth, bandAndChannel, mcs, aggregationLimit)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'numSTAs', numSTA, 'numLinks', numLinks, 'channelBandwidth', bandwidth, 'randnum', randnum, 'mcs', mcs,  'aggregationLimit', aggregationLimit, 'throughput', thr);
                saveToCSV('results/basicMLO.csv', data);
            end
        end
    end
end
toc

