# **Towards Next-Generation Global IoT: Empowering Massive Connectivity with Harmonious Multi-Network Coexistence**

## Overview

AlphaWAN addresses the decoder contention problem in LoRaWANs, enhancing capacity and coexistence among networks. This repository contains the key components, deployment instructions, and evaluation scripts to implement AlphaWAN and reproduce the results presented in our SIGCOMM 2025 paper.

We include setup guides for the **network server**, **gateways**, and **nodes**. Operators can follow the example provided to generate and apply optimized channel configurations suitable for their network devices.

## Repository Structure

```graphql
AlphaWAN/
├── Network_server/        # ChirpStack deployment and example for channel planning
├── Gateway_cfg/        # Instructions for configuring RAK7268 gateways
├── Node_cfg/           # End-node codes and setup guide
├── Evaluation/            # Scripts and data for results reproduction
└── README.md              # This file
```

## Getting Started

If you're new, follow the manual in each directory:

1. [Set up ChirpStack and run channel planning](https://github.com/A1phaWAN/AlphaWAN/blob/main/Network_server/README.md)
2. Configure your gateways
3. Deploy end devices
4. Evaluate with trace or hardware

## Requirements

### 🔩 Hardware

- **Server**: A workstation with Ethernet/WiFi connectivity for gateway backhaul and ChirpStack hosting.
- **Gateways**: COTS LoRaWAN gateways (e.g., WisGate RAK7268CV2).
    
    *Minimum: 3 gateways.*
    
- **LoRa Nodes**: SX1276 radios (e.g., Dragino LoRa Shield) with Arduino Uno boards.
    
    *Recommended: ≥ 48 nodes for full-scale evaluation.*
    

### 💻 Software

- **MATLAB**: R2023b
- **Arduino IDE**: v1.8.X
- **Docker Desktop**: v4.35.X (for Windows OS)
- **Operating System**: Windows 10 or Ubuntu 22.04 LTS

## Reproducing Results

If you don’t have enough experimental devices, you can still evaluate AlphaWAN through our provided data traces and experiment scripts under `Evaluation/`. Refer to readme in the corresponding folders for details.

### Contact

For questions, issues, or requests, please contact:

Ziyue Zhang - ziyue.zhang@connect.polyu.hk

Ruonan Li - ruo-nan.li@connect.polyu.hk

### Citation

```bibtex
@inproceedings{Zhang2025AlphaWAN,
 title     = {Towards Next-Generation Global IoT: Empowering Massive Connectivity with Harmonious Multi-Network Coexistence},
 author    = {Ziyue Zhang, Xianjin Xia, Ruonan Li, and Yuanqing Zheng},
 booktitle = {Proceedings of the ACM SIGCOMM 2025 Conference},
 year      = {2025},
 doi       = {https://doi.org/10.1145/3718958.3750504}
 }
```
## Deployment Guide

## Network Server Deployment and Channel Planning Manual

This guide explains how to set up the ChirpStack LoRaWAN network server and run AlphaWAN's channel planning program. You will launch the server stack using Docker and generate gateway-specific channel configurations. Two network server files are included in this folder for reference, for more issues please access [Chirpstack official website](https://www.chirpstack.io/docs/index.html) for details. 

### ✅ Prerequisites

- Docker & Docker Compose installed
- Python 3.8+
- Git


## 1. Clone Repository and Launch ChirpStack

```
git clone https://github.com/chirpstack/chirpstack-docker.git
cd chirpstack-docker
docker-compose up
```

Wait for all services to start. You can check with:

```
docker ps
```

### Access ChirpStack Web UI:

Open your browser: [http://localhost:8080](http://localhost:8080/)

Default credentials:

- Email: `admin@chirpstack.io`
- Password: `admin`


## 2. Run Channel Planning Program

This repository provides a channel planner implemented in MATLAB.

**MATLAB Usage**

```
Channel_planning(numCH, ND, GW, CH_perGW)
```

This means:

- `numCH`: Total number of available LoRa channels
- `ND`: Number of concurrently transmitting nodes
- `GW`: Number of deployed gateways
- `CH_perGW`: Number of channels each gateway can support

### Output

- `gw_config.csv`: Optimized channel assignments for each gateway

You can use this output to configure gateways manually or via ChirpStack.

## 3. ChirpStack Configuration Steps

The following steps guide you through basic ChirpStack configuration. For full documentation, refer to ChirpStack Docs.

1. **Login to the ChirpStack Web UI**
    
    Navigate to `http://localhost:8080` and login with your credentials.
    
2. **Create a Network Server**
    - Navigate to **Network Servers**
    - Click **Create**
    - Set name (e.g., `localhost-server`)
    - Set **Network Server hostname** as `localhost:8000` or the docker internal IP
3. **Create a Service Profile**
    - Navigate to **Service Profiles**
    - Click **Create**
    - Name it (e.g., `default-service`)
    - Select the network server you just created
    - Keep defaults unless you need specific settings
4. **Create a Device Profile**
    - Navigate to **Device Profiles**
    - Click **Create**
    - Choose LoRaWAN MAC version (e.g., 1.0.3)
    - LoRaWAN Regional Parameters version (e.g., RP002-1.0.1)
    - Select default or custom settings matching your end-node firmware (e.g., Dragino SX1276)
5. **Create an Application**
    - Navigate to **Applications**
    - Click **Create**
    - Name it (e.g., `AlphaWAN-Test`)
6. **Register Devices**
    - Inside the application, click **Create device**
    - Provide a name and unique DevEUI
    - Assign previously created device profile
    - Choose OTAA or ABP activation mode

After registering devices and powering on nodes, you can verify uplinks in the **Live LoRaWAN Frames** tab.

Now you're ready to proceed to the gateway and node setup.