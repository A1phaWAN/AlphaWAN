# 📂 `Gateway_config/README.md`

## 📶 Gateway Setup Guide (RAK7268)

This guide explains how to configure RAK7268 gateways for use in AlphaWAN. We provide two alternative methods: (1) Local console configuration and (2) Remote configuration. These steps assume you have already deployed the ChirpStack Network Server (see `../Network_server/README.md`) and completed channel planning.

### ✅ Prerequisites

- RAK7268 powered on
- Computer connected via Wi-Fi or LAN


## 1. Access Gateway Console

1. Connect to the gateway's Wi-Fi AP (e.g., `RAK7268_xx`)
2. Open browser: [http://192.168.230.1](http://192.168.230.1/)
3. Login: (default: `root` / `admin`)


## 2. Set Packet Forwarder

1. Go to **LoRa Packet Forwarder** or **LoRa Settings**
2. Set:
    - **Server Address**: your ChirpStack host IP (e.g., `192.168.1.100`)
    - **Port**: `1700`
3. Save and reboot gateway

Check ChirpStack → Gateways tab to confirm it is connected.

## 3. Apply Channel Configurations

Use `gw_config.csv` from the channel planner to assign frequencies.

### Method A: Local Console (Web UI)

1. Navigate to **LoRa Settings → Channel Plan**
2. Manually enter the frequencies for each channel slot

### Method B: Remote via WisDM

1. Register your gateway on WisDM portal
2. Go to **LoRa → Frequency Plan**
3. Upload values based on `gw_config.csv`

**Note:** You can also via SSH to configure gateway channel configurations. 

#### **You can update your deivces through [the Official Website](https://docs.rakwireless.com/firmware/), or use the files in our repository `WisGateOS2_Latest_Firmware`**

## References

- [RAK7268 User Manual](https://docs.rakwireless.com/product-categories/wisgate/rak7268v2/quickstart/)
- [ChirpStack Gateway Bridge Docs](https://www.chirpstack.io/docs/guides/connect-gateway.html)
- [WisDM Management Platform](https://www.rakwireless.com/en-us/products/wisdm)
