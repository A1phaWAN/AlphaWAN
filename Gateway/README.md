# Gateway Setup Guide (RAK7268)

This guide explains how to configure RAK7268 gateways for use in AlphaWAN. We provide two alternative methods: (1) Local console configuration and (2) Remote configuration. These steps assume you have already deployed the ChirpStack Network Server (see `../Network_server/README.md`) and completed channel planning.

## Prerequisites

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

### Method A: Local Console

1. Connect to the gateway's Wi-Fi AP and access browser: [192.168.230.1](http://192.168.230.1/)
2. Navigate to **LoRa Settings → Channel Plan**
3. Manually enter the frequencies for each channel slot

### Method B: Remote via WisDM

1. Register your gateway on WisDM portal
2. Go to **LoRa → Frequency Plan**
3. Upload values based on `gw_config.csv`

**Note:** You can also via SSH to configure gateway channel configurations. 

## 4. Firmware Update 
### Manual Update
If you want to update the firmware manually, you can only do it through **Wisgate OS2**.

1. Download  the latest firmware of the gateway and unzip it.

2. Drag and drop the file in the Drop your RWI file here or choose file form, or click the choose file link to browse for the file `.rwi`.

3. Drag and drop the file in the Drop your RWI file here or choose file form, or click the choose file link to browse for the file.

4. Click Update to initiate the flashing process.

5. After the upgrade is complete, log in to the gateway and check the Firmware tab to confirm that the installed firmware version is correct.

#### **Why Can't I Upgrade?**

If you are unable to update the firmware from the **Firmware tab**, it may be because the update is managed by WisDM.

**if the gateway is:**

- **Registered in WisDM**  
- **Allow WisDM Integration** is enabled  
- **Enable FOTA** is turned on  

The firmware update option will be locked because it is centrally managed by WisDM.

**To enable manual firmware updates:**

- Go to **WisDM tab**.  
- Turn off **Enable FOTA**.  
- Save the settings.  

Once FOTA is disabled, the firmware update option in the **Firmware tab** will be unlocked, and you can proceed with the manual update.

### Automatic Updates

turned on **Enable FOTA** on WisDM.

#### **You can update your deivces through [the Official Website](https://docs.rakwireless.com/firmware/), or use the files in our repository `WisGateOS2_Latest_Firmware`**
Please review this **[document](https://docs.rakwireless.com/product-categories/software-apis-and-libraries/wisgateos2/overview/#how-to-upgrade-firmware)** in detail.  


## References

- [RAK7268 User Manual](https://docs.rakwireless.com/product-categories/wisgate/rak7268v2/quickstart/)
- [ChirpStack Gateway Bridge Docs](https://www.chirpstack.io/docs/guides/connect-gateway.html)
- [WisDM Management Platform](https://www.rakwireless.com/en-us/products/wisdm)
