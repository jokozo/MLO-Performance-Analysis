# MLO Performance Analysis

This repository contains MATLAB code used in Master's Thesis titled ***"Performance Analysis of Multi-Link Operation in IEEE 802.11 Networks"***.

## Structure
The repository is structured as follows.
- `scenarios\` - contains MATLAB functions with simulation scenarios based on articles related to MLO. The files are named using the following pattern: `MLO_<DOI number>.m`, with the exceptions:
  - MLO_VR.m based on the [article](https://arxiv.org/pdf/2407.05802) about MLO and XR,
  - basicMLO.m  
- `loops\` - contains MATLAB loops used to run simulations with varying parameters.
- `supporting_func\` - contains MATLAB functions created in order to simplify the configuration of simulation scenarios.
- `praca_mgr_Joanna_Koziol.pdf` - Master's Thesis.

## How to run simulations

In order to run simulations you need to install MATLAB with following libraries: 
- WLAN Toolbox
- Communications Toolbox
- DSP System Toolbox 
- MATLAB Compiler 
- Parallel Computing Toolbox 
- Signal Processing Toolbox

### Steps

1. Open the example project  
   Copy and paste the following command into the MATLAB Command Window:  
   **openExample('wlan/BeSystemLevelSimulationUsingEMLSRMultiLinkOperationExample')**.<br>
   This command downloads the directory with an example and helper functions necessary to run simulations from the [MATLAB website](https://www.mathworks.com/help/wlan/ug/802-11be-system-level-simulation-using-emlsr-multi-link-operation.html).
3. Add files from this repository
   Once the directory is created, copy all MATLAB files from this repository into that directory.
4. Run the simulations.
  
