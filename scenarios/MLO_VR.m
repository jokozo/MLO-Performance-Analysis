function latency = MLO_VR(simTime, randnum, radius, channelBW, bandAndChannel, mcs, numSTA, isDownlink, isMLO)
   

    % Set seed of random number generator for reproducible results
    rng(randnum,"combRecursive");
    % Set simulation time
    simulationTime = simTime;
   
    staNodes = wlanNode.empty();
    staIndex=1;
    phyAbstraction="tgax-evaluation-methodology";
    macAbstraction = true;
    aggregationLimit = 1024;
    % Create wireless network simulator
    networkSimulator = wirelessNetworkSimulator.init;
    % Band and channel values for each link
    %bandAndChannel = [5 1;5 136];
    numLinks = size(bandAndChannel,1);
    
    [staPositions, apPosition] = randomPositionsFermat(numSTA, radius);

    
    if isMLO
        % Create the link config objects for AP MLD, STR STA MLD
        for linkIdx = 1:numLinks
            apLinkCfg(linkIdx) = wlanLinkConfig(BandAndChannel=bandAndChannel(linkIdx,:),ChannelBandwidth=channelBW,MCS=mcs, NumSpaceTimeStreams=2, NumTransmitAntennas=2, MPDUAggregationLimit=aggregationLimit);
            staSTRLinkCfg(linkIdx) = wlanLinkConfig(BandAndChannel=bandAndChannel(linkIdx,:),ChannelBandwidth=channelBW,MCS=mcs, NumSpaceTimeStreams=2, NumTransmitAntennas=2, MPDUAggregationLimit=aggregationLimit);
        end
    
        % Create MLD config objects for AP MLD, STR STA MLD
        apMLDCfg = wlanMultilinkDeviceConfig(Mode="AP",LinkConfig=apLinkCfg);
        staSTRMLDCfg = wlanMultilinkDeviceConfig(Mode="STA",LinkConfig=staSTRLinkCfg);
       
        % Create the AP MLD node, STR STA MLD node
        apNode = wlanNode(Position=apPosition,Name="AP",DeviceConfig=apMLDCfg, PHYAbstractionMethod=phyAbstraction,MACFrameAbstraction=macAbstraction);
        if numSTA>0   
            for i = 1:numSTA
                staNodes(staIndex) = wlanNode( ...
                    Position=staPositions(staIndex, :), ...
                    Name="STR STA " + i, ...
                    DeviceConfig=staSTRMLDCfg, ...
                    PHYAbstractionMethod=phyAbstraction, ...
                    MACFrameAbstraction=macAbstraction);
                staIndex = staIndex + 1;
            end
        end

    else
        apSLOCfg = wlanDeviceConfig(Mode="AP", MCS=mcs, BandAndChannel=bandAndChannel(1,:),ChannelBandwidth=channelBW, TransmissionFormat="EHT-SU",MPDUAggregationLimit=aggregationLimit);
        staSLOCfg = wlanDeviceConfig(Mode="STA", MCS=mcs, BandAndChannel=bandAndChannel(1,:),ChannelBandwidth=channelBW, TransmissionFormat="EHT-SU",MPDUAggregationLimit=aggregationLimit);
    
        apNode = wlanNode(Position=apPosition,Name="AP",DeviceConfig=apSLOCfg, PHYAbstractionMethod=phyAbstraction,MACFrameAbstraction=macAbstraction);
        if numSTA>0   
            for i = 1:numSTA
                staNodes(staIndex) = wlanNode( ...
                    Position=staPositions(staIndex, :), ...
                    Name="SLO STA " + i, ...
                    DeviceConfig=staSLOCfg, ...
                    PHYAbstractionMethod=phyAbstraction, ...
                    MACFrameAbstraction=macAbstraction);
                staIndex = staIndex + 1;
            end
        end

    end

  
    nodes = [apNode staNodes];
    
    % Associate the STAs to AP MLD and configure uplink full buffer traffic
    if isDownlink
        associateStations(apNode,staNodes);
        trafficSource = networkTrafficOnOff(DataRate=100e6,PacketSize=1500,OnTime=11e-6,OffTime=11e-3);       
        addTrafficSource(apNode,trafficSource,DestinationNode=staNodes)
    else
        associateStations(apNode,staNodes);
        trafficSource = networkTrafficOnOff(DataRate=100e6,PacketSize=200,OnTime=16e-6,OffTime=3e-3);       
        addTrafficSource(staNodes,trafficSource,DestinationNode=apNode)
    end

    % Add channel model to the simulator
    channel = hSLSTGaxMultiFrequencySystemChannel(nodes);
    addChannelModel(networkSimulator,channel.ChannelFcn);

    % Add nodes to network simulator
    addNodes(networkSimulator,nodes);

    % Create node performance visualization object
    perfViewerObj = hPerformanceViewer(nodes,simulationTime);

    % Run the simulation
    run(networkSimulator,simulationTime);
   
    % Calculate throughput at STAs
    if isDownlink
        latency75list = getpPacketLatencyVector(perfViewerObj, 75);
        latency = latency75list(2,:);
        %latency = throughput(perfViewerObj, apNode.ID);
    else
        latency90list = getpPacketLatencyVector(perfViewerObj, 90);
        latency = latency90list(1,:);
        %latency = averageReceiveLatency(perfViewerObj, apNode.ID);
    end

    
