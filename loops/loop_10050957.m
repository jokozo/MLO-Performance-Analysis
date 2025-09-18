mcs = 8;
radius = 7.5;
simTime = 10;
numSTA = 50;
channelBW = 20e6;
transmissionFormat = "HE-SU";
caseA = false;

tic

for isSTR = [true false]
    for legacyPerc = [ 10, 20, 30, 40, 50, 60, 70, 80, 90]
        parfor randnum = 1:7
            
            thr = MLO_10050957(randnum, simTime, numSTA, legacyPerc, caseA, radius, isSTR, channelBW, mcs, transmissionFormat)
            numStaSLO = round(numSTA*(legacyPerc/100));
            numStaMLO = numSTA - numStaSLO; 
            staMLOthr = thr(1:numStaMLO);
            staLegthr = thr((numStaMLO+1):numSTA);
            data = struct('time', str2double(string(datetime('now', 'Format', 'yyyyMMddHHmmss'))),  'channelBandwidth', channelBW, 'numSTA', numSTA, 'isSTR', isSTR, 'caseA', caseA, 'legacyPerc', legacyPerc, 'thrMLO', staMLOthr, 'thrLeg', staLegthr );
            saveToCSV('results/MLO_10050957.csv', data);
        end
    end
end
    

toc