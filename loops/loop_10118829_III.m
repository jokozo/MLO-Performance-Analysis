mcs = 8;
simTime = 10;
channelBW = 80e6;
radiusList = [5 6 7];
bandAndChannel = [5 1; 5 100];

tic

%fig6

for isSTR = [true false]
    parfor randnum = 1:7
        thr = MLO_10118829_III(randnum, simTime, radiusList, isSTR, bandAndChannel,channelBW, mcs)
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'isSTR', isSTR, 'randnum', randnum, 'thrMLO', thr(1), 'thrObssI', thr(2), 'thrObssII', thr(3));
        saveToCSV('results/MLO_10118829_III.csv', data);
    end
end

toc