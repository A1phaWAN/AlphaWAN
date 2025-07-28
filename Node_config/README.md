# End Devices Configuration

This document provides a step-by-step guide to configure LoRaWAN end devices (nodes) to work with the AlphaWAN deployment, including modified channel plans, duty cycle settings, and frequency configurations. This guide assumes you have already completed the deployment of the network server and gateways as described in previous sections.


## 1. Hardware Requirements

- LoRaWAN-compatible development board (e.g., Arduino + RFM95 or STM32 + SX1276)
- USB cable for programming
- Computer with Arduino IDE (or PlatformIO)

## 2. Install the LoRaWAN Library

This node firmware depends on the [MCCI LoRaWAN LMIC library](https://github.com/mcci-catena/arduino-lmic). To install it:

### In Arduino IDE:

1. Open Arduino IDE
2. Go to **Tools > Manage Libraries...**
3. Search for **"MCCI LoRaWAN LMIC"** and choose **"MCCI LoRaWAN LMIC Library"**
4. Click **Install**

Or, clone it directly into your `libraries/` folder:

```
git clone https://github.com/mcci-catena/arduino-lmic.git
```

## 3. Configuration Overview

The firmware is customized to work with AlphaWAN's modified channel and duty cycle plan. Specifically:

- **Channel Frequencies**: Narrowband channels are manually configured in `lmic_as923.c`
- **Data Rates**: Configured in `lmic_as923.c` with AlphaWAN’s channel planning output
- **Duty Cycles**: Compliant with regional ISM band limits

## 4. Setup Instructions

### 4.1 Set Region Parameters

Open `lmic_project_config.h` and confirm the following parameters match your region and AlphaWAN deployment:

```
#define REGION_EU868  1      // or REGION_US915, REGION_AS923 etc.
```

### 4.2 Set DevEUI/AppEUI/AppKey

Register the node in ChirpStack, then copy the credentials into the testing codes:

```
static const u1_t DEV_EUI[8] = { ... };
static const u1_t APP_EUI[8] = { ... };
static const u1_t APP_KEY[16] = { ... };
```

### 4.3 Modify Channel Plan

Open `lmic_as923.c`. Replace the default channels with the output of channel planning code. Example:

```
enum { NUM_DEFAULT_CHANNELS = 1};
static CONST_TABLE(u4_t, iniChannelFreq)[NUM_DEFAULT_CHANNELS] = {
        //923200000 | BAND_CENTI,
        932400000 | BAND_CENTI
};
```

Ensure only the selected subset of frequencies are enabled for AlphaWAN. Disable default TTN/LoRaWAN frequencies if necessary.

### 5.4 Compile and Upload

Use the Arduino IDE to compile `AlphaWAN_Node.ino` and upload to the device.


## 6. Validation and Testing

- Monitor ChirpStack for join requests and uplink messages
- Check the gateway log for packet reception and channel mapping
- Validate duty cycle compliance in your experimental setup

## 7. Notes

- Uplink interval and payload size must adhere to the regional duty cycle rules
- For multi-node testing, ensure DevEUIs and channels are unique to avoid collisions


## 8. Troubleshooting

| Issue | Solution |
| --- | --- |
| Node fails to join | Confirm keys in `AlphaWAN_Node.ino` match ChirpStack registration |
| Messages not received | Check `lmic_as923.c` and match with gateway channel frequencies |
| Duty cycle violation | Reduce uplink frequency and packet size |


For advanced modifications or adding support for downlink responses, refer to the LMIC documentation or extend `AlphaWAN_Node.ino` accordingly.

## References

- [MCCI Arduino LoRaWAN Library](https://github.com/mcci-catena/arduino-lorawan)
- [LA66 LoRaWAN Shield User Manual](https://wiki.dragino.com/xwiki/bin/view/Main/User%20Manual%20for%20LoRaWAN%20End%20Nodes/LA66%20LoRaWAN%20Shield%20User%20Manual/#H1.5A0Example:UseATCommandtocommunicatewithLA66moduleviaArduinoUNO.)
