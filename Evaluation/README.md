# 📂 `Evaluation/README.md`

## 📊 Results Reproduction Guide

This directory contains the script and data necessary to reproduce the evaluation of LoRaWAN network capacity as presented in the paper.

### ✅ Prerequisites

- MATLAB

---

### Contents:

- `Maximum_capability.m`: The main MATLAB script to reproduce the evaluation.
- `Collected_data/`: Dataset used for the capacity evaluation, including raw experiment logs and parsed CSV files.

### Instructions:

1. **Environment Requirements**:
    - MATLAB R2021a or later is recommended.
    - No external toolboxes are required beyond base MATLAB functions.
2. Reproduction:
    - Open MATLAB and navigate to this directory.
    - Run the script:
        
        ```matlab
        Maximum_capability
        ```
        
    - The script loads experiment traces from the `Collected_data` folder and processes them to generate evaluation plots.

This component enables reproducibility of the LoRaWAN capacity evaluation using the provided traces and custom MATLAB script.

### Deploy AlphaWAN Network Server

AlphaWAN is built on top of ChirpStack. We provide reference files to establish the Chirpstack network server under `Network_server/`.

### Steps

1. Clone this repository and navigate to the server directory:
    
    ```bash
    git clone https://github.com/chirpstack/chirpstack-docker.git
    cd chirpstack-docker
    ```
    
2. Launch ChirpStack (includes Network Server, Application Server, and Gateway Bridge):
    
    ```bash
    docker-compose up
    ```
    
3. Open your browser and access the ChirpStack Web UI at http://localhost:8080
4. Login using the default credentials (see `docker-compose.yml` or `env` file for actual values, e.g., `admin@chirpstack.io / admin`), then create the following:
    - **Network Server**
    - **Service Profile**
    - **Device Profile**
    - **Application**
    - **End Device registrations (e.g., OTAA/ABP)**

Refer to ChirpStack documentation if unfamiliar with these steps.

### Run the Channel Planning

We provide an example channel planning script to generate gateway-specific configuration files based on a network topology.

- Go to `Network_server/Channel_Planning/`
- Run the provided static example in matlab:   (should have some inputs. for different gateway and node conditions. please refer to the readme in that folder to see details. )
    
    ```bash
    Channel_planning.p
    ```
    

This script outputs a `gw_config.csv` file which contains optimized channel settings for each gateway. The inputs can be adjusted to reflect your deployment topology, including each Gateway’s channel configurations

### 2️⃣ Apply Gateway Channel Plans

### 2.1 Connect Gateways to Chirpstack

- Ensure each gateways (e.g., RAK7268) have:
    - Internet access (via Ethernet or Wi-Fi)
    - Proper packet forwarder configuration to forward UDP packets to the host running ChirpStack
    - Registered **Gateway ID** (EUI) in ChirpStack Web UI

For RAK gateways:

- Log into the web interface (usually `192.168.230.1`)
- Under **LoRa Packet Forwarder**, set:
    - **Server address** = your ChirpStack server IP
    - **Ports**: `1700` (default UDP port)
    - Save and reboot the gateway

### 2.2 Configure Gateways (RAK7268 Examples)

**Method A: Local Console Configuration**

1. Connect to gateway Wi-Fi (model name and No. )
2. Connect to gateway IP in browser (default: `192.168.230.1`)
3. LoRa → Channel Settings
4. Manually configure frequencies based on `gw_config.csv`

**Method B: Remote Management via WisDM**

1. Register the gateway on WisDM
2. Navigate to LoRa Settings → Frequency Plan
3. Apply channel configurations from `gw_config.csv`

> For other gateway models, refer to their vendor documentation. AlphaWAN is compatible with any COTS LoRaWAN gateways supporting channel config updates.
> 

### 3️⃣ Deploy Nodes and Observe Performance

### Setup

- Compile codes from `Node_config/` to SX1276 + Arduino boards
- Register each device in ChirpStack
- Confirm OTAA join or ABP registration

### Experiment

- Power up all nodes
- Check ChirpStack “Live LoRaWAN Frames” to confirm reception
- Download gateway logs to see received packets
- Evaluate packet reception under different loads and interference