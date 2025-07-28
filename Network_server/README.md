# 📂 `Network_server/README.md`

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

## References

- [ChirpStack, open-source LoRaWAN® Network Server](https://www.chirpstack.io/)
