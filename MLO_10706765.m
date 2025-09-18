function [thr, avgLatency] = MLO_10706765(randnum, simTime, radius, radiusList, bandAndChannel, aggrLimit, channelBW, mcs, isFullBuffer, maxThr, expectedLoad, expectedOccupancies, txop)
   
% inspired by "Aggregation Algorithm to Increase Throughput of Multi-Link
% Wi-Fi 7 Devices"


    % Set seed of random number generator for reproducible results
    rng(randnum,"combRecursive");
    % Set simulation time
    simulationTime = simTime;

   
    staNodes = wlanNode.empty();
    phyAbstraction="tgax-evaluation-methodology";
    macAbstraction = true;
    
    % Create wireless network simulator
    networkSimulator = wirelessNetworkSimulator.init;
    % Band and channel values for each link
    numLinks = size(bandAndChannel,1);
    
    [staPosition, apPosition] = randomPositionsFermat(1, radius);

    % Create the link config objects for AP MLD, STR STA MLD
    for linkIdx = 1:numLinks
        apLinkCfg(linkIdx) = wlanLinkConfig(BandAndChannel=bandAndChannel(linkIdx,:),MPDUAggregationLimit=aggrLimit,ChannelBandwidth=channelBW,MCS=mcs,TXOPLimit=txop);
        staSTRLinkCfg(linkIdx) = wlanLinkConfig(BandAndChannel=bandAndChannel(linkIdx,:),MPDUAggregationLimit=aggrLimit,ChannelBandwidth=channelBW,MCS=mcs,TXOPLimit=txop);
    end

    % Create MLD config objects for AP MLD, STR STA MLD
    apMLDCfg = wlanMultilinkDeviceConfig(Mode="AP",LinkConfig=apLinkCfg);
    staSTRMLDCfg = wlanMultilinkDeviceConfig(Mode="STA",LinkConfig=staSTRLinkCfg);
   
    
    
    % Create the AP MLD node, STR STA MLD node
    apNode = wlanNode(Position=apPosition,Name="AP",DeviceConfig=apMLDCfg, PHYAbstractionMethod=phyAbstraction,MACFrameAbstraction=macAbstraction);
      
    
    staNode= wlanNode( ...
        Position=staPosition, ...
        Name="STR STA ", ...
        DeviceConfig=staSTRMLDCfg, ...
        PHYAbstractionMethod=phyAbstraction, ...
        MACFrameAbstraction=macAbstraction);
           
   
    if isFullBuffer
        % Associate the STAs to AP MLD and configure uplink full buffer traffic
        associateStations(apNode,staNode,FullBufferTraffic="UL");
    else
        associateStations(apNode,staNode);
        [pktSize, dataRate, onTime, offTime] = generateTrafficParams(maxThr, 1, expectedLoad);
        
        trafficSource = networkTrafficOnOff(DataRate=dataRate,PacketSize=pktSize,OnTime=onTime,OffTime=offTime);       
        addTrafficSource(staNode,trafficSource,DestinationNode=apNode);
        
    end
    

    staNodesList = cell(1, numLinks);
    for linkIdx = 1:numLinks
        % Create AP OBSS 
        numSTA = expectedOccupancies(linkIdx) * 10;
        if numSTA > 0
            [staOBSSpositions, apOBSSposition] = randomPositionsFermat(numSTA, radiusList(linkIdx));
            obssAPCfg = wlanDeviceConfig(Mode="AP", MCS=mcs, BandAndChannel=bandAndChannel(linkIdx,:),ChannelBandwidth=channelBW, TransmissionFormat="EHT-SU");
            apNodes(linkIdx) = wlanNode(Position=apOBSSposition, Name="OBSS AP " + linkIdx, DeviceConfig=obssAPCfg, PHYAbstractionMethod=phyAbstraction, MACFrameAbstraction=macAbstraction);
            
            %sta Config
            staCfg(linkIdx) = wlanDeviceConfig(Mode="STA", MCS=mcs, BandAndChannel=bandAndChannel(linkIdx,:),ChannelBandwidth=channelBW, TransmissionFormat="EHT-SU");
            
            [pktSize, dataRate, onTime, offTime] = generateTrafficParamsOBSS(maxThr);
    
            staNodesList{linkIdx} = wlanNode.empty;
            for staIdx = 1:numSTA
                staNodesList{linkIdx}(staIdx) = wlanNode(Position=staOBSSpositions(staIdx,:), Name="OBSS STA " + linkIdx + "." + staIdx, DeviceConfig=staCfg(linkIdx), PHYAbstractionMethod=phyAbstraction, MACFrameAbstraction=macAbstraction);
                
            end
            
            associateStations(apNodes(linkIdx), staNodesList{linkIdx})
                
            for staIdx = 1:numSTA
                trafficObss(staIdx) = networkTrafficOnOff(DataRate=dataRate, PacketSize=pktSize, OnTime=onTime, OffTime=offTime);
                addTrafficSource(staNodesList{linkIdx}(staIdx), trafficObss(staIdx), DestinationNode=apNodes(linkIdx));
                
            end
        end
    end

    if numSTA < 1
        nodes = [staNode apNode];

    else

        % flatten
        flattenedStaNodes = [staNodesList{:}];
        staNodes = [ staNode flattenedStaNodes ];
        nodes = [staNodes apNode apNodes ];
    end


    % Add channel model to the simulator
    channel = hSLSTGaxMultiFrequencySystemChannel(nodes, PathLossModel = 'residential');
    addChannelModel(networkSimulator,channel.ChannelFcn);

    % Add nodes to network simulator
    addNodes(networkSimulator,nodes);

    % Create node performance visualization object
    perfViewerObj = hPerformanceViewer(nodes,simulationTime);

    % Run the simulation
    run(networkSimulator,simulationTime);
   
    % Calculate throughput at STAs
    %apThroughput = throughput(perfViewerObj,apNode.ID);
    staThroughput = throughput(perfViewerObj, staNode.ID);
    avgLatency = averageReceiveLatency(perfViewerObj, apNode.ID);
    thr = staThroughput;

    
