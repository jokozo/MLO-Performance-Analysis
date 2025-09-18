mcs = 8;
simTime = 10;
maxThr = 670;
channelBW = 80e6;
radiusList = [6 7];

tic
%wykres 1: SLO, STR, EMLSR, 1BSS, fullBuffer
%fig3

numBSS = 1;
expectedLoad = 1;


isFullBuffer = true;
isSTR = true;
bandAndChannelList = {[5 1], [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    parfor randnum = 1:7
        [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'numLinks', numLinks, 'isSTR', isSTR, 'randnum', randnum, 'thr', thr);
        saveToCSV('results/MLO_10118829_I.csv', data);
    end
end


isSTR = false;
bandAndChannelList = { [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    parfor randnum = 1:7
        [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
        data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'numLinks', numLinks, 'isSTR', isSTR, 'randnum', randnum, 'thr', thr);
        saveToCSV('results/MLO_10118829_I.csv', data);
    end
end

%fig4
isFullBuffer = false;
isSTR = true;
bandAndChannelList = {[5 1], [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for expectedLoad = [0.1 0.3 0.5 0.7 0.9]
        parfor randnum = 1:7
            [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'maxThr', maxThr, 'numLinks', numLinks, 'isSTR', isSTR, 'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', avgLatency, 'ninLatency', latency99list, 'thr', thr);
            saveToCSV('results/MLO_10118829_I_fig4.csv', data);
        end
    end
end


isSTR = false;
bandAndChannelList = { [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for expectedLoad = [0.1 0.3 0.5 0.7 0.9]
        parfor randnum = 1:7
            [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'maxThr', maxThr, 'numLinks', numLinks, 'isSTR', isSTR, 'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', avgLatency, 'ninLatency', latency99list, 'thr', thr);
            saveToCSV('results/MLO_10118829_I_fig4.csv', data);
        end
    end
end

%fig5
numBSS = 2;
isSTR = true;
bandAndChannelList = {[5 1], [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for expectedLoad = [0.1 0.3 0.5 0.7 0.9]
        parfor randnum = 1:7
            [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'maxThr', maxThr, 'numLinks', numLinks, 'isSTR', isSTR, 'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', avgLatency, 'ninLatency', latency99list, 'thr', thr);
            saveToCSV('results/MLO_10118829_II_fig5.csv', data);
        end
    end
end


isSTR = false;
bandAndChannelList = { [5 1; 5 100], [5 1; 5 100; 5 160]};
for i = 1:length(bandAndChannelList)
    bandAndChannel = bandAndChannelList{i};
    numLinks = size(bandAndChannel,1);
    for expectedLoad = [0.1 0.3 0.5 0.7 0.9]
        parfor randnum = 1:7
            [thr, avgLatency, latency99list] = MLO_10118829_I_II(randnum, simTime, radiusList, isSTR, numBSS, bandAndChannel,channelBW, mcs, maxThr, isFullBuffer, expectedLoad);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))), 'channelBandwidth', channelBW, 'maxThr', maxThr, 'numLinks', numLinks, 'isSTR', isSTR, 'expectedLoad', expectedLoad, 'randnum', randnum, 'avgLatency', avgLatency, 'ninLatency', latency99list, 'thr', thr);
            saveToCSV('results/MLO_10118829_II_fig5.csv', data);
        end
    end
end