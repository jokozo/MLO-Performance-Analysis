mcs = 13;
simTime = 10;
channelBW = 80e6;
radius = 3;
radiusList = [2 4];
bandAndChannel = [5 1; 6 1];
maxThr = 1112;

tic

%fig5
isMLO = true;
for isSTR = [true false]
    for isUplink = [true false]
        for expectedOccupancies = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]
            parfor randnum = 1:7
                thr = MLO_9855457(randnum, simTime, radius, radiusList, isMLO, isSTR, isUplink, channelBW, bandAndChannel, mcs, maxThr, expectedOccupancies)
                data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'isMLO', isMLO, 'isSTR', isSTR, 'isUplink', isUplink, 'maxThr', maxThr, 'expectedOccupancy', expectedOccupancies, 'randnum', randnum, 'thrMain', thr(1));
                saveToCSV('results/MLO_9855457.csv', data);
            end
        end
    end
end

isMLO = false;
isSTR = false;
for isUplink = [true false]
    for expectedOccupancies = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]
        parfor randnum = 1:7
            thr = MLO_9855457(randnum, simTime, radius, radiusList, isMLO, isSTR, isUplink, channelBW, bandAndChannel, mcs, maxThr, expectedOccupancies)
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'isMLO', isMLO, 'isSTR', isSTR, 'isUplink', isUplink, 'maxThr', maxThr, 'expectedOccupancy', expectedOccupancies, 'randnum', randnum, 'thrMain', thr(1));
            saveToCSV('results/MLO_9855457.csv', data);
        end
    end
end



toc