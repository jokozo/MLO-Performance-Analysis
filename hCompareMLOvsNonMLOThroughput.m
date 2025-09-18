function hCompareMLOvsNonMLOThroughput
    %hCompareMLOvsNonMLOThroughput Plot throughputs of different types of
    %stations(STAs) in a simulation
    %
    %   hCompareMLOvsNonMLOThroughput shows the throughputs of different types
    %   of STAs associated to the same access point (AP) in a bar graph. The
    %   types of STAs are STA multi-link device (MLD) operating in simultaneous
    %   transmit receive (STR) mode, STA MLD operating in enhanced multi-link
    %   single radio (EMLSR) mode and non-MLD.

    %   Copyright 2024 The MathWorks, Inc.

    % Set seed of random number generator for reproducible results
    rng(1,"combRecursive");
    % Set simulation time
    simulationTime = 1;

    % Create wireless network simulator
    networkSimulator = wirelessNetworkSimulator.init;
    % Band and channel values for each link
    bandAndChannel = [2.4 1;5 36];

    % Create the link config objects for AP MLD, STR STA MLD, EMLSR STA MLD
    apLinkCfg = wlanLinkConfig(BandAndChannel=bandAndChannel,NumTransmitAntennas=2,NumSpaceTimeStreams=2,MCS=3);
    staSTRLinkCfg = wlanLinkConfig(BandAndChannel=bandAndChannel,NumTransmitAntennas=2,NumSpaceTimeStreams=2,MCS=3);
    staEMLSRLinkCfg = wlanLinkConfig(BandAndChannel=bandAndChannel,NumTransmitAntennas=1,NumSpaceTimeStreams=1,MCS=3);

    % Create MLD config objects for AP MLD, STR STA MLD, EMLSR STA MLD
    apMLDCfg = wlanMultilinkDeviceConfig(Mode="AP",LinkConfig=apLinkCfg);
    staSTRMLDCfg = wlanMultilinkDeviceConfig(Mode="STA",LinkConfig=staSTRLinkCfg);
    staEMLSRMLDCfg = wlanMultilinkDeviceConfig(Mode="STA",LinkConfig=staEMLSRLinkCfg,EnhancedMultilinkMode="EMLSR");

    % Create the AP MLD node, STR STA MLD node, EMLSR STA MLD node
    apNode = wlanNode(Position=[0 0 0],Name="AP",DeviceConfig=apMLDCfg);
    staNodes(1) = wlanNode(Position=[10 0 0],Name="STR STA",DeviceConfig=staSTRMLDCfg);
    staNodes(2) = wlanNode(Position=[0 10 0],Name="EMLSR STA",DeviceConfig=staEMLSRMLDCfg);

    % Create a device config object for non-MLD STA
    staDeviceConfig = wlanDeviceConfig(Mode="STA",BandAndChannel=bandAndChannel(1,:),...
        NumTransmitAntennas=2,NumSpaceTimeStreams=2,MCS=3,TransmissionFormat="EHT-SU");

    % Create a non-MLD STA
    staNodes(3) = wlanNode(Position=[0 0 10],Name="Non-MLD STA",DeviceConfig=staDeviceConfig);

    nodes = [apNode staNodes];

    % Associate the STAs to AP MLD and configure uplink full buffer traffic
    associateStations(apNode,staNodes,FullBufferTraffic="UL");

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
    staThroughputs = throughput(perfViewerObj,[staNodes(:).ID]);

    %% Plot the STA throughputs as a bar graph
    fig = figure;
    matlab.graphics.internal.themes.figureUseDesktopTheme(fig);
    % Names of the bars
    modes = ["MLO-STR" "MLO-EMLSR" "Non-MLO"];
    % Plot a bar graph specifying the width of bar (40% of available bar width)
    % and face color
    b = bar(modes,staThroughputs,0.4,'FaceColor','flat');
    % RGB triplets for second and third bars
    b.CData(2,:) = [0.8 0.3 0.1];
    b.CData(3,:) = [0.9 0.6 0.1];
    title("UL Throughput at STAs Operating in Different MLO Modes");
    ylabel("MAC Throughput (Mbps)");
end