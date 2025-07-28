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
2. Log in and navigate to **Configuration**
3. On the left side, head to LoRa and click **Configuration tab**. By default, the gateway is configured to work as a Built-in network server.
4. Choose the **Work Mode** according to your server type.
**Note:** For different server configuration methods, please refer to this **[document](https://docs.rakwireless.com.cn/Product-Categories/WisGate/RAK7268-V2/Supported-LoRa-Network-Servers/)**.
5. Scroll down to find **Frequency Plan**, Select your country or region to choose the radio frequency band
6. Manually enter the frequencies for each channel slot(if need, usually automatically configured)
7. Click **Save changes** to save the changes.
8. Upload values based on `gw_config.csv`
**Note:** `gw_config.csv` is used to indicate which channels each gateway uses.
9. If everything is set correctly, the gateway will display as online. You can click the gateway name to inspect the gateway traffic.

---

### Method B: Remote via WisDM

1. Register your gateway on WisDM portal
2. Create an Organization and fill in some basic information for the organization.
3. Add a location by clicking the **New Location** button.
4. Choose the **Work Mode** and the band that the **Region** will operate on
**Note:** For different server configuration methods, please refer to this **[document](https://docs.rakwireless.com.cn/Product-Categories/WisGate/RAK7268-V2/Supported-LoRa-Network-Servers/)**.
5. Click the **Advanced frequency settings** button and manually enter the frequencies for each channel slot(if need, usually automatically configured)
6. Click **Save changes** to save the changes.
7. Upload values based on `gw_config.csv`
**Note:** `gw_config.csv` is used to indicate which channels each gateway uses.

---

#### You can also via SSH to configure gateway channel configurations. 

## 4. Firmware Update 
### Manual Update
If you want to update the firmware manually, you can only do it through **Wisgate OS2**.

1. Download  the latest firmware of the gateway and unzip it.

2. Drag and drop the file in the Drop your RWI file here or choose file form, or click the choose file link to browse for the file `.rwi`.

3. Drag and drop the file in the Drop your RWI file here or choose file form, or click the choose file link to browse for the file.

4. Click Update to initiate the flashing process.

5. After the upgrade is complete, log in to the gateway and check the Firmware tab to confirm that the installed firmware version is correct.

---

### **Q: Why Can't I Upgrade?**

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

---

### Automatic Updates

Turned on **Enable FOTA** in WisDM.

---

#### **You can get the firmware package through [the Official Website](https://docs.rakwireless.com/firmware/), or use the files in our repository `WisGateOS2_Latest_Firmware`**

#### For more details on firmware updates, please refer to this **[document](https://docs.rakwireless.com/product-categories/software-apis-and-libraries/wisgateos2/overview/#how-to-upgrade-firmware)**.  


## References

- [RAK7268 User Manual](https://docs.rakwireless.com/product-categories/wisgate/rak7268v2/quickstart/)
- [ChirpStack Gateway Bridge Docs](https://www.chirpstack.io/docs/guides/connect-gateway.html)
- [WisDM Management Platform](https://www.rakwireless.com/en-us/products/wisdm)
